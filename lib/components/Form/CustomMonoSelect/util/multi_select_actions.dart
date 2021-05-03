import 'package:flutter/material.dart';
import 'multi_select_item.dart';

/// Contains common actions that are used by different multi select classes.
class MultiSelectActions<V> {
  V onItemCheckedChange(
      V selectedValues, V itemValue, bool checked) {
    if (checked) {
      selectedValues = itemValue;
    } else {
      selectedValues = null;
    }
    return selectedValues;
  }

  /// Pops the dialog from the navigation stack and returns the initially selected values.
  void onCancelTap(BuildContext ctx, V initiallySelectedValues) {
    Navigator.pop(ctx, initiallySelectedValues);
  }

  /// Pops the dialog from the navigation stack and returns the selected values.
  /// Calls the onConfirm function if one was provided.
  void onConfirmTap(
      BuildContext ctx, V selectedValues, Function(V) onConfirm) {
    Navigator.pop(ctx, selectedValues);
    if (onConfirm != null) {
      onConfirm(selectedValues);
    }
  }

  void onClearTap(BuildContext ctx, Function(V) onConfirm) {
    Navigator.pop(ctx);
    if (onConfirm != null) {
      onConfirm(null);
    }
  }

  /// Accepts the search query, and the original list of items.
  /// If the search query is valid, return a filtered list, otherwise return the original list.
  List<MultiSelectItem<V>> updateSearchQuery(
      String val, List<MultiSelectItem<V>> allItems) {
    if (val != null && val.trim().isNotEmpty) {
      List<MultiSelectItem<V>> filteredItems = [];
      for (var item in allItems) {
        if (item.label.toLowerCase().contains(val.toLowerCase())) {
          filteredItems.add(item);
        }
      }
      return filteredItems;
    } else {
      return allItems;
    }
  }

  /// Toggles the search field.
  bool onSearchTap(bool showSearch) {
    return !showSearch;
  }
}
