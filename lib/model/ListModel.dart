class ListModel1 {
  int? id;
  String? name;
  String? level;
  String? image;

  ListModel1(
      {required this.id,
      required this.name,
      required this.level,
      required this.image});

  ListModel1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    data['image'] = this.image;
    return data;
  }
}
