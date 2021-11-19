import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopisan/blocs/post_creation/post_creation_bloc.dart';
import 'package:shopisan/components/Form/text_input.dart' as CustomInput;
import 'package:shopisan/model/PostMedia.dart';
import 'package:shopisan/theme/colors.dart';

class PostMediaForm extends StatefulWidget {
  final PostMedia? postMedia;
  final int? index;

  PostMediaForm({this.postMedia, this.index});

  @override
  _PostMediaFormState createState() => _PostMediaFormState();
}

class _PostMediaFormState extends State<PostMediaForm> {
  final ImagePicker picker = ImagePicker();

  final _descriptionController_fr = TextEditingController();
  final _descriptionController_en = TextEditingController();
  final _priceController = TextEditingController();
  File? _image;

  Future takePicture() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImage() async {
    final galleryFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (galleryFile != null) {
        _image = File(galleryFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    _descriptionController_fr.text = (widget.postMedia?.description_fr ?? "");
    _descriptionController_en.text = (widget.postMedia?.description_en ?? "");
    if (null != widget.postMedia?.price) {
      _priceController.text = (widget.postMedia?.price ?? 0).toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _updateValues() {
      BlocProvider.of<PostCreationBloc>(context).add(ChangePostMedia(
          description_fr: _descriptionController_fr.text,
          description_en: _descriptionController_en.text,
          price: _priceController.text,
          index: widget.index ?? 0));
    }

    void _deletePostMedia() {
      BlocProvider.of<PostCreationBloc>(context)
          .add(DeletePostMedia(index: widget.index ?? 0));
    }

    _takePhoto(ImageSource source) async {
      final pickedFile = await picker.getImage(source: source);

      // TODO we might have to add a few conditions here

      Navigator.of(context).pop();
      setState(() {
        _image = File(pickedFile!.path);
      });

      BlocProvider.of<PostCreationBloc>(context)
          .add(ChangePostMediaPicture(uploadFile: _image!,
          index: widget.index ?? 0));
    }

    return BlocBuilder<PostCreationBloc, PostCreationState>(
        builder: (context, state) {
      return Container(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                width: 50,
                margin: EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: _deletePostMedia,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(CustomColors.error),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)))),
                  child: Icon(
                    Icons.delete,
                    size: 19,
                    color: Colors.black,
                  ),
                ),
              )
            ]),
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CustomColors.lightPink,
                    borderRadius: BorderRadius.circular(20),
                    // border:
                    //     Border.all(color: CustomColors.lightPink, width: 3)
                  ),
                  child: _image == null
                      ? (widget.postMedia?.media != null
                          ? Image.network(
                              widget.postMedia!.media!.file!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.upload_outlined,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                                Text(AppLocalizations.of(context)!.noImage,
                                    style:
                                        Theme.of(context).textTheme.headline3),
                              ],
                            )))
                      : Image.file(_image!),
                ),
                Positioned(
                  bottom: 15,
                  right: 20,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .choosePicture,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton.icon(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .all<Color>(CustomColors
                                                          .iconsActive)),
                                          onPressed: () {
                                            _takePhoto(ImageSource.camera);
                                          },
                                          icon: Icon(Icons.camera,
                                              color: Colors.black),
                                          label: Text(
                                              AppLocalizations.of(context)!
                                                  .camera,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3),
                                        ),
                                        TextButton.icon(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .all<Color>(CustomColors
                                                          .iconsActive)),
                                          onPressed: () {
                                            _takePhoto(ImageSource.gallery);
                                          },
                                          icon: Icon(Icons.image,
                                              color: Colors.black),
                                          label: Text(
                                              AppLocalizations.of(context)!
                                                  .gallery,
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
                )
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
                child: Column(
                  children: [
                    CustomInput.TextInput(
                      isTextarea: true,
                      controller: _descriptionController_en,
                      icon: Icons.text_snippet_outlined,
                      label: AppLocalizations.of(context)!.description+" "+AppLocalizations.of(context)!.english,
                      // initialValue: widget.postMedia.description,
                      callback: (value) {
                        _updateValues();
                      },
                      // validator: isEmpty,
                      maxLength: 160,
                    ),
                    CustomInput.TextInput(
                      isTextarea: true,
                      controller: _descriptionController_fr,
                      icon: Icons.text_snippet_outlined,
                      label: AppLocalizations.of(context)!.description+" "+AppLocalizations.of(context)!.french,
                      // initialValue: widget.postMedia.description,
                      callback: (value) {
                        _updateValues();
                      },
                      // validator: isEmpty,
                      maxLength: 160,
                    ),
                    /*CustomInput.TextInput(
                      controller: _priceController,
                      icon: Icons.euro,
                      label: AppLocalizations.of(context).price,
                      keyboardType: TextInputType.number,
                      callback: (value) {
                        _updateValues();
                      },
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-9\.\,]+$'))
                      ],
                    ),*/
                  ],
                )),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: CustomColors.lightPink, width: 2))),
            )
          ],
        ),
      );
    });
  }
}
