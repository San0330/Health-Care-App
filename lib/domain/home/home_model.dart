import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../core/product.dart';

part 'home_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeModel {
  @JsonKey(required: true)
  final List<Product> featuredProducts;

  @JsonKey(required: true)
  final int appointmentCount;

  HomeModel({
    @required this.featuredProducts,
    @required this.appointmentCount,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);

  @override
  String toString() =>
      'HomeModel(featuredProducts: $featuredProducts, appointmentCount: $appointmentCount)';
}
