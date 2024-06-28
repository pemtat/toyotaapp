import 'package:get/get.dart';

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

void updateCheckbox(String label, RxList<String> data) {
  if (data.contains(label)) {
    data.remove(label);
  } else {
    data.add(label);
  }
}

void updateCheckbox2(String label, RxList<String> data) {
  if (data.isEmpty) {
    data.add(label);
  } else {
    data.clear();
    data.add(label);
  }
}

void updateSelection(int index, String value, RxList<String> selectionsChoose) {
  selectionsChoose[index] = value;
}
