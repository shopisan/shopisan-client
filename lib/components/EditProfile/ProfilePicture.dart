import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopisan/theme/colors.dart';

class ProfilePicture extends StatefulWidget {
  ProfilePicture({Key key}) : super(key: key);

  @override
  ProfilePictureState createState() => ProfilePictureState();
}

class ProfilePictureState extends State<ProfilePicture> {
  PickedFile _imageFile;
  final ImagePicker picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile == null
                ? AssetImage("assets/img/profile.jpg")
                : FileImage(
                    File(_imageFile.path),
                  ),
          ),
          Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: CustomColors.iconsActive),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  AppLocalizations.of(context).choosePicture,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  CustomColors.iconsActive)),
                                      onPressed: () {
                                        takePhoto(ImageSource.camera);
                                      },
                                      icon: Icon(Icons.camera,
                                          color: Colors.black),
                                      label: Text(
                                        AppLocalizations.of(context).camera,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    ),
                                    TextButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  CustomColors.iconsActive)),
                                      onPressed: () {
                                        takePhoto(ImageSource.gallery);
                                      },
                                      icon: Icon(Icons.image,
                                          color: Colors.black),
                                      label: Text(
                                        AppLocalizations.of(context).gallery,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    );
                  },
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
