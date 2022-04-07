class Image {
  int? id;
  String? name;

  Image({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };

    return map;
  }

  Image.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
