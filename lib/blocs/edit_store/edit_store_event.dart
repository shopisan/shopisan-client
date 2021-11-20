part of 'edit_store_bloc.dart';

@immutable
abstract class EditStoreEvent extends Equatable {}

class AppStartedEvent extends EditStoreEvent{
  final int? storeId;

  AppStartedEvent({this.storeId});

  @override
  List<Object> get props => [];
}

class StoreEditEvent extends EditStoreEvent{
  final Store store;

  StoreEditEvent({required this.store});

  @override
  List<Object> get props => [store];
}

class StoreEditAppointmentOnlyEvent extends EditStoreEvent{
  final Store store;

  StoreEditAppointmentOnlyEvent({required this.store});

  @override
  List<Object> get props => [store];
}

class StoreEditCategoriesEvent extends EditStoreEvent{
  final List<dynamic> categoriesIds;

  StoreEditCategoriesEvent({required this.categoriesIds});

  @override
  List<Object> get props => [categoriesIds];
}

class StoreAddressEditEvent extends EditStoreEvent{
  final Address address;
  final int index;

  StoreAddressEditEvent({required this.address, required this.index});

  @override
  List<Object> get props => [address, index];
}

class ChangePictureEvent extends EditStoreEvent {
  final File picture;

  ChangePictureEvent({
    required this.picture
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
    required this.address
  });

  @override
  List<Object> get props => [address];
}

class StoreSubmitEvent extends EditStoreEvent{
  final AuthenticationBloc authBloc;

  StoreSubmitEvent({required this.authBloc});

  @override
  List<Object> get props => [];
}

class AddHourEvent extends EditStoreEvent{
  final String day;

  AddHourEvent({required this.day});

  @override
  List<Object> get props => [day];
}

class DeleteHourEvent extends EditStoreEvent{
  final String day;
  final int index;

  DeleteHourEvent({required this.day, required this.index});

  @override
  List<Object> get props => [day, index];
}

class ChangeHourEvent extends EditStoreEvent{
  final String day;
  final int index;
  final List<String> values;

  ChangeHourEvent({
    required this.day,
    required this.index,
    required this.values
  });

  @override
  List<Object> get props => [day, index, values];
}
