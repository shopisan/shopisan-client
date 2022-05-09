import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/File.dart' as ModelFile;
import 'package:shopisan/model/Store.dart';

part 'edit_store_event.dart';
part 'edit_store_state.dart';

class EditStoreBloc extends Bloc<EditStoreEvent, EditStoreState> {
  EditStoreBloc() : super(InitialEditStoreState());

  _incrementIndex(EditStoreState state) {
    int index = 0;
    if (state is StartedEditStoreState) {
      index = state.index + 1;
    }

    return index;
  }

  _changePicture(EditStoreState state, ChangePictureEvent event) async {
    Store store = state.store as Store;

    try {
      final ModelFile.File? resp =
          await uploadFile(event.picture, "store_picture");

      if(null != resp){
        store.profilePicture = resp;

        return StartedEditStoreState(
            store: store,
            categories: state.categories ?? new List<Category>.empty(),
            index: _incrementIndex(state));
      }

      return ErrorEditStoreState(message: "Picture error", store: store,
          categories: state.categories);
    } catch (exception) {
      return ErrorEditStoreState(message: "Picture error", store: store,
          categories: state.categories);
    }
  }

  @override
  Stream<EditStoreState> mapEventToState(EditStoreEvent event) async* {
    Store store;
    List<Category> categories = state.categories ?? new List<Category>.empty();
    if (event is AppStartedEvent) {
      try {
        var c = fetchCategories();
        if (null != event.storeId) {
          var s = fetchStore(event.storeId!);
          store = await s;
        } else {
          store = Store(
              name: "",
              openingTimes: {
            "MO": [
              ["09:00", "18:00"]
            ],
            "TU": [
              ["09:00", "18:00"]
            ],
            "WE": [
              ["09:00", "18:00"]
            ],
            "TH": [
              ["09:00", "18:00"]
            ],
            "FR": [
              ["09:00", "18:00"]
            ],
            "SA": [
              ["09:00", "18:00"]
            ],
            "SU": [
              ["09:00", "18:00"]
            ],
          });
          store.addresses = [];
          store.addresses!.add(Address(city: "", country: "", postalCode: "", streetAvenue: ""));
        }
        List<Category> categories = await c;
        yield StartedEditStoreState(store: store, categories: categories);
      } catch (exception) {
        yield ErrorEditStoreState(
            message: exception.toString(),
            store: Store(name: ""),
            categories: null);
      }
    } else if (event is AddAddressEvent) {
      Store store = state.store as Store;
      // yield LoadingEditStoreState(store: store);
      store.addresses!.add(Address(city: "", country: "", postalCode: "", streetAvenue: ""));
      yield StartedEditStoreState(
          store: store,
          categories: categories,
          index: _incrementIndex(state));
    } else if (event is RemoveAddressEvent) {
      Store store = state.store as Store;
      store.addresses!.remove(event.address);
      yield StartedEditStoreState(
          store: store,
          categories: categories,
          index: _incrementIndex(state));
    } else if (event is ChangePictureEvent) {
      EditStoreState rslt = await _changePicture(state, event);
      yield rslt;
    } else if (event is StoreAddressEditEvent) {
      Store store = state.store as Store;
      Address addressEdited = event.address;
      int index = event.index;

      store.addresses![index].streetAvenue = addressEdited.streetAvenue;
      store.addresses![index].postalCode = addressEdited.postalCode;
      store.addresses![index].country = addressEdited.country;
      store.addresses![index].city = addressEdited.city;

      yield StartedEditStoreState(store: store, categories: categories);
    } else if (event is StoreEditEvent) {
      Store store = event.store;
      yield StartedEditStoreState(store: store, categories: categories);
    } else if (event is StoreEditAppointmentOnlyEvent) {
      Store store = event.store;
      yield StartedEditStoreState(store: store, categories: categories,
          index: _incrementIndex(state));
    } else if (event is StoreEditCategoriesEvent) {
      Store store = state.store as Store;

      List<Category> selectedCats = [];

      for (Category cat in categories) {
        if (event.categoriesIds.contains(cat.id)) {
          selectedCats.add(cat);
        }
      }

      store.categories = selectedCats;
      yield StartedEditStoreState(store: store, categories: categories);
    } else if (event is StoreSubmitEvent) {
      Store store = state.store as Store;

      try {
        int storeId = await editStore(store);
        Store storeEdited = await fetchStore(storeId);
        yield DoneEditStoreState(store: storeEdited, categories: categories);
        event.authBloc.add(UserRefreshEvent());
      } catch (exception) {
        yield ErrorEditStoreState(message: exception.toString(), store: store, categories: state.categories);
      }
    } else if (event is AddHourEvent) {
      Store store = state.store as Store;
      String day = event.day;

      store.openingTimes![day].add(["09:00", "18:00"]);

      yield StartedEditStoreState(
          store: store,
          categories: categories,
          index: _incrementIndex(state));
    } else if (event is DeleteHourEvent) {
      Store store = state.store as Store;
      String day = event.day;
      int index = event.index;

      store.openingTimes![day].removeAt(index);

      yield StartedEditStoreState(
          store: store,
          categories: categories,
          index: _incrementIndex(state));
    } else if (event is ChangeHourEvent) {
      Store store = state.store as Store;;
      String day = event.day;
      int index = event.index;
      List<String> values = event.values;

      store.openingTimes![day][index] = values;

      yield StartedEditStoreState(
          store: store,
          categories: categories,
          index: _incrementIndex(state));
    }
  }
}
