import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Screen/Account/EditProfile/editprofile_view.dart';
import 'package:toyotamobile/Screen/Account/Language/language_view.dart';
import 'package:toyotamobile/Screen/Account/account_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController accountController = Get.put(AccountController());
    UserController userController = Get.put(UserController());

    return Scaffold(
      backgroundColor: white4,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
              backgroundColor: white3,
              title: Text(context.tr('account'), style: TextStyleList.title1),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (userController.userInfo.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => const EditProfileView());
                },
                child: Stack(
                  children: [
                    BoxContainer(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userController.userInfo.first.realName,
                                    style: TextStyleList.subtitle1,
                                  ),
                                  Text(
                                    '${context.tr('join_on')} ${getFormattedDate2(userController.userInfo.first.createdAt)}',
                                    style: TextStyleList.subtext1,
                                  ),
                                  6.kH,
                                  EditButton2(onTap: () {
                                    Get.to(() => const EditProfileView());
                                  }),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      right: 16.0,
                      top: -40,
                      bottom: 0,
                      child: Center(
                        child: Image.asset('assets/arrowright.png'),
                      ),
                    ),
                  ],
                ),
              ),
              8.kH,
              // BoxContainer(
              //   children: [
              //     TitleWithButton2(
              //       titleText: 'My Task History',
              //       onTap: () {
              //         Get.to(() => const TaskHistoryView());
              //       },
              //       button: true,
              //     )
              //   ],
              // ),
              BoxContainer(
                children: [
                  TitleWithButton2(
                    titleText: context.tr('language'),
                    onTap: () {
                      Get.to(() => LanguageView());
                    },
                    button: true,
                  )
                ],
              ),
              // BoxContainer(
              //   children: [
              //     TitleWithButton2(
              //       titleText: 'Logout',
              //       onTap: () {
              //         accountController.showLogoutDialog(
              //           context,
              //           'Are you sure to logout?',
              //           'Cancel',
              //           'Yes,Log out',
              //         );
              //       },
              //       button: false,
              //     )
              //   ],
              // ),
              BoxContainer(
                children: [
                  TitleWithButton2(
                    titleText: context.tr('delete_account'),
                    onTap: () {
                      accountController.showDeleteDialog(
                        context,
                        context.tr('delete_account_message'),
                        context.tr('cancel'),
                        context.tr('yes'),
                      );
                    },
                    button: false,
                    font: TextStyleList.text17,
                  )
                ],
              ),
              Obx(() => accountController.version.value != ''
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${context.tr('version')} : ${accountController.version.value}',
                            style: TextStyleList.subtext1,
                          )
                        ],
                      ),
                    )
                  : Container())
            ],
          );
        } else {
          return const Center(
            child: CircleLoading(),
          );
        }
      }),
    );
  }
}
