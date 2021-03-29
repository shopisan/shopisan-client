import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopisan/blocs/post_creation/post_creation_bloc.dart';
import 'package:shopisan/model/PostMedia.dart';
import 'package:shopisan/theme/colors.dart';

class PostMediaForm extends StatefulWidget {
  final PostMedia postMedia;
  final int index;

  PostMediaForm({this.postMedia, this.index});

  @override
  _PostMediaFormState createState() => _PostMediaFormState();
}

class _PostMediaFormState extends State<PostMediaForm> {
  final ImagePicker picker = ImagePicker();

  // final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  File _image;

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
    if (null != widget.postMedia.price) {
      _priceController.text = widget.postMedia.price.toString();
    }

    super.initState();
  }

  ///**
  ///* @todo les controllers ne semblent pas etre mis a jour, soit s'en débarrasser,
  ///         Soit permettre de mettre a jour a chaque changement
  ///*////

  @override
  Widget build(BuildContext context) {
    void _updateValues() {
      BlocProvider.of<PostCreationBloc>(context).add(ChangePostMedia(
          description: widget.postMedia.description,
          uploadFile: _image,
          price: _priceController.text,
          index: widget.index));
    }

    void _deletePostMedia() {
      BlocProvider.of<PostCreationBloc>(context)
          .add(DeletePostMedia(index: widget.index));
    }

    _takePhoto(ImageSource source) async {
      final pickedFile = await picker.getImage(source: source);
      Navigator.of(context).pop();
      setState(() {
        _image = File(pickedFile.path);
      });
    }

    return BlocBuilder<PostCreationBloc, PostCreationState>(
        builder: (context, state) {
      return Container(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              child: _image == null
                  ? (widget.postMedia.media != null
                      ? Image.network(widget.postMedia.media.file)
                      : Text('No image selected.'))
                  : Image.file(_image),
            ),
            Container(
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
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                      _takePhoto(ImageSource.camera);
                                    },
                                    icon:
                                        Icon(Icons.camera, color: Colors.black),
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
                                      _takePhoto(ImageSource.gallery);
                                    },
                                    icon:
                                        Icon(Icons.image, color: Colors.black),
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
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //         onPressed: () async {
            //           await takePicture();
            //           _updateValues();
            //         },
            //         child: Icon(Icons.add_a_photo)),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     ElevatedButton(
            //       onPressed: uploadImage,
            //       child: Icon(Icons.storage),
            //     ),
            //   ],
            // ),

            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              padding: EdgeInsets.only(left: 10),
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
                style: GoogleFonts.roboto(
                  color: CustomColors.textDescription,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: AppLocalizations.of(context).description,
                  icon: Icon(Icons.text_snippet),
                ),
                // controller: _descriptionController,
                initialValue: widget.postMedia.description,
                onChanged: (value) {
                  widget.postMedia.description = value;
                  _updateValues();
                },
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              padding: EdgeInsets.only(left: 10),
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
                style: GoogleFonts.roboto(
                  color: CustomColors.textDescription,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: AppLocalizations.of(context).price,
                    icon: Icon(Icons.attach_money_outlined)),
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9\.\,]+$'))
                ],
                onChanged: (value) {
                  _updateValues();
                },
              ),
            ),

            ElevatedButton(
              onPressed: _deletePostMedia,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              child: Icon(Icons.delete),
            ),
          ],
        ),
      );
    });
  }
}
