import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toyotamobile/Models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';

class LoginController extends GetxController {
  final LoginModel _loginModel = LoginModel();
  final HomeController jobController = Get.put(HomeController());
  final UserController userController = Get.put(UserController());
  var isTextHidden = false.obs;

  void toggleVisibility() {
    isTextHidden.value = !isTextHidden.value;
  }

  void setEmail(String username) {
    _loginModel.email.value = username;
  }

  void setPassword(String password) {
    _loginModel.password.value = password;
  }

  void clearUsernameAndPassword() {
    _loginModel.email.value = "";
    _loginModel.password.value = "";
  }

  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'User': _loginModel.email.value,
          'Password': _loginModel.password.value,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final accessToken = responseData['access_token'] as String;
        await fetchAndStoreTokenData(accessToken);
      } else {
        Get.snackbar(
            'เข้าสู่ระบบผิดพลาด', 'ชื่อผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  Future<void> fetchAndStoreTokenData(String accessToken) async {
    try {
      final response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          'Access-Token': accessToken,
        },
      );

      if (response.statusCode == 201) {
        final tokenResponseData = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        prefs.setString('verify', 'pass');
        prefs.setString('access_token', accessToken);
        prefs.setString('token_response', json.encode(tokenResponseData));
        String? tokenResponse = prefs.getString('token_response');
        Map<String, dynamic> tokenData = json.decode(tokenResponse ?? '');
        prefs.setString('token', tokenData['token']);
        getDeviceTypeAndCreateFCMToken(
            tokenData['token'], tokenData['user']['id']);
        jobController.subJobAssigned.clear();
        jobController.pmItems.clear();
        jobController.fetchDataFromAssignJob();
        userController.fetchData();
        Get.offAll(() => BottomBarView());
        Get.snackbar('เข้าสู่ระบบสำเร็จ', 'ยินดีต้อนรับสู่ T-Service');
      } else {
        Get.snackbar('Error', 'Could not retrieve data');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching token data: $e');
      Get.snackbar('Error', 'Error fetching token data');
    }
  }

  Future<void> getDeviceTypeAndCreateFCMToken(
      String accessToken, int userId) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceType;
    String deviceId;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    // Determine device type and get device ID
    if (Platform.isAndroid) {
      deviceType = 'Android';
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      deviceType = 'iOS';
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? 'Unknown'; // iOS device ID
    } else {
      deviceType = 'Unknown';
      deviceId = 'Unknown';
    }

    // Request notification permission and get FCM token
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      if (token != null) {
        Map<String, dynamic> body = {
          "user_id": userId,
          "token": token,
          "device_id": deviceId,
          "device_type": deviceType,
          "created_at": DateTime.now().toString(),
          "app_version": version,
        };
        try {
          final response = await http.post(
            Uri.parse(createUserTokenNotification()),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': accessToken,
            },
            body: jsonEncode(body),
          );

          if (response.statusCode == 201) {
            print('Data created successfully');
          } else if (response.statusCode == 200) {
            print('Data updated successfully');
          } else {
            print(response.statusCode);
          }
        } catch (e) {
          // ignore: avoid_print
          print('Error fetching token data: $e');
        }
      }
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
