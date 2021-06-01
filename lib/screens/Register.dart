import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/components/Register/RegisterCommercial.dart';
import 'package:shopisan/components/Register/user_register.dart';
import 'package:shopisan/utils/common.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {
        currentIndex = controller.index;
      });
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: getFullScreenHeight(context) - 80,
              // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              // constraints: BoxConstraints.expand(height: getScreenHeight(context) - 100),
              // alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context).signUp,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  TabBar(
                    controller: controller,
                    tabs: <Widget>[
                      Tab(
                        child: Text(AppLocalizations.of(context).userRegister,
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center),
                      ),
                      Tab(
                        child: Text(AppLocalizations.of(context).ownerRegister,
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center),
                      )
                    ],
                  ),
                  Flexible(
                      child: TabBarView(
                    controller: controller,
                    children: <Widget>[UserRegister(), RegisterCommercial()],
                  ))
                ],
              ))
        ],
      ),
    );
  }
}
