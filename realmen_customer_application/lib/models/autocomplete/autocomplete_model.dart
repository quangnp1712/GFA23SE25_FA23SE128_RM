// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:get/get.dart';

class PredictionModel {
  String? description;
  String? placeId;

  PredictionModel({this.description, this.placeId});
  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      description: json['description'] ?? null,
      placeId: json['placeId'] ?? null,
    );
  }
}

class AutocompleteModel {
  List<PredictionModel>? predictions;

  AutocompleteModel({this.predictions});

  factory AutocompleteModel.fromJson(Map<String, dynamic> json) {
    return AutocompleteModel(
        predictions: json['value']['predictions'] != null &&
                json['value']['predictions'] != []
            ? List<PredictionModel>.from(json['value']['predictions']
                .map((e) => PredictionModel.fromJson(e)))
            : null);
  }
}
