import 'dart:convert';

class Condition {
  final String id;
  final String name;
  final String choiceid;
  final String source;

  Condition({
    this.id,
    this.name,
    this.choiceid = 'present',
    this.source,
  });

  Map<String, dynamic> toMap() {
    if (source == null) {
      return {
        'id': id,
        'choice_id': choiceid,
      };
    }
    return {
      'id': id,
      'choice_id': choiceid,
      'source': source,
    };
  }

  factory Condition.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Condition(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Condition.fromJson(String source) => Condition.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  Condition copyWith({
    String id,
    String name,
    String choiceid,
    String source,
  }) {
    return Condition(
      id: id ?? this.id,
      name: name ?? this.name,
      choiceid: choiceid ?? this.choiceid,
      source: source ?? this.source,
    );
  }

  @override
  String toString() {
    return 'Condition(id: $id, name: $name, choiceid: $choiceid, source: $source)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Condition &&
        o.id == id &&
        o.name == name &&
        o.choiceid == choiceid &&
        o.source == source;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ choiceid.hashCode ^ source.hashCode;
  }
}
