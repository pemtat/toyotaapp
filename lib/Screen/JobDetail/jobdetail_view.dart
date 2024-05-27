import 'package:flutter/material.dart';
import 'package:toyotamobile/Screen/Fillform/fillform_view.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/attachment_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/imgcontainer.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/statusbutton_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class TicketDetailPage extends StatelessWidget {
  final JobdetailController jobcontroller = Get.put(JobdetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(57.5),
          child: Column(
            children: [
              Stack(
                children: [
                  AppBar(
                    backgroundColor: white3,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Investigate machine',
                            style: TextStyleList.title1),
                        Text('JobID: 0001', style: TextStyleList.text16),
                      ],
                    ),
                    leading: const BackIcon(),
                  ),
                  const Positioned(
                    right: 15.0,
                    top: 15,
                    bottom: 0,
                    child: Center(
                      child: StatusNewButton(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              color: white4,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoxContainer(
                        children: [
                          const TitleApp(text: 'Intruction'),
                          Row(
                            children: [
                              Text(
                                'Step 1: Contact reporter',
                                style: TextStyleList.text4,
                              ),
                              3.wH,
                              Text('(Phone number: 0823424234)',
                                  style: TextStyleList.subtext3),
                            ],
                          ),
                          3.kH,
                          Wrap(
                            children: [
                              RichText(
                                  text: TextSpan(
                                text: 'Step 2 ',
                                style: TextStyleList.text4,
                                children: [
                                  TextSpan(
                                      text: 'Go to the machine',
                                      style: TextStyleList.text4),
                                  TextSpan(
                                      text: ' (Location: Onnut, Bangkok)   ',
                                      style: TextStyleList.subtext3),
                                  WidgetSpan(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GoogleMapButton(
                                          onTap: () {},
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                          3.kH,
                          Text(
                            'Step 3: Report to admin about machine',
                            style: TextStyleList.text4,
                          ),
                          3.kH,
                          Text(
                            'Step 4: Complete investigation',
                            style: TextStyleList.text4,
                          ),
                        ],
                      ),
                      8.kH,
                      BoxContainer(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TitleApp(text: 'Repair Report*'),
                              AddButton(
                                onTap: () {
                                  Get.to(() => const FillFormView());
                                },
                              ),
                            ],
                          ),
                          Text(
                            'Please fill the field service report',
                            style: TextStyleList.text16,
                          )
                        ],
                      ),
                      8.kH,
                      BoxContainer(children: [
                        Text(
                          'Summary of issue',
                          style: TextStyleList.text16,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Machine doesn\'t work at all and petrol is leaking since last week',
                                style: TextStyleList.text9,
                              ),
                            ),
                          ],
                        ),
                        8.kH,
                        const ImageRow(
                          imageUrls: [
                            'assets/smartphone.png',
                            'assets/smartphone.png',
                            'assets/smartphone.png',
                          ],
                        ),
                      ]),
                      BoxContainer(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'More Detail',
                              style: TextStyleList.text16,
                            ),
                            Image.asset('assets/arrowdown.png')
                          ],
                        ),
                      ]),
                      8.kH,
                      BoxContainer(
                        children: [
                          const TitleApp(text: "Machine Detail"),
                          8.kH,
                          const BoxInfo(
                            title: "Name/Model",
                            value: "UBRE200H2-TH-7500",
                          ),
                          3.kH,
                          const BoxInfo(
                            title: "Serial Number",
                            value: "6963131",
                          ),
                          3.kH,
                          const BoxInfo(
                            title: "Warranty Status",
                            value: '',
                            trailing: CheckStatus(
                              imagePath: 'assets/pass.png',
                              text: 'Active',
                              textColor: green1,
                            ),
                          ),
                          5.kH,
                          Row(
                            children: [
                              const AttachmentFile(name: 'Q1.pdf'),
                              7.wH,
                              const AttachmentFile(name: 'Q2.pdf'),
                              7.wH,
                              const AttachmentFile(name: 'Q3.pdf'),
                            ],
                          ),
                        ],
                      ),
                      8.kH,
                      const BoxContainer(children: [
                        TicketInfo(
                          ticketId: '123456',
                          dateTime: '12 March 2024, 08:15 PM',
                          reporter: 'Alex',
                        ),
                      ]),
                      8.kH,
                      BoxContainer(
                        children: [
                          const TitleApp(text: 'Notes'),
                          8.kH,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 12,
                                  child: Text('A', style: TextStyleList.text13),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Admin (Backoffice)',
                                            style: TextStyleList.text10),
                                        3.wH,
                                        Text(
                                          '13 March 2024, 11:39 AM',
                                          style: TextStyleList.subtext1,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Don\'t be late be late',
                                      style: TextStyleList.subtext3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          18.kH,
                          const AppDivider(),
                          18.kH,
                          TextFieldType(
                            hintText: 'Add Notes',
                            textSet: jobcontroller.notes.value,
                          ),
                          8.kH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/link.png'),
                                  4.wH,
                                  Text(
                                    'Attach file',
                                    style: TextStyleList.text1,
                                  ),
                                ],
                              ),
                              CustomElevatedButton(
                                onPressed: () {},
                                text: 'Submit',
                              ),
                            ],
                          ),
                        ],
                      ),
                      16.kH,
                      BoxContainer(paddingCustom: 10, children: [
                        EndButton(
                            onPressed: () {
                              jobcontroller.showCompletedDialog(
                                  context,
                                  'Successfully finished job on investigating!',
                                  'Not yet',
                                  'Yes, Completed');
                            },
                            text: 'Complete Investigating'),
                      ])
                    ],
                  ),
                ),
              ]))
        ])));
  }
}
