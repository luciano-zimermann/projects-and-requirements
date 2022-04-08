class User {
  int? id;
  String? login;
  String? password;

  User({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['login'] = login;
    map['password'] = password;
    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    login = map['login'];
    password = map['password'];
  }
}
