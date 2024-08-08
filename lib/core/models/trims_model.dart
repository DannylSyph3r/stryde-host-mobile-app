import 'dart:convert';

class TrimModel {
  final List<Trim> trims;

  TrimModel({
    required this.trims,
  });

  TrimModel copyWith({
    List<Trim>? trims,
  }) =>
      TrimModel(
        trims: trims ?? this.trims,
      );

  factory TrimModel.fromRawJson(String str) =>
      TrimModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TrimModel.fromJson(Map<String, dynamic> json) => TrimModel(
        trims: List<Trim>.from(json["Trims"].map((x) => Trim.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Trims": List<dynamic>.from(trims.map((x) => x.toJson())),
      };
}

class Trim {
  final String modelId;
  final String modelMakeId;
  final String modelName;
  final String modelTrim;
  final String modelYear;
  final String modelBody;
  final String makeDisplay;

  Trim({
    required this.modelId,
    required this.modelMakeId,
    required this.modelName,
    required this.modelTrim,
    required this.modelYear,
    required this.modelBody,
    required this.makeDisplay,
  });

  factory Trim.fromJson(Map<String, dynamic> json) {
    return Trim(
      modelId: json["model_id"] ?? "",
      modelMakeId: json["model_make_id"] ?? "",
      modelName: json["model_name"] ?? "",
      modelTrim: json["model_trim"] ?? "",
      modelYear: json["model_year"] ?? "",
      modelBody: json["model_body"] ?? "",
      makeDisplay: json["make_display"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "model_id": modelId,
      "model_make_id": modelMakeId,
      "model_name": modelName,
      "model_trim": modelTrim,
      "model_year": modelYear,
      "model_body": modelBody,
      "make_display": makeDisplay,
    };
  }
}

// class Trim {
//   final String modelId;
//   final String modelMakeId;
//   final String modelName;
//   final String modelTrim;
//   final String modelYear;
//   final String modelBody;
//   final String modelEnginePosition;
//   final String modelEngineCc;
//   final String modelEngineCyl;
//   final String modelEngineType;
//   final String modelEngineValvesPerCyl;
//   final String modelEnginePowerPs;
//   final String modelEnginePowerRpm;
//   final String modelEngineTorqueNm;
//   final String modelEngineTorqueRpm;
//   final String modelEngineBoreMm;
//   final String modelEngineStrokeMm;
//   final String modelEngineCompression;
//   final String modelEngineFuel;
//   final String modelTopSpeedKph;
//   final String model0To100Kph;
//   final String modelDrive;
//   final String modelTransmissionType;
//   final String modelSeats;
//   final String modelDoors;
//   final String modelWeightKg;
//   final String modelLengthMm;
//   final String modelWidthMm;
//   final String modelHeightMm;
//   final String modelWheelbaseMm;
//   final String modelLkmHwy;
//   final String modelLkmMixed;
//   final String modelLkmCity;
//   final String modelFuelCapL;
//   final String modelSoldInUs;
//   final String modelCo2;
//   final String modelMakeDisplay;
//   final String makeDisplay;
//   final String makeCountry;

//   Trim({
//     required this.modelId,
//     required this.modelMakeId,
//     required this.modelName,
//     required this.modelTrim,
//     required this.modelYear,
//     required this.modelBody,
//     required this.modelEnginePosition,
//     required this.modelEngineCc,
//     required this.modelEngineCyl,
//     required this.modelEngineType,
//     required this.modelEngineValvesPerCyl,
//     required this.modelEnginePowerPs,
//     required this.modelEnginePowerRpm,
//     required this.modelEngineTorqueNm,
//     required this.modelEngineTorqueRpm,
//     String? modelEngineBoreMm,
//     String? modelEngineStrokeMm,
//     String? modelEngineCompression,
//     required this.modelEngineFuel,
//     String? modelTopSpeedKph,
//     String? model0To100Kph,
//     required this.modelDrive,
//     required this.modelTransmissionType,
//     String? modelSeats,
//     String? modelDoors,
//     required this.modelWeightKg,
//     required this.modelLengthMm,
//     required this.modelWidthMm,
//     required this.modelHeightMm,
//     required this.modelWheelbaseMm,
//     String? modelLkmHwy,
//     String? modelLkmMixed,
//     String? modelLkmCity,
//     required this.modelFuelCapL,
//     required this.modelSoldInUs,
//     String? modelCo2,
//     required this.modelMakeDisplay,
//     required this.makeDisplay,
//     required this.makeCountry,
//   })  : modelEngineBoreMm = modelEngineBoreMm ?? '',
//         modelEngineStrokeMm = modelEngineStrokeMm ?? '',
//         modelEngineCompression = modelEngineCompression ?? '',
//         modelTopSpeedKph = modelTopSpeedKph ?? '',
//         model0To100Kph = model0To100Kph ?? '',
//         modelSeats = modelSeats ?? '',
//         modelDoors = modelDoors ?? '',
//         modelLkmHwy = modelLkmHwy ?? '',
//         modelLkmMixed = modelLkmMixed ?? '',
//         modelLkmCity = modelLkmCity ?? '',
//         modelCo2 = modelCo2 ?? '';

//   Trim copyWith({
//     String? modelId,
//     String? modelMakeId,
//     String? modelName,
//     String? modelTrim,
//     String? modelYear,
//     String? modelBody,
//     String? modelEnginePosition,
//     String? modelEngineCc,
//     String? modelEngineCyl,
//     String? modelEngineType,
//     String? modelEngineValvesPerCyl,
//     String? modelEnginePowerPs,
//     String? modelEnginePowerRpm,
//     String? modelEngineTorqueNm,
//     String? modelEngineTorqueRpm,
//     String? modelEngineBoreMm,
//     String? modelEngineStrokeMm,
//     String? modelEngineCompression,
//     String? modelEngineFuel,
//     String? modelTopSpeedKph,
//     String? model0To100Kph,
//     String? modelDrive,
//     String? modelTransmissionType,
//     String? modelSeats,
//     String? modelDoors,
//     String? modelWeightKg,
//     String? modelLengthMm,
//     String? modelWidthMm,
//     String? modelHeightMm,
//     String? modelWheelbaseMm,
//     String? modelLkmHwy,
//     String? modelLkmMixed,
//     String? modelLkmCity,
//     String? modelFuelCapL,
//     String? modelSoldInUs,
//     String? modelCo2,
//     String? modelMakeDisplay,
//     String? makeDisplay,
//     String? makeCountry,
//   }) =>
//       Trim(
//         modelId: modelId ?? this.modelId,
//         modelMakeId: modelMakeId ?? this.modelMakeId,
//         modelName: modelName ?? this.modelName,
//         modelTrim: modelTrim ?? this.modelTrim,
//         modelYear: modelYear ?? this.modelYear,
//         modelBody: modelBody ?? this.modelBody,
//         modelEnginePosition: modelEnginePosition ?? this.modelEnginePosition,
//         modelEngineCc: modelEngineCc ?? this.modelEngineCc,
//         modelEngineCyl: modelEngineCyl ?? this.modelEngineCyl,
//         modelEngineType: modelEngineType ?? this.modelEngineType,
//         modelEngineValvesPerCyl:
//             modelEngineValvesPerCyl ?? this.modelEngineValvesPerCyl,
//         modelEnginePowerPs: modelEnginePowerPs ?? this.modelEnginePowerPs,
//         modelEnginePowerRpm: modelEnginePowerRpm ?? this.modelEnginePowerRpm,
//         modelEngineTorqueNm: modelEngineTorqueNm ?? this.modelEngineTorqueNm,
//         modelEngineTorqueRpm: modelEngineTorqueRpm ?? this.modelEngineTorqueRpm,
//         modelEngineBoreMm: modelEngineBoreMm ?? this.modelEngineBoreMm,
//         modelEngineStrokeMm: modelEngineStrokeMm ?? this.modelEngineStrokeMm,
//         modelEngineCompression:
//             modelEngineCompression ?? this.modelEngineCompression,
//         modelEngineFuel: modelEngineFuel ?? this.modelEngineFuel,
//         modelTopSpeedKph: modelTopSpeedKph ?? this.modelTopSpeedKph,
//         model0To100Kph: model0To100Kph ?? this.model0To100Kph,
//         modelDrive: modelDrive ?? this.modelDrive,
//         modelTransmissionType:
//             modelTransmissionType ?? this.modelTransmissionType,
//         modelSeats: modelSeats ?? this.modelSeats,
//         modelDoors: modelDoors ?? this.modelDoors,
//         modelWeightKg: modelWeightKg ?? this.modelWeightKg,
//         modelLengthMm: modelLengthMm ?? this.modelLengthMm,
//         modelWidthMm: modelWidthMm ?? this.modelWidthMm,
//         modelHeightMm: modelHeightMm ?? this.modelHeightMm,
//         modelWheelbaseMm: modelWheelbaseMm ?? this.modelWheelbaseMm,
//         modelLkmHwy: modelLkmHwy ?? this.modelLkmHwy,
//         modelLkmMixed: modelLkmMixed ?? this.modelLkmMixed,
//         modelLkmCity: modelLkmCity ?? this.modelLkmCity,
//         modelFuelCapL: modelFuelCapL ?? this.modelFuelCapL,
//         modelSoldInUs: modelSoldInUs ?? this.modelSoldInUs,
//         modelCo2: modelCo2 ?? this.modelCo2,
//         modelMakeDisplay: modelMakeDisplay ?? this.modelMakeDisplay,
//         makeDisplay: makeDisplay ?? this.makeDisplay,
//         makeCountry: makeCountry ?? this.makeCountry,
//       );

//   factory Trim.fromRawJson(String str) => Trim.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Trim.fromJson(Map<String, dynamic> json) => Trim(
//         modelId: json["model_id"],
//         modelMakeId: json["model_make_id"],
//         modelName: json["model_name"],
//         modelTrim: json["model_trim"],
//         modelYear: json["model_year"],
//         modelBody: json["model_body"],
//         modelEnginePosition: json["model_engine_position"],
//         modelEngineCc: json["model_engine_cc"],
//         modelEngineCyl: json["model_engine_cyl"],
//         modelEngineType: json["model_engine_type"],
//         modelEngineValvesPerCyl: json["model_engine_valves_per_cyl"],
//         modelEnginePowerPs: json["model_engine_power_ps"],
//         modelEnginePowerRpm: json["model_engine_power_rpm"],
//         modelEngineTorqueNm: json["model_engine_torque_nm"],
//         modelEngineTorqueRpm: json["model_engine_torque_rpm"],
//         modelEngineBoreMm: json["model_engine_bore_mm"],
//         modelEngineStrokeMm: json["model_engine_stroke_mm"],
//         modelEngineCompression: json["model_engine_compression"],
//         modelEngineFuel: json["model_engine_fuel"],
//         modelTopSpeedKph: json["model_top_speed_kph"],
//         model0To100Kph: json["model_0_to_100_kph"],
//         modelDrive: json["model_drive"],
//         modelTransmissionType: json["model_transmission_type"],
//         modelSeats: json["model_seats"],
//         modelDoors: json["model_doors"],
//         modelWeightKg: json["model_weight_kg"],
//         modelLengthMm: json["model_length_mm"],
//         modelWidthMm: json["model_width_mm"],
//         modelHeightMm: json["model_height_mm"],
//         modelWheelbaseMm: json["model_wheelbase_mm"],
//         modelLkmHwy: json["model_lkm_hwy"],
//         modelLkmMixed: json["model_lkm_mixed"],
//         modelLkmCity: json["model_lkm_city"],
//         modelFuelCapL: json["model_fuel_cap_l"],
//         modelSoldInUs: json["model_sold_in_us"],
//         modelCo2: json["model_co2"],
//         modelMakeDisplay: json["model_make_display"],
//         makeDisplay: json["make_display"],
//         makeCountry: json["make_country"],
//       );

//   Map<String, dynamic> toJson() => {
//         "model_id": modelId,
//         "model_make_id": modelMakeId,
//         "model_name": modelName,
//         "model_trim": modelTrim,
//         "model_year": modelYear,
//         "model_body": modelBody,
//         "model_engine_position": modelEnginePosition,
//         "model_engine_cc": modelEngineCc,
//         "model_engine_cyl": modelEngineCyl,
//         "model_engine_type": modelEngineType,
//         "model_engine_valves_per_cyl": modelEngineValvesPerCyl,
//         "model_engine_power_ps": modelEnginePowerPs,
//         "model_engine_power_rpm": modelEnginePowerRpm,
//         "model_engine_torque_nm": modelEngineTorqueNm,
//         "model_engine_torque_rpm": modelEngineTorqueRpm,
//         "model_engine_bore_mm": modelEngineBoreMm,
//         "model_engine_stroke_mm": modelEngineStrokeMm,
//         "model_engine_compression": modelEngineCompression,
//         "model_engine_fuel": modelEngineFuel,
//         "model_top_speed_kph": modelTopSpeedKph,
//         "model_0_to_100_kph": model0To100Kph,
//         "model_drive": modelDrive,
//         "model_transmission_type": modelTransmissionType,
//         "model_seats": modelSeats,
//         "model_doors": modelDoors,
//         "model_weight_kg": modelWeightKg,
//         "model_length_mm": modelLengthMm,
//         "model_width_mm": modelWidthMm,
//         "model_height_mm": modelHeightMm,
//         "model_wheelbase_mm": modelWheelbaseMm,
//         "model_lkm_hwy": modelLkmHwy,
//         "model_lkm_mixed": modelLkmMixed,
//         "model_lkm_city": modelLkmCity,
//         "model_fuel_cap_l": modelFuelCapL,
//         "model_sold_in_us": modelSoldInUs,
//         "model_co2": modelCo2,
//         "model_make_display": modelMakeDisplay,
//         "make_display": makeDisplay,
//         "make_country": makeCountry,
//       };
// }
