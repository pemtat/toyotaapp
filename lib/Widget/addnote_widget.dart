import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/noteItem_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class AddNote extends StatelessWidget {
  final RxList<Notes> notesFiles;
  final List<String> notePic;
  final Rx<TextEditingController> notes;
  final RxList<Map<String, dynamic>> addAttatchments;
  final RxBool isPicking;
  final String? showOnly;
  final Function(Rx<TextEditingController>) addNote;
  const AddNote(
      {super.key,
      required this.notePic,
      required this.notesFiles,
      required this.notes,
      required this.addAttatchments,
      required this.isPicking,
      required this.addNote,
      this.showOnly});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      children: [
        Obx(() {
          if (notesFiles.isEmpty) {
            return Center(child: Container());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleApp(text: 'Notes'),
                8.kH,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notesFiles.length,
                  itemBuilder: (context, index) {
                    final note = notesFiles[index];
                    return NoteItem(
                      note: note,
                    );
                  },
                ),
              ],
            );
          }
        }),
        // if (showOnly == null)
        //   Column(
        //     children: [
        //       12.kH,
        //       TextFieldType(
        //         hintText: 'Add Notes',
        //         textSet: notes.value,
        //       ),
        //     ],
        //   ),
        // 8.kH,
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     GestureDetector(
        //       onTap: () {
        //         pickFile(addAttatchments, isPicking);
        //       },
        //       child: Row(
        //         children: [

        //           Obx(() {
        //             if (addAttatchments.isNotEmpty) {
        //               return Row(
        //                 children: [
        //                   4.wH,
        //                   Text(
        //                     addAttatchments.first['filename'],
        //                     style: TextStyleList.text1,
        //                   ),
        //                 ],
        //               );
        //             } else {
        //               return Container();
        //             }
        //           }),
        //         ],
        //       ),
        //     ),
        //     if (showOnly == null)
        //       CustomElevatedButton(
        //         onPressed: () {
        //           addNote(notes);
        //         },
        //         text: 'Submit',
        //       ),
        //   ],
        // ),
      ],
    );
  }
}
