import 'package:firebase_database/firebase_database.dart';

class Room {
  String? name;
  String? uuid;

  Room({this.name, this.uuid});

  Room.fromJson(DataSnapshot data) {
    name = data.child("name").value.toString();
    uuid =  data.child("uuid").value.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['uuid'] = this.uuid;
    return data;
  }
}