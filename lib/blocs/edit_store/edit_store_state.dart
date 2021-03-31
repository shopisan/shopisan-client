part of 'edit_store_bloc.dart';

@immutable
abstract class EditStoreState extends Equatable {
  final Store store;
  final List<Category> categories;
  final int index;

  EditStoreState({@required this.store, @required this.categories, this.index});

  @override
  List<Object> get props => [store, index];
}

class InitialEditStoreState extends EditStoreState {
  final Store store;

  InitialEditStoreState({@required this.store});

  @override
  List<Object> get props => [store];
}

class StartedEditStoreState extends EditStoreState {
  final Store store;
  final List<Category> categories;
  final int index;

  StartedEditStoreState({
    @required this.store,
    @required this.categories,
    this.index
  });

  @override
  List<Object> get props => [store, categories, index];
}

class LoadingEditStoreState extends EditStoreState {
  final Store store;

  LoadingEditStoreState({@required this.store});

  @override
  List<Object> get props => [store];
}

class DoneEditStoreState extends EditStoreState {
  final Store store;
  final List<Category> categories;

  DoneEditStoreState({@required this.store, @required this.categories});

  @override
  List<Object> get props => [store];
}

class ErrorEditStoreState extends EditStoreState {
  final String message;

  ErrorEditStoreState({@required this.message});

  @override
  List<Object> get props => [message];
}