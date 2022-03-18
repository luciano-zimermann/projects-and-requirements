class Project {
  int? id;
  String? name;
  String? startDate;
  String? estimatedEndDate;
  String? owner;

  Project(
    this.name,
    this.startDate,
    this.estimatedEndDate,
    this.owner,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['startDate'] = startDate;
    map['estimatedEndDate'] = estimatedEndDate;
    map['owner'] = owner;
    return map;
  }

  Project.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    startDate = map['startDate'];
    estimatedEndDate = map['estimatedEndDate'];
    owner = map['owner'];
  }
}
