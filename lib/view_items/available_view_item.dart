import 'package:flutter/material.dart';
import 'package:desktop_test/provider/sale_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:provider/provider.dart';

import '../constant/dimen.dart';
import '../widgets/easy_text.dart';
import '../widgets/easy_text_field.dart';

class BottomSheetItemTwo extends StatelessWidget {
  const BottomSheetItemTwo(
      {super.key,
      required this.text,
      this.second = false,
      this.kValidator,
      this.pValidator,
      this.yValidator,
      required this.onChange,
      required this.kController,
      required this.yController,
      required this.pController});

  final String text;
  final bool second;
  final TextEditingController kController;
  final TextEditingController yController;
  final TextEditingController pController;
  final Function(String? value)? kValidator;
  final Function(String? value)? pValidator;
  final Function(String? value)? yValidator;

  // final bool lastTextField;
  final Function(String? value) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: kAs70x, child: EasyText(text: text)),
        const SizedBox(
          width: kAs10x,
        ),
        Expanded(
          child: EasyTextField(
            onChanged: (p0) => onChange(p0),
            inputType: TextInputType.number,
            validator: (value) => kValidator!(value),
            controller: kController,
            hintText: 'Enter K',
          ),
        ),
        const SizedBox(
          width: kAs5x,
        ),
        Expanded(
          child: EasyTextField(
            onChanged: (p0) => onChange(p0),
            inputType: TextInputType.number,
            validator: (value) => pValidator!(value),
            controller: pController,
            hintText: 'Enter P',
          ),
        ),
        const SizedBox(
          width: kAs5x,
        ),
        Expanded(
          child: EasyTextField(
            inputType: TextInputType.number,
            onChanged: (p0) => onChange(p0),
            validator: (value) => yValidator!(value),
            controller: yController,
            hintText: 'Enter Y',
          ),
        ),
      ],
    );
  }
}

class WasteKyatPaeYaweItemView extends StatelessWidget {
  const WasteKyatPaeYaweItemView({
    super.key,
    required this.wKController,
    required this.wYController,
    required this.wPController,
    required this.onValidate,
    required this.onChange,
    required this.onYaweValidate,
  });

  final TextEditingController wKController;
  final TextEditingController wYController;
  final TextEditingController wPController;
  final dynamic Function(String?) onChange;
  final dynamic Function(String?) onValidate;
  final dynamic Function(String?) onYaweValidate;

  @override
  Widget build(BuildContext context) {
    return BottomSheetItemTwo(
      kController: wKController,
      yController: wYController,
      pController: wPController,
      onChange: (value) {
        if (wYController.text.textToNum() > 8) {
          context.showSimpleWarningDialog(
              context, "Yawe can't be greater than 8");
          wYController.clear();
        }
        if (wPController.text.textToNum() > 16) {
          context.showSimpleWarningDialog(
              context, "Pae can't be greater than 16");
          wPController.clear();
        }
        onChange(value);
      },
      kValidator: (value) => onValidate(value),
      pValidator: (value) => onValidate(value),
      yValidator: (value) => onYaweValidate(value),
      text: 'Waste',
      second: true,
    );
  }
}

class KyatPaeYaweItemView extends StatelessWidget {
  const KyatPaeYaweItemView({
    super.key,
    required this.kController,
    required this.yController,
    required this.pController,
    required this.onChange,
  });

  final TextEditingController kController;
  final TextEditingController yController;
  final TextEditingController pController;
  final void Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return BottomSheetItemTwo(
      kController: kController,
      yController: yController,
      pController: pController,
      onChange: (value) {
        if (yController.text.textToNum() > 8) {
          context.showSimpleWarningDialog(
              context, "Yawe can't be greater than 8");
          yController.clear();
        }
        if (pController.text.textToNum() > 16) {
          context.showSimpleWarningDialog(
              context, "Pae can't be greater than 16");
          pController.clear();
        }
        onChange(value);
      },
      text: 'K/P/Y',
      kValidator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kyat is Empty';
        }
        if (value.contains(".") || value.contains("+") || value.contains("-")) {
          return "Only integer are supported";
        }
        return null;
      },
      pValidator: (value) {
        if (value == null || value.isEmpty) {
          return 'Pae is Empty';
        }
        if (value.contains(".") || value.contains("+") || value.contains("-")) {
          return "Only integer are supported";
        }
        return null;
      },
      yValidator: (value) {
        if (value == null || value.isEmpty) {
          return 'Yawe is Empty';
        }
        if (!RegExp(r'^\d+(\.\d{0,2})?$').hasMatch(value)) {
          return "only two decimal are allowed";
        }
        return null;
      },
    );
  }
}

class OneTextFieldRow extends StatelessWidget {
  const OneTextFieldRow(
      {super.key,
      this.onChanged,
      required this.textEditingController,
      this.validator,
      required this.header,
      required this.hintText});

  final void Function(String)? onChanged;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final String header;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: kAs70x,
          child: EasyText(
            text: header,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: kAs10x,
        ),
        Expanded(
            child: EasyTextField(
          onChanged: onChanged,
          inputType: TextInputType.number,
          validator: (value) => validator!(value),
          controller: textEditingController,
          hintText: hintText,
        ))
      ],
    );
  }
}

class TwoTextFieldRow extends StatelessWidget {
  const TwoTextFieldRow({
    super.key,
    required this.header,
    required this.firstHintText,
    required this.secondHintText,
    this.firstController,
    this.secondController,
    this.isCharges = true,
    required this.isReadMode,
    this.firstValidate,
    this.secondValidate,
    this.firstOnChange,
    this.secondOnChange,
  });

  final String header;
  final String firstHintText;
  final String secondHintText;
  final TextEditingController? firstController;
  final TextEditingController? secondController;
  final String? Function(String?)? firstValidate;
  final String? Function(String?)? secondValidate;
  final void Function(String?)? firstOnChange;
  final void Function(String?)? secondOnChange;
  final bool isReadMode;
  final bool isCharges;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: kAs70x, child: EasyText(text: header)),
        const SizedBox(
          width: kAs10x,
        ),
        Expanded(
            child: EasyTextField(
          inputType: TextInputType.number,
          controller: firstController ?? TextEditingController(),
          hintText: firstHintText,
          validator: (value) => firstValidate!(value),
          onChanged: (value) => firstOnChange!(value),
          isReadOnly: isCharges ? false : isCharges,
        )),
        const SizedBox(
          width: kAs5x,
        ),
        Expanded(
            child: EasyTextField(
          inputType: TextInputType.number,
          controller: secondController ?? TextEditingController(),
          validator: (value) => secondValidate!(value),
          onChanged: (value) => secondOnChange!(value),
          hintText: secondHintText,
          isReadOnly: isReadMode,
        )),
        SizedBox(
          width: isCharges ? 0 : kAs5x,
        ),
        isCharges
            ? const SizedBox()
            : Expanded(
                child: EasyTextField(
                isReadOnly: true,
                hintText: "Total Amount",
                controller:
                    context.read<SaleVoucherProvider>().totalAmountController,
              ))
      ],
    );
  }
}
