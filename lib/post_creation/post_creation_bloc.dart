import 'dart:io';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
    if (event is IsStarted){
      int postId = event.postId;
      if (null == postId) {
        yield StartedPostCreationState(
            post: Post(
                id: null,
                store: "url du store",
                postMedia: [
                  PostMedia()
                ],
                created: null,
                url: null
            )
        );
      } else {
        Post post = await loadPost(postId);
        yield StartedPostCreationState(post: post);
      }
    } else if (event is ChangePost) {
      // yield emet des state
      Post post = event.post;
      yield StartedPostCreationState(post: event.post);
      yield LoadingPostCreationState(post: event.post);

      try {
        Post created = await createPost(event.post);
        post = await loadPost(created.id);
        yield DonePostCreationState(success: true, message: "post created",
            post: post);
      } catch (error) {
        yield DonePostCreationState(success: false, message: error.toString(),
            post: post);
      }
      yield StartedPostCreationState(post: post);
    } else if (event is ChangePostMedia) {
      Post post = state.post;
      PostMedia postMedia = post.postMedia.elementAt(event.index);
      double newPrice = double.tryParse(event.price);
      if (newPrice != null) {
        postMedia.price = newPrice;
      }

      postMedia.description = event.description;

      if (postMedia.media != event.uploadFile && event.uploadFile is File) {
        final ModelFile.File resp = await uploadFile(event.uploadFile, "post_picture");
        postMedia.media = resp;
      }  

      post.postMedia[event.index] = postMedia;
      yield StartedPostCreationState(post: post, refresh: null == state.refresh ? 0 : state.refresh + 1);
    } else if (event is DeletePost) {
      Post post = state.post;

      try {
        await deletePost(post.id);
        yield RedirectPostCreationState();
      } catch (e){
        yield DonePostCreationState(success: false, message: e.toString(), post: post);
      }
    } else if (event is AddPostMedia) {
      Post post = state.post;

      post.postMedia.add(PostMedia());

      yield StartedPostCreationState(post: post, refresh: null == state.refresh ? 0 : state.refresh + 1);
    } else if (event is DeletePostMedia){
      Post post = state.post;
      post.postMedia.removeAt(event.index);
      yield StartedPostCreationState(post: post, refresh: null == state.refresh ? 0 : state.refresh + 1);
    }
  }
}
