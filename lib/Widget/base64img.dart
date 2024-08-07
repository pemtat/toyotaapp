import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/ticketdata.dart';

class AttachmentsListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> attachments;
  final String? option;
  final String? jobid;
  final String? pmjobid;
  final bool? edit;
  final String? createdBy;

  const AttachmentsListWidget(
      {super.key,
      required this.attachments,
      this.option,
      this.jobid,
      this.pmjobid,
      this.createdBy,
      this.edit});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: attachments.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> attachment = entry.value;
          return Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    _showImageDialog(context, attachment['content']);
                  },
                  child: Base64ImageWidget(attachment['content']),
                ),
                if (edit == true)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (pmjobid != null &&
                            option != null &&
                            createdBy != null) {
                          attachments.removeAt(index);
                          try {
                            deletePMImage(jobid ?? '', attachment['id'],
                                option ?? '', createdBy ?? '');
                          } catch (e) {
                            print('sucessful');
                          }
                        } else if (jobid != null && option != null) {
                          attachments.removeAt(index);
                          deleteImgSubJob(
                              jobid ?? '', attachments, option ?? '');
                        } else {
                          attachments.removeAt(index);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Base64ImageWidget extends StatelessWidget {
  final String base64String;

  const Base64ImageWidget(this.base64String, {super.key});

  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes = base64Decode('ZXJyb3I=');
    try {
      imageBytes = base64Decode(base64String);
    } catch (e) {
      print(e);
    }
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: MemoryImage(imageBytes),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

void _showImageDialog(BuildContext context, String base64String) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Uint8List imageBytes = base64Decode(base64String);
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Dialog(
          backgroundColor: const Color.fromARGB(0, 68, 137, 255),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Hero(
                tag: base64String,
                child: Image.memory(
                  imageBytes,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
