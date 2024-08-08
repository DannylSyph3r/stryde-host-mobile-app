import 'dart:convert';

class CarModel {
  final List<Model> models;

  CarModel({
    required this.models,
  });

  CarModel copyWith({
    List<Model>? models,
  }) =>
      CarModel(
        models: models ?? this.models,
      );

  factory CarModel.fromRawJson(String str) =>
      CarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        models: List<Model>.from(json["Models"].map((x) => Model.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Models": List<dynamic>.from(models.map((x) => x.toJson())),
      };
}

class Model {
  final String modelName;
  final String modelMakeId;

  Model({
    required this.modelName,
    required this.modelMakeId,
  });

  Model copyWith({
    String? modelName,
    String? modelMakeId,
  }) =>
      Model(
        modelName: modelName ?? this.modelName,
        modelMakeId: modelMakeId ?? this.modelMakeId,
      );

  factory Model.fromRawJson(String str) => Model.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        modelName: json["model_name"],
        modelMakeId: json["model_make_id"],
      );

  Map<String, dynamic> toJson() => {
        "model_name": modelName,
        "model_make_id": modelMakeId,
      };
}

class ModelDisplay {
  final String modelName;
  final String modelMakeid;

  ModelDisplay({
    required this.modelName,
    required this.modelMakeid,
  });
}
