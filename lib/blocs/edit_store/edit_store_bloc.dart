import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/Store.dart';

part 'edit_store_event.dart';

part 'edit_store_state.dart';

class EditStoreBloc extends Bloc<EditStoreEvent, EditStoreState> {
  EditStoreBloc() : super(InitialEditStoreState(store: null));


  @override
  Stream<EditStoreState> mapEventToState(EditStoreEvent event) async* {
    _incrementIndex(){
      int index = 0;
      if (state is StartedEditStoreState && state.index != null){
        index = state.index + 1;
      }

      return index;
    }

    if (event is AppStartedEvent) {
      yield LoadingEditStoreState(store: null);
      try{
        Store store;
        var c = fetchCategories();
        if (null != event.storeId) {
          var s = fetchStore(event.storeId);
          store = await s;
        }  else {
          store = Store();
          store.addresses = [];
          store.addresses.add(Address());
        }
        List<Category> categories = await c;
        yield StartedEditStoreState(store: store, categories: categories);
      } catch(exception){
        yield ErrorEditStoreState(message: exception.toString());
      }
    } else if (event is AddAddressEvent){

      Store store = state.store;
      // yield LoadingEditStoreState(store: store);
      store.addresses.add(Address());
      yield StartedEditStoreState(store: store, categories: state.categories, index: _incrementIndex());
    } else if (event is RemoveAddressEvent){
      Store store = state.store;
      store.addresses.remove(event.address);
      yield StartedEditStoreState(store: store, categories: state.categories, index: _incrementIndex());
    } else if (event is ChangePictureEvent){
      // @todo uploader la photo
    } else if (event is StoreAddressEditEvent) {
      Store store = state.store;
      Address addressEdited = event.address;
      int index = event.index;

      store.addresses[index].streetAvenue = addressEdited.streetAvenue;
      store.addresses[index].postalCode = addressEdited.postalCode;
      store.addresses[index].country = addressEdited.country;
      store.addresses[index].city = addressEdited.city;

      yield StartedEditStoreState(store: store, categories: state.categories);
    } else if (event is StoreEditEvent){
      Store store = event.store;
      yield StartedEditStoreState(store: store, categories: state.categories, index: _incrementIndex());
    } else if (event is StoreSubmitEvent){
      Store store = state.store;
      // @todo envoyer le form
      print("Store submitted");
    }
  }
}
