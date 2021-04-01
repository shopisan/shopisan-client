import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/model/Address.dart';
import 'package:shopisan/model/Category.dart';
import 'package:shopisan/model/File.dart' as ModelFile;
import 'package:shopisan/model/Store.dart';

part 'edit_store_event.dart';
part 'edit_store_state.dart';

class EditStoreBloc extends Bloc<EditStoreEvent, EditStoreState> {
  EditStoreBloc() : super(InitialEditStoreState(store: null));

  _incrementIndex(EditStoreState state) {
    int index = 0;
    if (state is StartedEditStoreState && state.index != null) {
      index = state.index + 1;
    }

    return index;
  }

  _changePicture(EditStoreState state, ChangePictureEvent event) async {
    Store store = state.store;

    try {
      final ModelFile.File resp =
          await uploadFile(event.picture, "store_picture");
      store.profilePicture = resp;

      return StartedEditStoreState(
          store: store,
          categories: state.categories,
          index: _incrementIndex(state));
    } catch (exception) {
      return ErrorEditStoreState(message: "Picture error");
    }
  }

  @override
  Stream<EditStoreState> mapEventToState(EditStoreEvent event) async* {
    if (event is AppStartedEvent) {
      try {
        Store store;
        var c = fetchCategories();
        if (null != event.storeId) {
          var s = fetchStore(event.storeId);
          store = await s;
        } else {
          store = Store(openingTimes: {
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
          store.addresses.add(Address());
        }
        List<Category> categories = await c;
        yield StartedEditStoreState(store: store, categories: categories);
      } catch (exception) {
        yield ErrorEditStoreState(message: exception.toString());
      }
    } else if (event is AddAddressEvent) {
      Store store = state.store;
      // yield LoadingEditStoreState(store: store);
      store.addresses.add(Address());
      yield StartedEditStoreState(
          store: store,
          categories: state.categories,
          index: _incrementIndex(state));
    } else if (event is RemoveAddressEvent) {
      Store store = state.store;
      store.addresses.remove(event.address);
      yield StartedEditStoreState(
          store: store,
          categories: state.categories,
          index: _incrementIndex(state));
    } else if (event is ChangePictureEvent) {
      EditStoreState rslt = await _changePicture(state, event);
      yield rslt;
    } else if (event is StoreAddressEditEvent) {
      Store store = state.store;
      Address addressEdited = event.address;
      int index = event.index;

      store.addresses[index].streetAvenue = addressEdited.streetAvenue;
      store.addresses[index].postalCode = addressEdited.postalCode;
      store.addresses[index].country = addressEdited.country;
      store.addresses[index].city = addressEdited.city;

      yield StartedEditStoreState(store: store, categories: state.categories);
    } else if (event is StoreEditEvent) {
      Store store = event.store;
      yield StartedEditStoreState(store: store, categories: state.categories);
    } else if (event is StoreEditCategoriesEvent) {
      Store store = state.store;

      List<Category> selectedCats = [];

      for (Category cat in state.categories) {
        if (event.categoriesIds.contains(cat.id)) {
          selectedCats.add(cat);
        }
      }

      store.categories = selectedCats;
      yield StartedEditStoreState(store: store, categories: state.categories);
    } else if (event is StoreSubmitEvent) {
      Store store = state.store;
      List<Category> categories = state.categories;

      try {
        int storeId = await editStore(store);
        Store storeEdited = await fetchStore(storeId);
        yield DoneEditStoreState(store: storeEdited, categories: categories);
        // yield StartedEditStoreState(store: storeEdited, categories: categories, index: _incrementIndex(state));
      } catch (exception) {
        yield ErrorEditStoreState(message: exception.toString());
        yield StartedEditStoreState(
            store: store,
            categories: categories,
            index: _incrementIndex(state));
      }
    } else if (event is AddHourEvent) {
      Store store = state.store;
      String day = event.day;

      store.openingTimes[day].add(["09:00", "18:00"]);

      yield StartedEditStoreState(
          store: store,
          categories: state.categories,
          index: _incrementIndex(state));
    } else if (event is DeleteHourEvent) {
      Store store = state.store;
      String day = event.day;
      int index = event.index;

      store.openingTimes[day].removeAt(index);

      yield StartedEditStoreState(
          store: store,
          categories: state.categories,
          index: _incrementIndex(state));
    } else if (event is ChangeHourEvent) {
      Store store = state.store;
      String day = event.day;
      int index = event.index;
      List<String> values = event.values;

      store.openingTimes[day][index] = values;

      yield StartedEditStoreState(
          store: store,
          categories: state.categories,
          index: _incrementIndex(state));
    }
  }
}
