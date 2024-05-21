import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundapp,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Column(
            children: [
              AppBar(
                backgroundColor: buttontextcolor,
                title: Text('Account', style: TextStyleList.topbar),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                BoxContainer(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 27,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/man.jpg',
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
                              'Chalermchai',
                              style: TextStyleList.title,
                            ),
                            Text(
                              'Joined on March 12, 2018',
                              style: TextStyleList.detail3,
                            ),
                            6.kH,
                            EditButton2(onTap: () {}),
                          ],
                        )),
                      ],
                    )
                  ],
                ),
                Positioned(
                  right: 10.0,
                  top: -40,
                  bottom: 0,
                  child: Center(
                    child: Image.asset('assets/arrowright.png'),
                  ),
                ),
              ],
            ),
            8.kH,
            BoxContainer(
              children: [
                TitleWithButton2(
                  titleText: 'My Task History',
                  onTap: () {},
                  button: true,
                )
              ],
            ),
            BoxContainer(
              children: [
                TitleWithButton2(
                    titleText: 'Language', onTap: () {}, button: true)
              ],
            ),
            BoxContainer(
              children: [
                TitleWithButton2(
                    titleText: 'Logout', onTap: () {}, button: false)
              ],
            ),
            BoxContainer(
              children: [
                TitleWithButton2(
                    titleText: 'Delete Account',
                    onTap: () {},
                    button: false,
                    font: TextStyleList.textbutton)
              ],
            ),
          ],
        ));
  }
}
