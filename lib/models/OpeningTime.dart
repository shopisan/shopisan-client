class OpeningTime {
  final List<dynamic> MO;
  final List<dynamic> TU;
  final List<dynamic> WE;
  final List<dynamic> TH;
  final List<dynamic> FR;
  final List<dynamic> SA;
  final List<dynamic> SU;

  OpeningTime({this.MO, this.TU, this.WE, this.TH, this.FR, this.SA, this.SU});

  factory OpeningTime.fromJson(final json) {
    return OpeningTime(
        MO: json['MO'],
        TU: json['TU'],
        WE: json['WE'],
        TH: json['TH'],
        FR: json['FR'],
        SA: json['SA'],
        SU: json['SU']);
  }
}

class OpeningTimeCollection {
  final List<OpeningTime> openingTimes;

  OpeningTimeCollection({this.openingTimes});

  factory OpeningTimeCollection.fromJson(json) {
    return OpeningTimeCollection(
      openingTimes: json
          .map<OpeningTime>(
              (json) => OpeningTime.fromJson(json as Map<OpeningTime, dynamic>))
          .toList(),
    );
  }
}
