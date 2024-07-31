// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';

class NoteItem extends StatelessWidget {
  final Notes note;

  const NoteItem({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 12,
                  child: Image.asset(
                    'assets/profile.png',
                    color: red3,
                  )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        note.reporter!.name ?? '',
                        style: TextStyleList.text10,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatDateTimePlus(note.createdAt ?? ''),
                        style: TextStyleList.subtext1,
                      ),
                    ],
                  ),
                  Text(
                    note.text ?? '',
                    style: TextStyleList.subtext3,
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                  // if (note.attachments != null && note.attachments!.isNotEmpty)
                  //   Text(
                  //     'Attachments: ${note.attachments![0].filename}',
                  //     style: TextStyleList.subtext3,
                  //   ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const AppDivider(),
        const SizedBox(height: 10),
      ],
    );
  }
}
