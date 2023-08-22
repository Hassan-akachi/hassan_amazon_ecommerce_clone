import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../constant/style.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final TextInputType inputType;
  final TextEditingController controller;
  final Iterable<String>? autofillHints;
  final int? maxlines;

  const AuthTextField(
      {Key? key,
      required this.hint,
      required this.inputType,
      required this.controller,
      required this.autofillHints,
      this.maxlines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:
          kEmailEditTextDecoration.copyWith(hintText: hint, labelText: hint),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      autofillHints: autofillHints,
      //use to validate email
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? "Enter a valid email"
          : null,
      maxLines: maxlines,
    );
  }
}
