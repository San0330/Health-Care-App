import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(required: true, name: '_id')
  final String id;
  @JsonKey(required: true, name: 'title')
  final String name;

  Category({
    @required this.id,
    @required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  String toString() => 'Category(id: $id, name: $name)';
}
