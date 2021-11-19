part of 'post_creation_bloc.dart';

abstract class PostCreationState extends Equatable {
  final Post? post;
  final int? refresh;

  const PostCreationState({this.post, this.refresh});

  @override
  List<Object> get props => [];
}

class InitialPostCreationState extends PostCreationState {
  const InitialPostCreationState();

  @override
  List<Object> get props => [];
}

class StartedPostCreationState extends PostCreationState {
  final Post post;
  final int? refresh;

  const StartedPostCreationState({required this.post, this.refresh});

  @override
  List<Object> get props => [post];
}

class LoadingPostCreationState extends PostCreationState {
  final Post post;
  LoadingPostCreationState({required this.post});

  @override
  List<Object> get props => [post];
}

class DonePostCreationState extends PostCreationState {
  final String message;
  final bool success;
  final Post post;
  final bool redirect;

  const DonePostCreationState(
      {required this.success,
      required this.message,
      required this.post,
      required this.redirect});

  @override
  List<Object> get props => [success, message, post, redirect];
}

class RedirectPostCreationState extends PostCreationState {}
