import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/constant/assets.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/issue_stock/item_type.dart';
import 'package:desktop_test/provider/home_page_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:desktop_test/widgets/easy_text_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_drop_down_text_field.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget(
      {super.key,
      required this.filter,
      required this.textEditingController,
      this.isNeedCategory = true,
      this.hintText});
  final Function({DateTime? startDate, DateTime? endDate, String? category})
      filter;
  final TextEditingController textEditingController;
  final bool isNeedCategory;
  final String? hintText;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<ItemType>? itemTypes;
  DateTime? startDate;
  DateTime? endDate;
  String category = '';

  late HomePageProvider _homePageProvider;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    _homePageProvider = context.watch<HomePageProvider>();
    if (!_isInitialized) {
      _homePageProvider.getItemTypes();
    }
    itemTypes = _homePageProvider.itemTypes;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kAs20x),
        child: context.responsive(
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EasyText(
                      text: 'Filter ',
                      fontSize: kFs25x,
                      fontFamily: roboto,
                    ),
                    const SizedBox(
                      width: kAs5x,
                    ),
                    DatePickerView(
                      selectDate: (date) {
                        startDate = date ?? DateTime.now();
                        widget.filter(
                            startDate: startDate,
                            endDate: endDate,
                            category: category);
                        setState(() {});
                      },
                      date: startDate,
                    ),
                    const SizedBox(
                      width: kAs5x,
                    ),
                    DatePickerView(
                      selectDate: (date) {
                        setState(() {
                          endDate = date ?? DateTime.now();
                        });
                        widget.filter(
                            startDate: startDate,
                            endDate: endDate,
                            category: category);
                      },
                      date: endDate,
                    ),
                  ],
                ),
                const SizedBox(
                  height: kAs10x,
                ),
                SizedBox(
                    height: kAs50x,
                    child: SearchView(
                      textEditingController: widget.textEditingController,
                      hintText:
                          widget.hintText ?? "Type voucher code or customer",
                      onSubmit: (String? value) {
                        widget.filter(
                            startDate: startDate,
                            endDate: endDate,
                            category: category);
                      },
                    )),
                const SizedBox(
                  height: kAs10x,
                ),
                widget.isNeedCategory
                    ? SizedBox(
                        width: kAs150x,
                        height: kAs45x,
                        child: CategoryView(
                          itemTypes: itemTypes ?? [],
                          onChange: (value) {
                            if (value != "") {
                              category = value.value;
                              widget.filter(
                                  startDate: startDate,
                                  endDate: endDate,
                                  category: category);
                            } else {
                              category = '';
                              widget.filter(
                                  startDate: startDate,
                                  endDate: endDate,
                                  category: category);
                            }
                          },
                        ))
                    : const SizedBox()
              ],
            ),
            lg: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const EasyText(
                  text: 'Filter ',
                  fontSize: kFs25x,
                  fontFamily: roboto,
                ),
                const SizedBox(
                  height: kAs10x,
                ),
                Expanded(
                    child: SizedBox(
                        height: kAs50x,
                        child: SearchView(
                          textEditingController: widget.textEditingController,
                          hintText: widget.hintText ??
                              "Type voucher code or customer",
                          onSubmit: (String? value) {
                            widget.filter(
                                startDate: startDate,
                                endDate: endDate,
                                category: category);
                          },
                        ))),
                const SizedBox(
                  width: kAs10x,
                ),
                DatePickerView(
                  selectDate: (date) {
                    startDate = date;
                    widget.filter(
                        startDate: startDate,
                        endDate: endDate,
                        category: category);
                    setState(() {});
                  },
                  date: startDate,
                ),
                const SizedBox(
                  width: kAs10x,
                ),
                DatePickerView(
                  selectDate: (date) {
                    endDate = date ?? DateTime.now();
                    widget.filter(
                        startDate: startDate,
                        endDate: endDate,
                        category: category);
                    setState(() {});
                  },
                  date: endDate,
                ),
                const SizedBox(
                  width: kAs10x,
                ),
                widget.isNeedCategory
                    ? SizedBox(
                        width: kAs150x,
                        height: kAs45x,
                        child: CategoryView(
                          itemTypes: itemTypes ?? [],
                          onChange: (value) {
                            if (value != "") {
                              category = value.value;
                              widget.filter(
                                  startDate: startDate,
                                  endDate: endDate,
                                  category: category);
                            } else {
                              category = '';
                              widget.filter(
                                  startDate: startDate,
                                  endDate: endDate,
                                  category: category);
                            }
                          },
                        ))
                    : const SizedBox()
              ],
            ),
            md: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EasyText(
                      text: 'Filter ',
                      fontSize: kFs25x,
                      fontFamily: roboto,
                    ),
                    const Spacer(),
                    DatePickerView(
                      selectDate: (date) {
                        startDate = date;
                        widget.filter(
                            startDate: startDate,
                            endDate: endDate,
                            category: category);
                        setState(() {});
                      },
                      date: startDate,
                    ),
                    const SizedBox(
                      width: kAs10x,
                    ),
                    DatePickerView(
                      selectDate: (date) {
                        setState(() {
                          endDate = date ?? DateTime.now();
                        });
                        widget.filter(
                            startDate: startDate,
                            endDate: endDate,
                            category: category);
                      },
                      date: endDate,
                    ),
                    const SizedBox(
                      width: kAs10x,
                    ),
                    widget.isNeedCategory
                        ? SizedBox(
                            width: kAs150x,
                            height: kAs45x,
                            child: CategoryView(
                              itemTypes: itemTypes ?? [],
                              onChange: (value) {
                                if (value != "") {
                                  category = value.value;
                                  widget.filter(
                                      startDate: startDate,
                                      endDate: endDate,
                                      category: category);
                                } else {
                                  category = '';
                                  widget.filter(
                                      startDate: startDate,
                                      endDate: endDate,
                                      category: category);
                                }
                              },
                            ))
                        : const SizedBox(),
                    const SizedBox(
                      width: kAs20x,
                    ),
                  ],
                ),
                const SizedBox(
                  height: kAs5x,
                ),
                SizedBox(
                  width: getWidth(context),
                  height: kAs50x,
                  child: SearchView(
                    textEditingController: widget.textEditingController,
                    hintText:
                        widget.hintText ?? "Type voucher code or customer",
                    onSubmit: (String? value) {
                      widget.filter(
                          startDate: startDate,
                          endDate: endDate,
                          category: category);
                    },
                  ),
                )
              ],
            )));
  }
}

class SearchView extends StatelessWidget {
  const SearchView(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.onSubmit});
  final TextEditingController textEditingController;
  final String hintText;
  final Function(String? value)? onSubmit;
  @override
  Widget build(BuildContext context) {
    return EasyTextField(
      controller: textEditingController,
      hintText: hintText,
      onFieldSubmitted: (value) => onSubmit!(value),
    );
  }
}

class DatePickerView extends StatelessWidget {
  const DatePickerView(
      {super.key, required this.selectDate, required this.date});

  final Function(DateTime? date) selectDate;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return child!;
          },
        );
        if (pickedDate != null && pickedDate != DateTime.now()) {
          selectDate(pickedDate);
        }
      },
      child: Container(
        height: context.responsive(kAs45x, lg: kAs50x, md: kAs45x),
        padding:
            const EdgeInsets.symmetric(horizontal: kAs10x, vertical: kAs5x),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(kAs10x)),
            border: Border.all(color: Colors.grey.withOpacity(0.5))),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: kAs20x,
              color: kPrimaryTextColor.withOpacity(0.6),
            ),
            const SizedBox(
              width: kAs5x,
            ),
            Text(
              DateFormat('dd/MM/yyyy').format(date ?? DateTime.now()),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.itemTypes, this.onChange});

  final List<ItemType> itemTypes;
  final Function(dynamic value)? onChange;

  @override
  Widget build(BuildContext context) {
    List<DropDownValueModel> dropDownList = itemTypes
        .map((e) =>
            DropDownValueModel(name: e.typeName ?? '', value: e.typeCode))
        .toList();
    return CustomDropDownTextField(
        hintText: "Choose Type",
        dropDownList: dropDownList,
        onChange: onChange);
  }
}
