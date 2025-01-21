import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class SearchFilter extends StatelessWidget {
  final TextEditingController searchController;
  final RxString searchQuery;
  final List<Widget> statusCheckboxes;
  final Rx<DateTime?> selectedDate;
  final Function clearFilters;

  const SearchFilter(
      {super.key,
      required this.searchController,
      required this.searchQuery,
      required this.statusCheckboxes,
      required this.selectedDate,
      required this.clearFilters});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: paddingApp, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: context.tr('search_filter'),
                hintStyle: TextStyleList.detail1,
                filled: true,
                fillColor: black5,
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: white2,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
              ),
              onChanged: (value) {
                searchQuery.value = value;
              },
            ),
          ),
          8.wH,
          InkWell(
            onTap: () {},
            child: Theme(
              data: Theme.of(context).copyWith(
                popupMenuTheme: const PopupMenuThemeData(
                  color: white3,
                ),
              ),
              child: PopupMenuButton(
                offset: const Offset(0, 60),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 'edit',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status',
                              style: TextStyleList.text2,
                            ),
                            InkWell(
                                onTap: () {
                                  clearFilters();
                                },
                                child: Text(
                                  context.tr('reset'),
                                  style: TextStyleList.text1,
                                )),
                          ],
                        ),
                        ...statusCheckboxes,
                        8.kH,
                        const AppDivider(),
                        8.kH,
                        Text(
                          context.tr('date'),
                          style: TextStyleList.text2,
                        ),
                        8.kH,
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              selectedDate.value = pickedDate;
                            }
                          },
                          child: AbsorbPointer(
                            child: Obx(() => TextField(
                                  controller: TextEditingController(
                                    text: selectedDate.value != null
                                        ? "${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}"
                                        : '',
                                  ),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: context.tr('select_date'),
                                    hintStyle: TextStyleList.text5,
                                    suffixIcon:
                                        const Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        8.kH,
                      ],
                    ),
                  ),
                ],
                child: Stack(
                  children: [
                    Container(
                      decoration: Decoration2(),
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('assets/sliders.png'),
                    ),
                  ],
                ),
                onSelected: (value) {
                  if (value == 'edit') {}
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
