import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Service/api.dart';

checkWarranty(
    String serialNumber, RxList<WarrantyInfo> warrantyInfoList) async {
  String username = usernameProduct;
  String password = passwordProduct;

  String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  final String checkWarranty = checkWarrantyBySerial(serialNumber);
  final response = await http.get(
    Uri.parse(checkWarranty),
    headers: {'Authorization': basicAuth},
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    String productName = data['NameTruck'] ?? '-';
    String serial = data['Serial'] ?? '-';
    String model = data['Model'] ?? '-';
    int warrantyStatus = data['WarrantyStatus'] ?? 0;
    WarrantyInfo warrantyInfo = WarrantyInfo(
      productName: productName,
      serial: serial,
      model: model,
      warrantyStatus: warrantyStatus,
    );

    warrantyInfoList.add(warrantyInfo);
  }
}

Future<bool> checkWarrantyStatus(String serialNumber) async {
  String username = usernameProduct;
  String password = passwordProduct;

  String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  final String checkWarranty = checkWarrantyBySerial(serialNumber);
  final response = await http.get(
    Uri.parse(checkWarranty),
    headers: {'Authorization': basicAuth},
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<RxList<WarrantyInfo>> checkWarrantyReturn(
    String serialNumber, RxList<WarrantyInfo> warrantyInfoList) async {
  String username = usernameProduct;
  String password = passwordProduct;

  String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  final String checkWarranty = checkWarrantyBySerial(serialNumber);
  final response = await http.get(
    Uri.parse(checkWarranty),
    headers: {'Authorization': basicAuth},
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    String productName = data['NameTruck'] ?? '';
    String serial = data['Serial'] ?? '';
    String model = data['Model'] ?? 'Unknown';
    int warrantyStatus = data['WarrantyStatus'] ?? 0;
    WarrantyInfo warrantyInfo = WarrantyInfo(
      productName: productName,
      serial: serial,
      model: model,
      warrantyStatus: warrantyStatus,
    );

    warrantyInfoList.add(warrantyInfo);
    return warrantyInfoList;
  } else {
    return warrantyInfoList;
  }
}
