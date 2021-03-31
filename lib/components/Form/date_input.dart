import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopisan/theme/colors.dart';

class DateInput extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final DateFormat format;

  DateInput(
      {@required this.controller, @required this.icon, @required this.format});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: EdgeInsets.only(left: 10),
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
      child: DateTimeField(
        style: Theme.of(context).textTheme.bodyText1,
        controller: controller,
        format: format,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: CustomColors.iconsActive,
          ),
          border: InputBorder.none,
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    );
  }
}
