import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopisan/model/PostMedia.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopisan/post_creation/post_creation_bloc.dart';

class PostMediaForm extends StatefulWidget {
  final PostMedia postMedia;
  final int index;

  PostMediaForm({this.postMedia, this.index});

  @override
  _PostMediaFormState createState() => _PostMediaFormState();
}

class _PostMediaFormState extends State<PostMediaForm> {
  // final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  File _image;
  final picker = ImagePicker();

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

    void _deletePostMedia(){
      BlocProvider.of<PostCreationBloc>(context).add(DeletePostMedia(
          index: widget.index));
    }

    return BlocBuilder<PostCreationBloc, PostCreationState>(
        builder: (context, state) {
      return Container(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Description', icon: Icon(Icons.text_snippet)),
              // controller: _descriptionController,
              initialValue: widget.postMedia.description,
              onChanged: (value) {
                widget.postMedia.description = value;
                _updateValues();
              },
            ),
            TextFormField(
                decoration: InputDecoration(
                    labelText: 'Price', icon: Icon(Icons.attach_money)),
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9\.\,]+$'))
                ],
                onChanged: (value) {
                  _updateValues();
                },
                ),
            Center(
              child:
              _image == null
                  ? (
                      widget.postMedia.media != null ?
                      Image.network(widget.postMedia.media.file) :
                      Text('No image selected.')
                    )
                  : Image.file(_image),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await takePicture();
                      _updateValues();
                    },
                    child: Icon(Icons.add_a_photo)),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: uploadImage,
                  child: Icon(Icons.storage),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _deletePostMedia,
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
              child: Icon(Icons.delete),
            ),
          ],
        ),
      );
    });
  }
}
