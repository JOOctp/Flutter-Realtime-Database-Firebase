import 'package:firebase_database/firebase_database.dart';

import '../data/patient_presence.dart';
import '../data/room.dart';

class RealtimeDatabase {
  static String USERS = "users";
  static String ROOMS = "rooms";
  static String PATIENT_PRESENCE = "patient_presence";

  Future<bool> isUserExist({required String email}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref(USERS);
    final data = await databaseReference.get();

    return data.children.firstWhere((element) => element.value.toString() == email).exists;
  }

  //ROOM
  Future addRoom({required Room room}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref('$ROOMS/${room.uuid}');
    return await databaseReference.set(room.toJson());
  }

  Future<DatabaseEvent> readRoom() {
    return FirebaseDatabase.instance.ref('rooms').once();
  }

  Future udpateRoom({required Room room}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref('$ROOMS/${room.uuid}');
    return await databaseReference.set(room.toJson());
  }

  Future deleteRoom({required String uuid}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref('$ROOMS/$uuid');
    return await databaseReference.remove();
  }

  //PATIENT PRESENCE
  Future addOrUpdatePatientPresence({required PatientPresence patientPresence}) async {
    var dateSplitStr = patientPresence.date!.split('-');
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref('$PATIENT_PRESENCE/${dateSplitStr[2]}/${dateSplitStr[1]}/${dateSplitStr[0]}');
    return await databaseReference.set(patientPresence.toJson());
  }
  Stream<DatabaseEvent> readPatientPresence() {
    return FirebaseDatabase.instance.ref('$PATIENT_PRESENCE').orderByValue().onValue;
  }

  Future<DataSnapshot> getPatientPresenceReportMontly({required String year, required String month}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref('$PATIENT_PRESENCE/$year/$month');
    return await databaseReference.get();
  }

  Future checkPatientPresenceHasData({required String date}) async {
    var dateSplitStr = date.split('-');
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref('$PATIENT_PRESENCE/${dateSplitStr[2]}/${dateSplitStr[1]}/${dateSplitStr[0]}');
    return await databaseReference.get();
  }
}