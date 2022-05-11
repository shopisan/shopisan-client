import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/model/File.dart' as ModelFile;
import 'package:shopisan/model/Post.dart';
import 'package:shopisan/model/PostMedia.dart';

part 'post_creation_event.dart';
part 'post_creation_state.dart';

class PostCreationBloc extends Bloc<PostCreationEvent, PostCreationState> {
  PostCreationBloc() : super(InitialPostCreationState());

  @override
  Stream<PostCreationState> mapEventToState(
    PostCreationEvent event,
  ) async* {
    if (event is IsStarted) {
      int? postId = event.postId;
      if (null == postId) {
        yield StartedPostCreationState(
            post: Post(
                id: null,
                store: null,
                postMedia: [PostMedia()],
                created: null,
                url: null),
          refresh: 0
        );
      } else {
        Post post = await loadPost(postId);
        yield StartedPostCreationState(post: post, refresh: 0);
      }
    } else if (event is ChangePost) {
      Post post = event.post;

      // yield StartedPostCreationState(post: event.post, refresh: state.refresh! + 1);
      // yield LoadingPostCreationState(post: event.post);

      String validation = validatePost(event.post);
      if (validation == "OK"){
        print("submit form");
        try {
          int created = await createPost(event.post);
          post = await loadPost(created);

          yield DonePostCreationState(
              success: true,
              message: "post created",
              post: post,
              redirect: event.post.id != null ? true : false);
        } catch (error) {
          yield DonePostCreationState(
              success: false, message: error.toString(), post: post,
              redirect: false);
        }
      } else {
        // print(validation);
        yield DonePostCreationState(
            success: false, message: validation, post: event.post,
            redirect: false);
      }
      // yield StartedPostCreationState(post: post);
    } else if (event is ChangePostMedia) {
      Post? post = state.post;
      PostMedia? postMedia = post?.postMedia.elementAt(event.index);
      double? newPrice = double.tryParse(event.price);
      if (newPrice != null) {
        postMedia?.price = newPrice;
      }

      postMedia?.description_fr = event.description_fr;
      postMedia?.description_en = event.description_en;

      post?.postMedia[event.index] = postMedia!;
      yield StartedPostCreationState(
          post: post!, refresh: null == state.refresh ? 0 : state.refresh! + 1);
    } else if (event is ChangePostMediaPicture) {
      Post post = state.post!;
      PostMedia postMedia = post.postMedia.elementAt(event.index);

      final ModelFile.File? resp =
          await uploadFile(event.uploadFile, "post_picture");

      if (null != resp){
        postMedia.media = resp;
        postMedia.uploadFile = null;

        post.postMedia[event.index] = postMedia;
        yield StartedPostCreationState(
            post: post, refresh: null == state.refresh ? 0 : state.refresh! + 1);
      } else {
        yield DonePostCreationState(
            success: false, message: "post created", post: post,
            redirect: false);
      }
    } else if (event is DeletePost) {
      Post post = state.post!;

      try {
        await deletePost(post.id!);
        yield RedirectPostCreationState();
      } catch (e) {
        yield DonePostCreationState(
            success: false, message: e.toString(), post: post, redirect: false);
      }
    } else if (event is AddPostMedia) {
      Post post = state.post!;

      post.postMedia.add(PostMedia());

      yield StartedPostCreationState(
          post: post, refresh: state.refresh! + 1);
    } else if (event is DeletePostMedia) {
      Post post = state.post!;
      if(post.postMedia.length > 1){
        post.postMedia.removeAt(event.index);
        yield StartedPostCreationState(
            post: post, refresh: null == state.refresh ? 0 : state.refresh! + 1);
      } else {
        yield DonePostCreationState(
            success: false, message: "NeedAtLeastOneMedia", post: post, redirect: false);
      }
    } else if (event is ChangePostStore) {
      Post post = state.post!;

      post.store = event.storeUrl != "" ? event.storeUrl : null;

      yield StartedPostCreationState(
          post: post, refresh: null == state.refresh ? 0 : state.refresh! + 1);
    }
  }

  String validatePost(Post post){
    if (post.postMedia.isEmpty){
      return "mediaEmpty";
    }

    for (PostMedia postMedia in post.postMedia){
      if(postMedia.media == null){
        return "mediaMissingPicture";
      }

      if (postMedia.description_en == null && postMedia.description_fr == null){
        return "mediaMissingDescription";
      }
    }

    return "OK";
  }
}
