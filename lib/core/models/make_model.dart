import 'dart:convert';

class CarMakes {
  final List<Make> makes;

  CarMakes({
    required this.makes,
  });

  CarMakes copyWith({
    List<Make>? makes,
  }) =>
      CarMakes(
        makes: makes ?? this.makes,
      );

  factory CarMakes.fromRawJson(String str) =>
      CarMakes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarMakes.fromJson(Map<String, dynamic> json) => CarMakes(
        makes: List<Make>.from(json["Makes"].map((x) => Make.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Makes": List<dynamic>.from(makes.map((x) => x.toJson())),
      };
}

class Make {
  final String makeId;
  final String makeDisplay;
  final String makeIsCommon;
  final String makeCountry;

  Make({
    required this.makeId,
    required this.makeDisplay,
    required this.makeIsCommon,
    required this.makeCountry,
  });

  Make copyWith({
    String? makeId,
    String? makeDisplay,
    String? makeIsCommon,
    String? makeCountry,
  }) =>
      Make(
        makeId: makeId ?? this.makeId,
        makeDisplay: makeDisplay ?? this.makeDisplay,
        makeIsCommon: makeIsCommon ?? this.makeIsCommon,
        makeCountry: makeCountry ?? this.makeCountry,
      );

  factory Make.fromRawJson(String str) => Make.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Make.fromJson(Map<String, dynamic> json) => Make(
        makeId: json["make_id"],
        makeDisplay: json["make_display"],
        makeIsCommon: json["make_is_common"],
        makeCountry: json["make_country"],
      );

  Map<String, dynamic> toJson() => {
        "make_id": makeId,
        "make_display": makeDisplay,
        "make_is_common": makeIsCommon,
        "make_country": makeCountry,
      };
}

class MakeDisplay {
  final String makeId;
  final String makeDisplay;

  MakeDisplay({
    required this.makeId,
    required this.makeDisplay,
  });
}
