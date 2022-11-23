import 'package:flutter/material.dart';
import 'package:learning_app2/constants/colors.dart';
import 'package:learning_app2/constants/text_field_container.dart';

class ElevatedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const ElevatedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: true,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Password",
        icon: Icon(
          Icons.lock,
          color: kPrimaryDark,
        ),
        suffixIcon: Icon(
          Icons.visibility,
          color: kPrimaryDark,
        ),
        border: InputBorder.none,
      ),
    ));
  }
}
