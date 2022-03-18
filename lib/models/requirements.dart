class Requirement {
  int? id;
  String? description;
  String? registerDate;
  String? importance;
  String? complexity;
  String? estimatedTime;
  int? refProject;

  Requirement(
    this.description,
    this.registerDate,
    this.importance,
    this.complexity,
    this.estimatedTime,
    this.refProject,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['description'] = description;
    map['registerDate'] = registerDate;
    map['importance'] = importance;
    map['complexity'] = complexity;
    map['estimatedTime'] = estimatedTime;
    map['refProject'] = refProject;
    return map;
  }

  Requirement.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    registerDate = map['registerDate'];
    importance = map['importance'];
    complexity = map['complexity'];
    estimatedTime = map['estimatedTime'];
    refProject = map['refProject'];
  }
}
