import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  final Function(String)? onChanged;
  final FormatTypes? formatType;

  const CustomFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.formatType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        textDirection: TextDirection.rtl,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        keyboardType: _customKeyboardType(),
        style: Theme.of(context).textTheme.headline6,
        inputFormatters: _customFormat(),
        decoration: InputDecoration(
          hintText: label,
          label: Text(label),
        ),
      ),
    );
  }

  List<TextInputFormatter>? _customFormat() {
    switch (formatType) {
      case FormatTypes.int:
        return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
      case FormatTypes.float:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
        ];
      default:
        return null;
    }
  }

  TextInputType? _customKeyboardType() {
    switch (formatType) {
      case FormatTypes.int:
        return TextInputType.number;
      case FormatTypes.float:
        return const TextInputType.numberWithOptions(decimal: true);
      default:
        return TextInputType.name;
    }
  }
}

enum FormatTypes {
  int,
  float,
}
