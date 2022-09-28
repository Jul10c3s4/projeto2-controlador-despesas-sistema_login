const String perfilTable = "perfilTable";
const String idPerfilColumn = "idColumn";
const String nameColumn = "nameColumn";
const String imgColumn = "imgColumn";

class User {
  int? id;
  String? name;
  String? img;
  User();

  User.fromMap(Map<String, dynamic> map)
      : id = map[idPerfilColumn],
        name = map[nameColumn],
        img = map[imgColumn];

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {nameColumn: name, imgColumn: name};

    if (id != null) {
      map[idPerfilColumn] = id;
    }
    return map;
  }
}
