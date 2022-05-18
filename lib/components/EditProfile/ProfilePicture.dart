import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopisan/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:shopisan/components/Form/file_handler.dart';
import 'package:shopisan/model/File.dart' as FileModel;
import 'package:shopisan/model/UserProfile.dart';
import 'package:shopisan/theme/colors.dart';

class ProfilePicture extends StatefulWidget {
  final UserProfile user;

  ProfilePicture({required this.user});

  @override
  ProfilePictureState createState() => ProfilePictureState();
}

class ProfilePictureState extends State<ProfilePicture> {
  File? _imageFile;
  final ImagePicker picker = ImagePicker();
  final FileHandler fileHandler = FileHandler();

  @override
  Widget build(BuildContext context) {
    _takePhoto(ImageSource source) async {
      final pickedFile = await picker.getImage(source: source);

      if (null != pickedFile) {

        File finalFile = await fileHandler.handleFile(pickedFile);

        Navigator.of(context).pop();

        if (finalFile.lengthSync() > fileHandler.maxSize){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.fileTooBig),
                backgroundColor: CustomColors.error,
              ),
            );
          });
        } else {
          setState(() {
            _imageFile = finalFile;
          });
          BlocProvider.of<ProfileEditBloc>(context)
              .add(ChangePictureEvent(picture: finalFile));
        }
      }
    }

    ImageProvider _backgroundImage(){
      if (widget.user.profile!.picture is FileModel.File &&
          widget.user.profile!.picture!.file != null) {
        return NetworkImage(
            widget.user.profile!.picture!.file!);
      } else if (_imageFile != null) {
        return FileImage(
            File(_imageFile!.path));
      } else {
        return AssetImage(
          "assets/img/profile.jpg",
        );
      }
    }

    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _backgroundImage(),
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
                              Text(AppLocalizations.of(context)!.choosePicture,
                                  style: Theme.of(context).textTheme.headline3),
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
                                      _takePhoto(ImageSource.camera);
                                    },
                                    icon:
                                        Icon(Icons.camera, color: Colors.black),
                                    label: Text(
                                        AppLocalizations.of(context)!.camera,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                  ),
                                  TextButton.icon(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                CustomColors.iconsActive)),
                                    onPressed: () {
                                      _takePhoto(ImageSource.gallery);
                                    },
                                    icon:
                                        Icon(Icons.image, color: Colors.black),
                                    label: Text(
                                        AppLocalizations.of(context)!.gallery,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
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
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
