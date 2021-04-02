import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/theme/colors.dart';

class PostPreview extends StatelessWidget {
  PostPreview({@required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {

    return Container(
        child: CarouselSlider(
          options: CarouselOptions(height: 406.0, enableInfiniteScroll: false, enlargeCenterPage: true),
          items: post.postMedia.map((postMedia) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    // decoration: BoxDecoration(color: Colors.black),
                    child: Column(
                      children: [
                        Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: CustomColors.search,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(postMedia.media.file),
                                  fit: BoxFit.cover,
                                ))),
                        Container(
                          margin: EdgeInsets.only(bottom: 40),
                          padding: EdgeInsets.fromLTRB(0, 20, 10, 20),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: CustomColors.spread, width: 2))),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: CustomColors.spread, width: 2))),
                                  child: Text("${postMedia.description}",
                                      style: Theme.of(context).textTheme.headline1),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: postMedia.price == null
                                        ? Text("",
                                        style: Theme.of(context).textTheme.headline1)
                                        : Text("${postMedia.price} €",
                                        style: Theme.of(context).textTheme.headline1),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ));
              },
            );
          }).toList(),
        ));
  }
}
