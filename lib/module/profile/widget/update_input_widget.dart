import 'package:flutter/material.dart';
import 'package:orca/utils/extensions/extended_context.dart';

import '../../../ui/input/input_field.dart';
import '../../../utils/validators/validators.dart';

class UpdateInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String title;
  final int? maxLines;
  const UpdateInputWidget({super.key, required this.controller, required this.label,  this.maxLines, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(title,style: context.textTheme.headlineMedium,),
      const SizedBox(height: 5,),
      InputField(
          validator: (value) => Validators.required(value),
          controller: controller,
          maxLines: maxLines,

          label: label),
        const SizedBox(height: 10,),
    ],);
  }
}
