import 'package:flutter/material.dart';

import '../../../../../repos/colors.dart';

TextFormField profileTextFormField(
    {required TextEditingController controller,
    IconData iconData = Icons.abc,
    required String name}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusColor: kMainColor,
        prefixIcon: Icon(iconData),
        hintText: name),
  );
}
