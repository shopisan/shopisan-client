part of 'post_creation_bloc.dart';

abstract class PostCreationEvent extends Equatable {
  const PostCreationEvent();
}

class IsStarted extends PostCreationEvent {
  final int postId;

  const IsStarted({@required this.postId});

  @override
  List<Object> get props => [postId];

  @override
  String toString() => 'Post edited { store: $postId }';
}

class ChangePost extends PostCreationEvent {
  final Post post;

  const ChangePost({@required this.post});

  @override
  List<Object> get props => [post];

  @override
  String toString() => 'Post edited { store: $post }';
}

class DeletePost extends PostCreationEvent {
  const DeletePost();

  @override
  List<Object> get props => [];
}

class ChangePostMedia extends PostCreationEvent {
  final String description;
  final String price;
  final int index;

  const ChangePostMedia(
      {@required this.description, @required this.price, @required this.index});

  @override
  List<Object> get props => [uploadFile, description, price, index];

  @override
  String toString() =>
      'Post edited { media: $uploadFile, description: $description, price: $price }';
}

class ChangePostMediaPicture extends PostCreationEvent {
  final File uploadFile;
  final int index;

  const ChangePostMediaPicture(
      {@required this.uploadFile, @required this.index});

  @override
  List<Object> get props => [uploadFile, index];

  @override
  String toString() => 'Post edited { media: $uploadFile }';
}

class ChangePostStore extends PostCreationEvent {
  final String storeUrl;

  const ChangePostStore(
      {@required this.storeUrl});

  @override
  List<Object> get props => [storeUrl];
}

class AddPostMedia extends PostCreationEvent {
  @override
  List<Object> get props => [];
}

class DeletePostMedia extends PostCreationEvent {
  final int index;

  const DeletePostMedia({@required this.index});

  @override
  List<Object> get props => [index];
}
