import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/sparepartseach.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:http/http.dart' as http;

String getDisplayString(RxList<String> data) {
  int displayCount = 3;
  if (data.length <= displayCount) {
    return data.join(', ');
  } else {
    String displayedItems = data.sublist(0, displayCount).join(', ');
    int remainingCount = data.length - displayCount;
    return '$displayedItems +$remainingCount more';
  }
}

String getDisplayString2(List<String> data) {
  int displayCount = 3;
  if (data.length <= displayCount) {
    return data.join(', ');
  } else {
    String displayedItems = data.sublist(0, displayCount).join(', ');
    int remainingCount = data.length - displayCount;
    return '$displayedItems +$remainingCount more';
  }
}

String getDisplayString3(RxList<String> data) {
  int displayCount = 3;

  List<String> filteredData = data.where((item) => item != 'Other').toList();

  if (filteredData.length <= displayCount) {
    return filteredData.join(', ');
  } else {
    String displayedItems = filteredData.sublist(0, displayCount).join(', ');
    int remainingCount = filteredData.length - displayCount;
    return '$displayedItems +$remainingCount more';
  }
}

String getDisplayString4(RxList<String> data) {
  int displayCount = 3;
  if (data.length <= displayCount) {
    return data
        .asMap()
        .entries
        .map((entry) => '${entry.key + 1}. ${entry.value}')
        .join('\n');
  } else {
    String displayedItems = data
        .sublist(0, displayCount)
        .asMap()
        .entries
        .map((entry) => '${entry.key + 1}. ${entry.value}')
        .join('\n');
    int remainingCount = data.length - displayCount;
    return '$displayedItems\n+$remainingCount more';
  }
}

void updateCheckbox(String label, RxList<String> data) {
  if (data.contains(label)) {
    data.remove(label);
  } else {
    data.add(label);
  }
}

void updateCheckbox2(String label, RxList<String> data) {
  if (data.isEmpty || data.first == '-') {
    data.clear();
    data.add(label);
  } else if (data.first != '-') {
    data.clear();
    data.add('-');
  }
}

void updateCheckbox3(String label, RxList<String> data) {
  data.clear();
  data.add(label);
}

void updateCheckbox3other(
    String label, RxList<String> data, Rx<TextEditingController> other) {
  data.clear();
  other.value.clear();
  data.add(label);
}

void updateSelection(int index, String value, RxList<String> selectionsChoose) {
  selectionsChoose[index] = value;
}

void updateSelectionSub(
  int index,
  String value,
  RxList<List<String>> selectionsChoose,
  int subIndex,
) {
  selectionsChoose[index][subIndex] = value;
  selectionsChoose.refresh();
}

Future<void> fetchProducts(
    String placeNumber, RxBool isLoading, RxList<Product> products) async {
  isLoading(true);
  String username = usernameProduct;
  String password = passwordProduct;

  String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  try {
    final response = await http.get(
      Uri.parse(getSparePartbySearch(placeNumber)),
      headers: {'Authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);

      products.value =
          responseData.map((job) => Product.fromJson(job)).toList();
    } else {
      print('type search');
    }
  } finally {
    isLoading(false);
  }
}
