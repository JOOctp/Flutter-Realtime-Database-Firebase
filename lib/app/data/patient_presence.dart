import 'package:firebase_database/firebase_database.dart';

class PatientPresence {
  String? date;
  List<RoomsPresence>? rooms;

  PatientPresence({this.date, this.rooms});

  PatientPresence.fromJson(DataSnapshot data) {
    date = data.child("date").value.toString();
    if (data.child("rooms").value != null) {
      rooms = <RoomsPresence>[];
      for(final room in data.child("rooms").children){
        rooms!.add(RoomsPresence.fromJson(room));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomsPresence {
  String? name;
  int? qty;

  RoomsPresence({this.name, this.qty});

  RoomsPresence.fromJson(DataSnapshot data) {
    name = data.child('name').value.toString();
    qty = int.parse(data.child('qty').exists ? data.child('qty').value.toString() : "0");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['qty'] = this.qty;
    return data;
  }
}