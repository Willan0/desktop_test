import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/utils/extension.dart';
import '../constant/assets.dart';
import '../constant/color.dart';
import '../constant/dimen.dart';

class CustomDropDownTextField extends StatelessWidget {
  const CustomDropDownTextField({
    super.key,
    required this.dropDownList,
    required this.onChange,
    required this.hintText,
  });

  final String hintText;
  final List<DropDownValueModel> dropDownList;
  final Function(dynamic value)? onChange;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBackGroundColor,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: context.responsive(kAs5x, lg: kAs8x, md: kAs5x)),
        child: DropDownTextField(
          listTextStyle: const TextStyle(
            fontSize: kFs14x,
            fontFamily: poppin,
          ),
          textStyle: const TextStyle(
            fontSize: kFs14x,
            fontFamily: roboto,
          ),
          dropDownItemCount: dropDownList.length,
          enableSearch: true,
          clearIconProperty: IconProperty(color: kPrimaryColor),
          padding: const EdgeInsets.all(kAs10x),
          textFieldDecoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: kAs5x, bottom: kAs5x),
            hintText: hintText,
          ),
          dropDownList: dropDownList,
          onChanged: (value) =>
              onChange == null ? (value) {} : onChange!(value),
        ),
      ),
    );
  }
}
