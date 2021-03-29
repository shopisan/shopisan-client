class OpeningTime {
  final List<String> MO;
  final List<String> TU;
  final List<String> WE;
  final List<String> TH;
  final List<String> FR;
  final List<String> SA;
  final List<String> SU;

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
