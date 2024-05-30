import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/checklevel.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';

class NoteItem extends StatelessWidget {
  final Map<String, dynamic> note;

  const NoteItem({super.key, required this.note});

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
                backgroundColor: Colors.grey,
                radius: 12,
                child: FutureBuilder<String>(
                  future: checkLevel(note['reporter']['id']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      String accessLevel = snapshot.data!;
                      return Text(
                        accessLevel,
                        style: TextStyleList.text13,
                      );
                    }
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      note['reporter']['real_name'],
                      style: TextStyleList.text10,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      formatDateTime(note['created_at']),
                      style: TextStyleList.subtext1,
                    ),
                  ],
                ),
                Text(
                  note['text'],
                  style: TextStyleList.subtext3,
                ),
                if (note['attachments'] != null &&
                    note['attachments'].isNotEmpty)
                  Text(
                    'Attachments: ${note['attachments'][0]['filename']}',
                    style: TextStyleList.subtext3,
                  ),
              ],
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
