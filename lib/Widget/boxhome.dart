// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:toyotamobile/Styles/boxdecoration.dart';
// import 'package:toyotamobile/Styles/text.dart';
// import 'package:toyotamobile/Widget/sizedbox_widget.dart';
// import 'package:toyotamobile/Widget/statusbutton_widget.dart';

// class BoxHome extends StatelessWidget {

// BoxHome ({

// })

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       padding: EdgeInsets.all(10),
//       decoration: CustomBoxDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 'JobID : ${job.jobid}',
//                 style: TextStyleList.detail1,
//               ),
//               10.wH,
//               StatusNewButton(),
//               Spacer(),
//               Obx(
//                 () => IconButton(
//                   icon:
//                       expandedIndex.value == jobController.jobList.indexOf(job)
//                           ? Image.asset('assets/arrowup.png')
//                           : Image.asset('assets/arrowdown.png'),
//                   onPressed: () {
//                     if (expandedIndex.value ==
//                         jobController.jobList.indexOf(job)) {
//                       expandedIndex.value = -1;
//                     } else {
//                       expandedIndex.value = jobController.jobList.indexOf(job);
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             job.detail,
//             style: TextStyleList.detail2,
//           ),
//           5.kH,
//           Row(
//             children: [
//               Icon(Icons.calendar_month_outlined),
//               5.wH,
//               Text(
//                 job.getFormattedDate(),
//                 style: TextStyleList.detail3,
//               ),
//             ],
//           ),
//           5.kH,
//           Row(
//             children: [
//               Icon(Icons.location_on_outlined),
//               5.wH,
//               Text(
//                 job.location,
//                 style: TextStyleList.detail3,
//               ),
//               5.wH,
//               Row(
//                 children: [
//                   GoogleMapButton(
//                     onTap: () {},
//                   )
//                 ],
//               ),
//             ],
//           ),
//           10.kH,
//           Obx(() => expandedIndex.value == jobController.jobList.indexOf(job)
//               ? Padding(
//                   padding: EdgeInsets.only(top: 10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 0.5,
//                         color: Color(0xFFEAEAEA),
//                       ),
//                       10.kH,
//                       Text('Ticket ID #${job.ticketid}',
//                           style: TextStyleList.detail1),
//                       5.kH,
//                       Text(
//                         job.problem,
//                         style: TextStyleList.detail2,
//                       ),
//                       5.kH,
//                       Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: Decoration2(),
//                           child: Column(
//                             children: [
//                               WarrantyInfo(
//                                 title: "Name/Model",
//                                 value: "UBRE200H2-TH-7500",
//                               ),
//                               3.kH,
//                               WarrantyInfo(
//                                 title: "Serial Number",
//                                 value: "6963131",
//                               ),
//                               3.kH,
//                               WarrantyInfo(
//                                 title: "Warranty Status",
//                                 value: '',
//                                 trailing: CheckStatus(
//                                   imagePath: 'assets/pass.png',
//                                   text: 'Active',
//                                   textColor: pass,
//                                 ),
//                               ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 )
//               : SizedBox())
//         ],
//       ),
//     );
//   }
// }
