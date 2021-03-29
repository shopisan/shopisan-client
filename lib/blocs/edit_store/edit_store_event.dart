part of 'edit_store_bloc.dart';

@immutable
abstract class EditStoreEvent extends Equatable {}

class AppStartedEvent extends EditStoreEvent{
  final int storeId;

  AppStartedEvent({@required this.storeId});

  @override
  List<Object> get props => [storeId];
}

class StoreEditEvent extends EditStoreEvent{
  final Store store;

  StoreEditEvent({@required this.store});

  @override
  List<Object> get props => [store];
}

class StoreAddressEditEvent extends EditStoreEvent{
  final Address address;
  final int index;

  StoreAddressEditEvent({@required this.address, @required this.index});

  @override
  List<Object> get props => [address, index];
}

class ChangePictureEvent extends EditStoreEvent {
  final File picture;

  ChangePictureEvent({
    @required this.picture
  });

  List<Object> get props => [picture];
}

class AddAddressEvent extends EditStoreEvent{
  @override
  List<Object> get props => [];
}

class RemoveAddressEvent extends EditStoreEvent{
  final Address address;

  RemoveAddressEvent({
    @required this.address
  });

  @override
  List<Object> get props => [address];
}

class StoreSubmitEvent extends EditStoreEvent{
  final Store store;

  StoreSubmitEvent({@required this.store});

  @override
  List<Object> get props => [store];
}
