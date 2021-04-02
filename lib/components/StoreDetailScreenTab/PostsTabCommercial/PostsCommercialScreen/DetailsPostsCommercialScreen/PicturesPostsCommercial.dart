import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/model/Post.dart';

class PicturesPostsCommercial extends StatelessWidget {
  final Post post;

  PicturesPostsCommercial({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(

      options: CarouselOptions(height: 300.0, enableInfiniteScroll: false, enlargeCenterPage: true),
      items: post.postMedia.map((postMedia) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.black),
                child: Text("WTF?????"));
          },
        );
      }).toList(),
    ));
  }
}
