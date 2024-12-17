class UserData {
  String? uuid;
  String? name;
  String? email;
  String? photoUrl;

  UserData({this.uuid, this.name, this.email, this.photoUrl});

  UserData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    email = json['email'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}