part of 'post_creation_bloc.dart';

abstract class PostCreationState extends Equatable {
  final Post post;
  final int refresh;

  const PostCreationState({this.post, this.refresh});

  @override
  List<Object> get props => [post, refresh];
}

class InitialPostCreationState extends PostCreationState {
  const InitialPostCreationState();

  @override
  List<Object> get props => [];
}

class StartedPostCreationState extends PostCreationState {
  final Post post;
  final int refresh;

  const StartedPostCreationState({this.post, this.refresh});

  @override
  List<Object> get props => [post, refresh];
}

class LoadingPostCreationState extends PostCreationState {}

class DonePostCreationState extends PostCreationState {
  final String message;
  final bool success;

  const DonePostCreationState({@required this.success, @required this.message});

  @override
  List<Object> get props => [success, message];
}
