import 'package:flutter/cupertino.dart';
import 'package:shopisan/theme/colors.dart';

class CategoriesCommercial extends StatefulWidget {
  @override
  _CategoriesCommercialState createState() => _CategoriesCommercialState();
}

class _CategoriesCommercialState extends State<CategoriesCommercial> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20,5,20,5),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: CustomColors.commercialTag,
                  borderRadius: BorderRadius.circular(20)
              ),

              child: const Center(
                child: Text("LEATHER",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.textResearch,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20,5,20,5),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: CustomColors.commercialTag,
                  borderRadius: BorderRadius.circular(20)
              ),

              child: const Center(
                child: Text("LEATHER",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.textResearch,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20,5,20,5),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: CustomColors.commercialTag,
                  borderRadius: BorderRadius.circular(20)
              ),

              child: const Center(
                child: Text("LEATHER",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.textResearch,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20,5,20,5),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: CustomColors.commercialTag,
                  borderRadius: BorderRadius.circular(20)
              ),

              child: const Center(
                child: Text("LEATHER",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.textResearch,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20,5,20,5),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: CustomColors.commercialTag,
                  borderRadius: BorderRadius.circular(20)
              ),

              child: const Center(
                child: Text("LEATHER",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.textResearch,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
