import 'package:flutter/material.dart';
import 'package:shopisan/theme/colors.dart';

class SelectInput extends StatelessWidget {
  final String? value;
  final Function callback;
  final List<DropdownMenuItem> items;
  final IconData icon;
  final String label;
  final String? Function(dynamic, dynamic)? validator;

  SelectInput(
      {this.value,
      required this.callback,
      required this.items,
      required this.label,
      required this.icon,
      this.validator});

  @override
  Widget build(BuildContext context) {
    print(items[0].value);
    print(value == "");

    return Container(
        // height: 50,
        // width: double.infinity,
        // padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: CustomColors.spreadRegister, width: 2),

          // boxShadow: [
          //   BoxShadow(
          //     color: CustomColors.spreadRegister,
          //     spreadRadius: 5,
          //     blurRadius: 15,
          //   ),
          // ],
        ),
        child: DropdownButtonFormField(
            items: items,
            value: value,
            onChanged: (value){callback(value);},
            decoration: InputDecoration(
              isDense: true,
              // Added this
              contentPadding: EdgeInsets.all(15),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: /*noIcon
                ? null
                : */
                  Icon(
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
              /*hintText: hint*/
            ),
            validator: (value){
              if (validator != null) {
                return validator!(value, context);
              }
              return null;
            })
        );
  }
}
