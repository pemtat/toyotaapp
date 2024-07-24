import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Account/EditProfile/editprofile_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

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
          var userData = userController.userInfo.first;
          editProfileController.name.value.text = userData.name;
          editProfileController.email.value.text =
              userData.email == '' ? '-' : userData.email;
          editProfileController.phoneNumber.value.text =
              userData.phoneNo == '' ? '-' : userData.phoneNo;
          editProfileController.resourceNo.value.text = userData.resourceNo;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BoxContainer(
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        radius: 32,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/profile.png',
                            fit: BoxFit.cover,
                            width: 64,
                            height: 64,
                          ),
                        ),
                      ),
                    ),
                    16.kH,
                    Text(
                      'Tech Information',
                      style: TextStyleList.subtitle2,
                    ),
                    16.kH,
                    TextFormFieldBar(
                      label: 'Name',
                      controller: editProfileController.name.value,
                    ),
                    16.kH,
                    TextFormFieldBar(
                      label: 'Email',
                      controller: editProfileController.email.value,
                    ),
                    16.kH,
                    TextFormFieldBar(
                      label: 'Phone Number',
                      controller: editProfileController.phoneNumber.value,
                    ),
                    16.kH,
                    TextFormFieldBar(
                      label: 'Resource No',
                      controller: editProfileController.resourceNo.value,
                    ),

                    // TextFormFieldVisible(
                    //   label: 'Password',
                    //   controller: editProfileController.password,
                    //   isTextHidden: editProfileController.isTextHidden,
                    //   hiddenChange: () =>
                    //       editProfileController.toggleVisibility(),
                    // ),
                    // 12.kH,
                    // CustomButton(
                    //   onPressed: () => editProfileController.showEditDialog(
                    //     context,
                    //     'Are you sure to confirm?',
                    //     'No',
                    //     'Yes',
                    //   ),
                    //   text: 'Save',
                    //   background: red1,
                    //   textStyle: TextStyleList.text13,
                    // ),
                    // 2.kH,
                    // CustomButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   text: 'Cancel',
                    //   background: white3,
                    //   textStyle: TextStyleList.text19,
                    // ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
