import 'package:flutter/material.dart';
import 'package:learning_app2/constants/colors.dart';
import 'package:learning_app2/constants/text_field_container.dart';

class ElevatedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const ElevatedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryDark,
            ),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
