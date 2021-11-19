import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/model/Store.dart';
import 'package:shopisan/theme/colors.dart';
import 'package:time_range_picker/time_range_picker.dart';

class OpeningHoursForm extends StatelessWidget {
  final Store store;

  OpeningHoursForm({required this.store});

  int _getDayOrder(day) {
    switch (day) {
      case 'MO':
        return 0;
      case 'TU':
        return 1;
      case 'WE':
        return 2;
      case 'TH':
        return 3;
      case 'FR':
        return 4;
      case 'SA':
        return 5;
      case 'SU':
        return 6;
      default:
        return 7;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> sortedKeys = store.openingTimes!.keys.toList()
      ..sort((a, b) => _getDayOrder(a).compareTo(_getDayOrder(b)));

    String _getTrans(day) {
      switch (day) {
        case 'MO':
          return AppLocalizations.of(context)!.mo;
        case 'TU':
          return AppLocalizations.of(context)!.tu;
        case 'WE':
          return AppLocalizations.of(context)!.we;
        case 'TH':
          return AppLocalizations.of(context)!.th;
        case 'FR':
          return AppLocalizations.of(context)!.fr;
        case 'SA':
          return AppLocalizations.of(context)!.sa;
        case 'SU':
          return AppLocalizations.of(context)!.su;
        default:
          return "";
      }
    }

    _addHour(day) {
      BlocProvider.of<EditStoreBloc>(context).add(AddHourEvent(day: day));
    }

    _deleteHour(day, index) {
      BlocProvider.of<EditStoreBloc>(context)
          .add(DeleteHourEvent(day: day, index: index));
    }

    _getWidgetList(hourList, day) {
      List<Widget> list = [];

      for (int index = 0; index < hourList.length; index++) {
        List<dynamic> hour = hourList[index];
        List<dynamic> start = hour[0].split(":");
        List<dynamic> end = hour[1].split(":");
        list.add(Row(
          children: [
            TextButton(
                onPressed: () async {
                  TimeRange result = await showTimeRangePicker(
                    start: TimeOfDay(
                        hour: int.parse(start[0]), minute: int.parse(start[1])),
                    end: TimeOfDay(
                        hour: int.parse(end[0]), minute: int.parse(end[1])),
                    context: context,
                  );
                  final localization = MaterialLocalizations.of(context);

                  BlocProvider.of<EditStoreBloc>(context).add(ChangeHourEvent(
                      day: day,
                      index: index,
                      values: [
                        localization.formatTimeOfDay(result.startTime, alwaysUse24HourFormat: true),
                        localization.formatTimeOfDay(result.endTime, alwaysUse24HourFormat: true)
                      ]));
                },
                child: Text(
                  "${hour[0]} - ${hour[1]}",
                  style: Theme.of(context).textTheme.subtitle1,
                )),
            Container(
              width: 50,
              child: ElevatedButton(
                onPressed: () {
                  _deleteHour(day, index);
                },
                child: Icon(
                  Icons.delete,
                  size: 15,
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(CustomColors.error),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
              ),
            )
          ],
        ));
      }

      return list;
    }

    return Container(
      child: Column(
          children: sortedKeys
              .map((day) =>
                  Container(
                      decoration: BoxDecoration(
                          color: CustomColors.search,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      padding: EdgeInsets.all(10),
                      child: Row(children: [
                        Expanded(
                            child: Text(
                          _getTrans(day),
                          style: Theme.of(context).textTheme.headline2,
                        )),
                        Expanded(
                          child: Column(
                            children: _getWidgetList(store.openingTimes![day], day),
                          ),
                          flex: 2,
                        ),
                        Container(
                          width: 50,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      CustomColors.success),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)))),
                              onPressed: () {
                                _addHour(day);
                              },
                              child: Icon(
                                Icons.add,
                                size: 15,
                              )),
                        )
                      ])))
              .toList()),
    );
  }
}
