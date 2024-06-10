import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Account/EditProfile/editprofile_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key});

  @override
  Widget build(BuildContext context) {
    EditProfileController editProfileController =
        Get.put(EditProfileController());
    UserController userController = Get.put(UserController());

    return Scaffold(
      backgroundColor: white4,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
              backgroundColor: white3,
              title: Text('Profile', style: TextStyleList.title1),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (userController.userInfo.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxContainer(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      radius: 27,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/profile.png',
                          fit: BoxFit.cover,
                          width: 54,
                          height: 54,
                        ),
                      ),
                    ),
                  ),
                  16.kH,
                  Text(
                    'User Information',
                    style: TextStyleList.subtitle2,
                  ),
                  16.kH,
                  TextFormFieldBar(
                    label: 'Name',
                    controller: editProfileController.name,
                  ),
                  12.kH,
                  TextFormFieldBar(
                    label: 'Email',
                    controller: editProfileController.email,
                  ),
                  12.kH,
                  TextFormFieldBar(
                    label: 'Phone number',
                    controller: editProfileController.phoneNumber,
                    type: TextInputType.phone,
                  ),
                  12.kH,
                  TextFormFieldVisible(
                    label: 'Password',
                    controller: editProfileController.password,
                    isTextHidden: editProfileController.isTextHidden,
                    hiddenChange: () =>
                        editProfileController.toggleVisibility(),
                  ),
                  12.kH,
                  CustomButton(
                    onPressed: () => editProfileController.showEditDialog(
                      context,
                      'Are you sure to confirm?',
                      'No',
                      'Yes',
                    ),
                    text: 'Save',
                    background: red1,
                    textStyle: TextStyleList.text13,
                  ),
                  2.kH,
                  CustomButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                    background: white3,
                    textStyle: TextStyleList.text19,
                  ),
                ],
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
