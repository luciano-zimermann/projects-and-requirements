class Requirement {
  int? id;
  String? description;
  String? registerDate;
  String? importance;
  String? complexity;
  String? estimatedTime;
  int? refProject;
  String? complementInfoLink;
  String? location;
  String? image1;
  String? image2;

  Requirement(
    this.description,
    this.registerDate,
    this.importance,
    this.complexity,
    this.estimatedTime,
    this.refProject,
    this.complementInfoLink,
    this.location,
    this.image1,
    this.image2,
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
    map['complementInfoLink'] = complementInfoLink;
    map['location'] = location;
    map['image1'] = image1;
    map['image2'] = image2;
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
    complementInfoLink = map['complementInfoLink'];
    location = map['location'];
    image1 = map['image1'];
    image2 = map['image2'];
  }
}
