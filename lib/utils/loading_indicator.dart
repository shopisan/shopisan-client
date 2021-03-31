import 'package:flutter/material.dart';
import 'package:shopisan/theme/colors.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(CustomColors.iconsActive),
        ),
      );
}
