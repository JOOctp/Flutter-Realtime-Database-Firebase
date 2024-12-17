import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poleks/app/utils/extension.dart';

import '../../../base/base_controller.dart';
import '../../../data/patient_presence.dart';
import '../../../utils/realtime_database.dart';

class ManagePatientPresenceController extends BaseController {
  final selectDateController = TextEditingController();

  final RealtimeDatabase _database = RealtimeDatabase();
  RxList<RoomsPresence> listRoom = <RoomsPresence>[].obs;
  final Rxn<DateTime> selectedDateTime = Rxn<DateTime>();
  final Rxn<PatientPresence> patientPresence = Rxn<PatientPresence>();

  List<TextInputFormatter> digitOnly = [FilteringTextInputFormatter.digitsOnly];

  @override
  void onInit() {
    if(Get.arguments != null){
      patientPresence.value = Get.arguments as PatientPresence;
      selectedDateTime.value = apiDateFormat.parse(patientPresence.value!.date!);
      selectDateController.text = parseDate(patientPresence.value!.date!, apiDateFormat, inputDateFormat);

      for(final data in patientPresence.value!.rooms!){
        listRoom.add(RoomsPresence(
          name: data.name,
          qty: data.qty ?? 0
        ));
      }

      listRoom.sort((a, b) => a.name.toString().toLowerCase().compareTo(b.name.toString().toLowerCase()));
    } else {
      _readRoom();
    }
    super.onInit();
  } 

  void _readRoom(){
    _database.readRoom().then((event) {
      for(final data in event.snapshot.children){
        listRoom.add(RoomsPresence(
          name: data.child('name').value.toString(),
        ));
      }

      listRoom.sort((a, b) => a.name.toString().toLowerCase().compareTo(b.name.toString().toLowerCase()));
    });
  }

  void addPatientPresence(){
    var patientPresence = PatientPresence(
      date: apiDateFormat.format(selectedDateTime.value!).toString(),
      rooms: listRoom
    );

    _database.addOrUpdatePatientPresence(patientPresence: patientPresence).onError((error, stackTrace){
      showErrorToast(error.toString());
    }).then((value){
      Get.back();
      showSuccessToast("Berhasil menambah kunjungan pasien");
    });
  }


  Future checkPatientPresenceHasData({required String date}){
    return _database.checkPatientPresenceHasData(date: date).onError((error, stackTrace){
      showErrorToast(error.toString());
    });
  }
}
