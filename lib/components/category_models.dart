
class Kategori {
  int id;
  String name;

  Kategori({
    required this.id,
    required this.name,
  });

  Kategori.fromJson(Map json)
      : id = json['id'],
        name = json['name'];
}
