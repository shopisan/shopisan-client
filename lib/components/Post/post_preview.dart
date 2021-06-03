import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/PostMedia.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:shopisan/utils/common.dart';

class PostPreview extends StatefulWidget {
  PostPreview({@required this.post, this.isSettings = false});

  final Post post;
  final bool isSettings;

  @override
  _PostPreviewState createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  bool opened = false;
  final String locale = getLocaleCode();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool overlayOpened = false;

    final OverlayState _overlay = Overlay.of(context);
    OverlayEntry overlayEntry;

    void removeEntry() {
      overlayEntry.remove();
      overlayOpened = false;
    }

    OverlayEntry getEntry(PostMedia postMedia, Post post, int index) {
      final PageController controller = PageController(initialPage: index);

      return OverlayEntry(builder: (context) {
        final size = MediaQuery.of(context).size;

        return Positioned(
          width: size.width,
          height: size.height,
          top: 0,
          left: 0,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: removeEntry,
              child: Hero(
                tag: NetworkImage(postMedia.media.file),
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  pageController: controller,
                  builder: (BuildContext context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider:
                          NetworkImage(post.postMedia[index].media.file),
                      initialScale: PhotoViewComputedScale.contained * 1,
                      minScale: PhotoViewComputedScale.contained * 1,
                    );
                  },
                  itemCount: post.postMedia.length,
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                                event.expectedTotalBytes,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      });
    }

    void _insertOverlay(BuildContext context, PostMedia postMedia, int index) {
      overlayEntry = getEntry(postMedia, widget.post, index);
      overlayOpened = true;
      return _overlay.insert(overlayEntry);
    }

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

    getPhotoWidget(PostMedia postMedia, int index) {
      Widget photo = Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.search,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(postMedia.media.file),
            fit: BoxFit.cover,
          ),
        ),
      );

      return !widget.isSettings
          ? TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: photo,
              onPressed: () {
                // Navigator.pushNamed(context, '/photo_post');
                _insertOverlay(context, postMedia, index);
              },
            )
          : photo;
    }

    return WillPopScope(
      onWillPop: () async {
        if (overlayOpened) {
          return false;
        }
        return true;
      },
      child: Container(
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
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                disableCenter: true),
            items: widget.post.postMedia
                .asMap()
                .map((index, postMedia) => MapEntry(index, Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                getPhotoWidget(postMedia, index),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: CustomColors.lightPink,
                                          width: 2),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: hasTextOverflow(
                                                "${postMedia.getDescriptionLocale(locale)}")
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
                                                  "${postMedia.getDescriptionLocale(locale)}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: opened ? 15 : 2,
                                                ),
                                              )
                                            : Text(
                                                "${postMedia.getDescriptionLocale(locale)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1),
                                        flex: 5,
                                      ),
                                      postMedia.price == null
                                          ? Text("")
                                          : Container(
                                              alignment: Alignment.centerRight,
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              // width: 60,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          color: CustomColors
                                                              .lightPink,
                                                          width: 2))),
                                              child: Text(
                                                  "${postMedia.price} €",
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
                    )))
                .values
                .toList(),
          )),
    );
  }
}
