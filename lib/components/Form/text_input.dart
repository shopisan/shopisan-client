import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopisan/theme/colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final Function validator;
  final String passwordValidation;
  final Function callback;
  final TextInputType keyboardType;
  final List<dynamic> inputFormatter;
  final bool isTextarea;
  final bool noIcon;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final String hint;
  final bool obscureText;
  final int maxLength;

  TextInput(
      {@required this.controller,
      @required this.icon,
      @required this.label,
      this.validator,
      this.passwordValidation,
      this.callback,
      this.inputFormatter,
      this.keyboardType,
      this.isTextarea = false,
      this.noIcon = false,
      this.padding,
      this.margin,
      this.hint,
      this.obscureText = false,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: isTextarea ? null : 50,
      width: double.infinity,
      padding: padding,
      margin: margin ?? EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        // color: Colors.white,
        border: Border.all(color: CustomColors.spreadRegister, width: 2),
        borderRadius: BorderRadius.circular(30),
        // boxShadow: [
        //   BoxShadow(
        //     color: CustomColors.spreadRegister,
        //     spreadRadius: 3,
        //     blurRadius: 15,
        //   ),
        // ],
      ),
      child: TextFormField(
        maxLines: isTextarea ? null : 1,
        controller: controller,
        style: Theme.of(context).textTheme.bodyText1,
        onChanged: callback,
        validator: null != validator
            ? (value) {
                if (passwordValidation != null) {
                  return validator(value, passwordValidation, context);
                }
                return validator(value, context);
              }
            : null,
        keyboardType: keyboardType,
        inputFormatters: inputFormatter,
        obscureText: obscureText,
        maxLength: maxLength,
        maxLengthEnforcement: null == maxLength
            ? MaxLengthEnforcement.none
            : MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
            isDense: true,
            // Added this
            contentPadding: EdgeInsets.all(15),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: noIcon
                ? null
                : Icon(
                    icon,
                    color: CustomColors.iconsActive,
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            labelText: label,
            hintText: hint),
      ),
    );
  }
}
