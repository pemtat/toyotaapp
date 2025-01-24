import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Models/sparepartseach.dart';
import 'package:toyotamobile/Models/sparepartseachdetails_model.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/extensions/context_extension.dart';

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

String checkTextFormIc(String data) {
  if (data == '1') {
    return '✓';
  } else if (data == '2') {
    return 'X';
  } else if (data == '3') {
    return '—';
  } else if (data == '4') {
    return 'O';
  } else if (data == '5') {
    return 'Ø';
  } else {
    return '';
  }
}

void updateCheckbox3other(
    String label, RxList<String> data, Rx<TextEditingController> other) {
  data.clear();
  other.value.clear();
  data.add(label);
}

void updateCheckbox4other(String label, RxList<String> data,
    Rx<TextEditingController> other, Rx<TextEditingController> other2) {
  data.clear();
  other.value.clear();
  other2.value.clear();
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
  String? token = await getToken();

  try {
    final response = await http.get(
      Uri.parse(getSparePartSearch(placeNumber)),
      headers: {'Authorization': token ?? ''},
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

Future<void> getSparePartDetails(
    String placeNumber, Rx<TextEditingController> salesPrice) async {
  RxList<ProductDetails> productsDetails = <ProductDetails>[].obs;
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
      productsDetails.clear();
      List<dynamic> responseData = jsonDecode(response.body);

      productsDetails.value =
          responseData.map((job) => ProductDetails.fromJson(job)).toList();
      salesPrice.value.text = productsDetails.first.salesPrice.toString();
    } else {
      salesPrice.value.text = '0';
    }
  } catch (e) {
    salesPrice.value.text = '0';
  }
}

Future<Map<String, String>?> fetchProductsReturn(
    String placeNumber, RxList<Product> products) async {
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

      if (products.isNotEmpty) {
        return {
          'inventory': products.first.inventory.toString(),
          'model': products.first.model,
          'no': products.first.no,
        };
      } else {
        return null;
      }
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Exception occurred: $e');
    return null;
  }
}

Future<String> fetchProductsReturnString(String placeNumber) async {
  if (placeNumber != '-') {
    String username = usernameProduct;
    String password = passwordProduct;

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    RxList<ProductDetails> products = <ProductDetails>[].obs;

    try {
      final response = await http.get(
        Uri.parse(getSparePartbySearch(placeNumber)),
        headers: {'Authorization': basicAuth},
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);

        products.value =
            responseData.map((job) => ProductDetails.fromJson(job)).toList();

        if (products.isNotEmpty) {
          return products.first.inventory.toString();
        } else {
          return '0';
        }
      } else {
        print('Error: ${response.statusCode}');
        return '0';
      }
    } catch (e) {
      print('Exception occurred: $e');
      return '0';
    }
  } else {
    return '0';
  }
}

Future<String> fetchProductsReturnString2(String placeNumber) async {
  String? token = await getToken();
  RxList<Product> products = <Product>[].obs;
  if (placeNumber != '-') {
    try {
      final response = await http.get(
        Uri.parse(getSparePartSearch(placeNumber)),
        headers: {'Authorization': token ?? ''},
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);

        products.value =
            responseData.map((job) => Product.fromJson(job)).toList();

        if (products.isNotEmpty) {
          return products.first.inventory.toString();
        } else {
          return '0';
        }
      } else {
        print('Error: ${response.statusCode}');
        return '0';
      }
    } catch (e) {
      print('Exception occurred: $e');
      return '0';
    }
  } else {
    return '0';
  }
}

String getTranslateText(
    RxList<String> data, BuildContext context, String option) {
  int displayCount = 3;
  List<String> words = [];
  Map<String, String> transMap = {};

  if (option == 'wCode') {
    transMap = {
      'CM': context.tr('cm'),
      'CMC': context.tr('cmc'),
      'WA': context.tr('wa'),
      'AC': context.tr('ac'),
      'FF': context.tr('ff'),
      'SOT': context.tr('sot'),
      'MO': context.tr('mo'),
      'SB': context.tr('sb'),
      'CO': context.tr('co'),
    };
  } else if ((option == 'rCode')) {
    transMap = {
      'Broken': context.tr('broken'),
      'Lack of grease': context.tr('lack_of_grease'),
      'Lack of oil': context.tr('lack_of_oil'),
      'Incorrect Assembly': context.tr('incorrect_assembly'),
      'Dirty': context.tr('dirty'),
      'Worn out': context.tr('worn_out'),
      'Short circuit': context.tr('short_circuit'),
      'Corroded': context.tr('corroded'),
      'Vibration': context.tr('vibration'),
      'Mechanically Locked': context.tr('mechanically_locked'),
      'Leakage': context.tr('leakage'),
      'Loose': context.tr('loose'),
      'Abnormal noise': context.tr('abnormal_noise'),
      'Missing part': context.tr('missing_part'),
      'Overheated': context.tr('overheated'),
      'Other': context.tr('other'),
    };
  }
  for (var item in data) {
    if (option == 'rCode') {
      words.add(transMap.containsKey(item) ? transMap[item]! : item);
    } else {
      int spaceIndex = item.indexOf(' ');
      String key = spaceIndex != -1 ? item.substring(0, spaceIndex) : item;
      words.add(transMap.containsKey(key) ? transMap[key]! : item);
    }
  }
  if (words.length <= displayCount) {
    return words.join(' ');
  } else {
    String displayedItems = words.sublist(0, displayCount).join(' ');
    int remainingCount = words.length - displayCount;
    return '$displayedItems +$remainingCount more';
  }
}

String getTranslateTextString(
    String data, BuildContext context, String option) {
  List<String> words = [];
  Map<String, String> transMap = {};

  if (option == 'wCode') {
    transMap = {
      'CM': context.tr('cm'),
      'CMC': context.tr('cmc'),
      'WA': context.tr('wa'),
      'AC': context.tr('ac'),
      'FF': context.tr('ff'),
      'SOT': context.tr('sot'),
      'MO': context.tr('mo'),
      'SB': context.tr('sb'),
      'CO': context.tr('co'),
    };
  } else if (option == 'rCode') {
    transMap = {
      'Broken': context.tr('broken'),
      'Lack of grease': context.tr('lack_of_grease'),
      'Lack of oil': context.tr('lack_of_oil'),
      'Incorrect Assembly': context.tr('incorrect_assembly'),
      'Dirty': context.tr('dirty'),
      'Worn out': context.tr('worn_out'),
      'Short circuit': context.tr('short_circuit'),
      'Corroded': context.tr('corroded'),
      'Vibration': context.tr('vibration'),
      'Mechanically Locked': context.tr('mechanically_locked'),
      'Leakage': context.tr('leakage'),
      'Loose': context.tr('loose'),
      'Abnormal noise': context.tr('abnormal_noise'),
      'Missing part': context.tr('missing_part'),
      'Overheated': context.tr('overheated'),
      'Other': context.tr('other'),
    };
  }

  List<String> items = data.split(',');

  for (var item in items) {
    item = item.trim();
    if (option == 'rCode') {
      words.add(transMap.containsKey(item) ? transMap[item]! : item);
    } else {
      int spaceIndex = item.indexOf(' ');
      String key = spaceIndex != -1 ? item.substring(0, spaceIndex) : item;
      words.add(transMap.containsKey(key) ? transMap[key]! : item);
    }
  }

  return words.join(', ');
}
