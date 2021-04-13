import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/theme/colors.dart';

class PostPreview extends StatefulWidget {
  PostPreview({@required this.post});

  final Post post;

  @override
  _PostPreviewState createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    bool hasTextOverflow(String text,
        // TextStyle style,
            {double minWidth = 0,
          double maxWidth = double.infinity,
          int maxLines = 2}) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
      )..layout(minWidth: minWidth, maxWidth: width);

      return textPainter.didExceedMaxLines;
    }

    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 25),
        // height: MediaQuery.of(context).size.height * 0.65,
        // height: 450,
        child: CarouselSlider(
          options: CarouselOptions(
            // aspectRatio: 0.65,
            height: opened ? 475 : 400,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
          ),
          items: widget.post.postMedia.map((postMedia) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: CustomColors.search,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(postMedia.media.file),
                                  fit: BoxFit.cover,
                                ))),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: CustomColors.lightPink, width: 2),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child:
                                    hasTextOverflow("${postMedia.description}")
                                        ? TextButton(
                                            style: ButtonStyle(
                                              alignment: Alignment.topLeft,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                opened = !opened;
                                              });
                                            },
                                            child: Text(
                                              "${postMedia.description}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: opened ? 15 : 2,
                                            ),
                                          )
                                        : Text("${postMedia.description}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                flex: 5,
                              ),
                              postMedia.price == null
                                  ? Text("")
                                  : Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(left: 10),
                                      width: 55,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: CustomColors.lightPink,
                                                  width: 2))),
                                      child: Text("${postMedia.price} €",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ),
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

// class PostPreview extends StatelessWidget {
//   PostPreview({@required this.post});
//
//   final Post post;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         // height: MediaQuery.of(context).size.height * 0.65,
//         height: 450,
//         child: CarouselSlider(
//           options: CarouselOptions(
//               // aspectRatio: 0.65,
//               height: 450,
//               enableInfiniteScroll: false,
//               enlargeCenterPage: true,
//           ),
//           items: post.postMedia.map((postMedia) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Container(
//                     width: MediaQuery.of(context).size.width,
//                     // margin: EdgeInsets.symmetric(horizontal: 5.0),
//                     // decoration: BoxDecoration(color: Colors.black),
//                     child: Column(
//                       children: [
//                         Container(
//                             height: 300,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                                 color: CustomColors.search,
//                                 borderRadius: BorderRadius.circular(20),
//                                 image: DecorationImage(
//                                   image: NetworkImage(postMedia.media.file),
//                                   fit: BoxFit.cover,
//                                 ))),
//                         Container(
//                           // margin: EdgeInsets.only(bottom: 20),
//                           padding: EdgeInsets.fromLTRB(0, 20, 10, 20),
//                           decoration: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(
//                                   color: CustomColors.lightPink, width: 2),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   "${postMedia.description}",
//                                   style: Theme.of(context).textTheme.bodyText1,
//                                   textAlign: TextAlign.justify,
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 2,
//                                 ),
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                       padding: EdgeInsets.only(left: 10),
//                                       child: postMedia.price == null
//                                           ? Text("")
//                                           : Container(
//                                               padding:
//                                                   EdgeInsets.only(left: 10),
//                                               decoration: BoxDecoration(
//                                                   border: Border(
//                                                       left: BorderSide(
//                                                           color: CustomColors
//                                                               .lightPink,
//                                                           width: 2))),
//                                               child: Text(
//                                                   "${postMedia.price} €",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyText1),
//                                             )),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ));
//               },
//             );
//           }).toList(),
//         ));
//   }
// }
