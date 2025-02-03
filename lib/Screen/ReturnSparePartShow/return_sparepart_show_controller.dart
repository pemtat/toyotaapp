import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Service/api.dart';

class ReturnSparepartController extends GetxController {
  final RxList<Sparepart> selectedSpareParts = <Sparepart>[].obs;
  final HomeController jobController = Get.put(HomeController());
  void updateReturnNo(int index, String newValue, List<Sparepart> spareparts) {
    spareparts[index].returnNo.value = newValue;
  }

  Future<void> createQuotation(BuildContext context, String bugId, String jobId,
      String handlerId, String projectId) async {
    String? token = await getToken();
    try {
      final Map<String, dynamic> data = {
        "bug_id": bugId,
        "job_issue_id": jobId,
        "project_id": projectId,
      };

      try {
        final response = await http.post(Uri.parse(createQuotationReturn()),
            headers: {
              'Authorization': '$token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data));

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Create Quotation Done');
        } else {
          print('Create Quotation Failed ${response.body}');
        }
      } catch (e) {
        print('Error occurred: $e');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateQuotation(
    BuildContext context,
    String bugId,
    String jobId,
    String handlerId,
    String projectId,
    String returnId,
    String refId,
  ) async {
    String? token = await getToken();
    try {
      final Map<String, dynamic> data = {
        "admin_id": 0,
        "admin_status": 0,
        "estimate_status": 1,
        "purchase_order_status": 1,
        'ref_id': refId,
        'return_id': returnId
      };

      try {
        final response = await http.post(Uri.parse(updateQuotationReturn()),
            headers: {
              'Authorization': '$token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data));

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Update Quotation Done');
        } else {
          print('Update Quotation Failed ${response.body}');
        }
      } catch (e) {
        print('Error occurred: $e');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveSparePart(BuildContext context, String bugId, String jobId,
      String handlerId, String projectId) async {
    String? token = await getToken();
    try {
      final List<Map<String, dynamic>> sparePartsUpdateList =
          selectedSpareParts.map((spare) {
        return {
          "spare_id": spare.id,
          "type": spare.type,
          "return_no": spare.returnNo.value,
        };
      }).toList();

      final Map<String, dynamic> data = {
        "bug_id": bugId,
        "job_issue_id": jobId,
        "project_id": projectId,
        "spare_part": sparePartsUpdateList
      };

      try {
        final response = await http.post(Uri.parse(updateReturnSparePart()),
            headers: {
              'Authorization': '$token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data));

        if (response.statusCode == 200 || response.statusCode == 201) {
          await jobController.fetchSubJobSparePartReturn(handlerId, 'tech');
          if (jobController.techLevel.value == '1') {
            await jobController.fetchSubJobSparePart(handlerId, 'tech');
          } else {
            await jobController.fetchSubJobSparePart(handlerId, 'techlead');
          }
          selectedSpareParts.clear();
          selectedSpareParts.refresh();

          print('Sparepart Updated successfully');
        } else {
          print('Failed to save sparepart: ${response.body}');
        }
      } catch (e) {
        print('Error occurred while saving sparepart: $e');
      }
    } catch (e) {
      print(e);
    }
  }
}
