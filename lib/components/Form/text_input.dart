import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopisan/theme/colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final Function callback;
  final TextInputType keyboardType;
  final List<dynamic> inputFormatter;

  TextInput(
      {@required this.controller,
      @required this.icon,
      @required this.label,
      this.callback,
      this.inputFormatter,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      // padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: CustomColors.spreadRegister,
            spreadRadius: 5,
            blurRadius: 15,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.roboto(
          color: CustomColors.textDescription,
          fontSize: 14,
        ),
        onChanged: callback,
        keyboardType: keyboardType,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
            prefixIcon: Icon(
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
            labelText: label),
      ),
    );
  }
}
