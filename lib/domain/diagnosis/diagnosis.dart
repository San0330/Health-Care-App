class Diagnosis {
  Question question;
  List<Conditions> conditions;
  bool shouldStop;

  Diagnosis({
    this.question,
    this.conditions,
    this.shouldStop,
  });

  Diagnosis.fromJson(Map<String, dynamic> json) {
    question = json['question'] != null
        ? Question.fromJson(
            json['question'] as Map<String, dynamic>,
          )
        : null;
    if (json['conditions'] != null) {
      conditions = <Conditions>[];
      json['conditions'].forEach((v) {
        conditions.add(Conditions.fromJson(v as Map<String, dynamic>));
      });
    }
    shouldStop = json['should_stop'] as bool;
  }
}

class Question {
  String type;
  String text;
  List<Items> items;

  Question({this.type, this.text, this.items});

  Question.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String;
    text = json['text'] as String;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(Items.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class Items {
  String id;
  String name;
  List<Choices> choices;

  Items({this.id, this.name, this.choices});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices.add(Choices.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class Choices {
  String id;
  String label;

  Choices({this.id, this.label});

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    label = json['label'] as String;
  }
}

class Conditions {
  String id;
  String name;
  String commonName;
  double probability;

  Conditions({this.id, this.name, this.commonName, this.probability});

  Conditions.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    commonName = json['common_name'] as String;
    probability = json['probability'] as double;
  }
}
