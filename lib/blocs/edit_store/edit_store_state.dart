part of 'edit_store_bloc.dart';

@immutable
abstract class EditStoreState extends Equatable {
  final Store? store;
  final List<Category>? categories;
  final int? index;

  EditStoreState({this.store, this.categories, this.index});

  @override
  List<Object> get props => [];
}

class InitialEditStoreState extends EditStoreState {

  InitialEditStoreState() : super();

  @override
  List<Object> get props => [];
}

class StartedEditStoreState extends EditStoreState {
  final Store store;
  final List<Category> categories;
  final int index;

  StartedEditStoreState(
      {required this.store, required this.categories, this.index = 0})
      : super(store: store);

  @override
  List<Object> get props => [store, categories, index];
}

class LoadingEditStoreState extends EditStoreState {
  final Store store;

  LoadingEditStoreState({required this.store}) : super(store: store);

  @override
  List<Object> get props => [store];
}

class DoneEditStoreState extends EditStoreState {
  final Store store;
  final List<Category> categories;

  DoneEditStoreState({required this.store, required this.categories}) :
        super(store: store);

  @override
  List<Object> get props => [store];
}

class ErrorEditStoreState extends EditStoreState {
  final Store store;
  final List<Category>? categories;
  final String message;

  ErrorEditStoreState(
      {required this.message,
      required this.store,
      this.categories}) : super(store: store);

  @override
  List<Object> get props => [message, store];
}
