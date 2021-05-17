class Player {
  int id;
  String name;
  int rating;

  Player({this.id, this.name, this.rating});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['rating'] = this.rating;
    return data;
  }
}