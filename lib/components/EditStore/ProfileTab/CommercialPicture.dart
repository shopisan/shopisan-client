import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/components/Form/file_handler.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';

class CommercialPicture extends StatefulWidget {
  final Store store;

  CommercialPicture({required this.store});

  @override
  _CommercialPictureState createState() => _CommercialPictureState();
}

class _CommercialPictureState extends State<CommercialPicture> {
  File? _imageFile;
  final ImagePicker picker = ImagePicker();
  final FileHandler fileHandler = FileHandler();

  void takePhoto(ImageSource source) async {
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

        BlocProvider.of<EditStoreBloc>(context)
            .add(ChangePictureEvent(picture: finalFile));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final storeImage = widget.store.profilePicture;

    ImageProvider _getImage(){
      if (null == storeImage) {
        if (_imageFile == null) {
          return AssetImage("assets/img/store.jpg");
        }  else {
          return FileImage(
            File(_imageFile!.path),
          );
        }
      }  else {
        return NetworkImage(storeImage.file!);
      }
    }

    return Center(
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: CustomColors.search,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _getImage(),
                )),
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
                                      takePhoto(ImageSource.camera);
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
                                      takePhoto(ImageSource.gallery);
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
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
