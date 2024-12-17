import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/custom_button_outline_colored.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../base/base_controller.dart';
import '../../../data/dropdown_value.dart';
import '../../../data/patient_presence.dart';
import '../../../data/room.dart';
import '../../../utils/realtime_database.dart';
import '../../../values/color_values.dart';
import '../../../values/padding_values.dart';

class HomeController extends BaseController with SingleGetTickerProviderMixin {
  late TabController controller;
  final _etName = TextEditingController();
  final RealtimeDatabase _database = RealtimeDatabase();
  final RxString _errorInputName = "".obs;
  final RxString _inputName = "".obs;

  RxList<Room> listRoom = <Room>[].obs;
  RxList<PatientPresence> listPatientPresence = <PatientPresence>[].obs;

  RxList<RoomsPresence> listRoomPresence = <RoomsPresence>[].obs;

  RxList<DropDownValue> dropDownYear = <DropDownValue>[].obs;
  final Rxn<DropDownValue> selectedDropDownYear = Rxn<DropDownValue>();

  RxList<DropDownValue> dropDownMonth = <DropDownValue>[].obs;
  final Rxn<DropDownValue> selectedDropDownMonth = Rxn<DropDownValue>();

  @override
  void onInit() {
    controller = TabController(length: kIsWeb ? 3 : 2, vsync: this);
    for(var year = 2020; year <= DateTime.now().year; year++){
      dropDownYear.add(DropDownValue(valueName: year.toString(), value: year.toString()));
    }

    dropDownMonth.addAll([
      DropDownValue(valueName: "Januari", value: "01"), DropDownValue(valueName: "Februari", value: "02"), DropDownValue(valueName: "Maret", value: "03"),
      DropDownValue(valueName: "April", value: "04"), DropDownValue(valueName: "Mei", value: "05"), DropDownValue(valueName: "Juni", value: "06"),
      DropDownValue(valueName: "Juli", value: "07"), DropDownValue(valueName: "Agustus", value: "08"), DropDownValue(valueName: "September", value: "09"), 
      DropDownValue(valueName: "Oktober", value: "10"), DropDownValue(valueName: "November", value: "11"), DropDownValue(valueName: "Desember", value: "12"),
    ]);
    super.onInit();
  }
  // REPORT
  void onSelectedYear({String? value}){
    var indexOf = dropDownYear.indexWhere((element) => element.value! == value);
    selectedDropDownYear.value = dropDownYear[indexOf];

    if(selectedDropDownMonth.value != null) getReport();
  }

  void onSelectedMonth({String? value}){
    var indexOf = dropDownMonth.indexWhere((element) => element.value! == value);
    selectedDropDownMonth.value = dropDownMonth[indexOf];

    if(selectedDropDownYear.value != null) getReport();
  }

  void getReport(){
    _database.getPatientPresenceReportMontly(year: selectedDropDownYear.value?.value ?? "", month: selectedDropDownMonth.value?.value ?? "")
    .then((value){
      if(value.exists){
        for(final month in value.children){
          for(final room in month.child("rooms").children){
            var roomPresence = RoomsPresence.fromJson(room);
            var indexOf = listRoomPresence.indexWhere((element) => element.name == roomPresence.name);

            if(indexOf < 0){
              listRoomPresence.add(roomPresence);
            } else {
              var qty = listRoomPresence[indexOf].qty ?? 0;
              listRoomPresence[indexOf].qty = qty + (roomPresence.qty ?? 0).toInt();
            }
          }
        }
        
        listRoomPresence.sort((a, b) => a.name.toString().toLowerCase().compareTo(b.name.toString().toLowerCase()));
      } else {
        listRoomPresence.clear();
      }
    });
  }

  // PATIENT PRESENCE
  void readPatientPresence(){
    _database.readPatientPresence().listen((event) {
      listPatientPresence.clear();
      for(final year in event.snapshot.children){
        for(final month in year.children){
          for(final day in month.children){
            final patientPresence = PatientPresence.fromJson(day);
            listPatientPresence.add(patientPresence);
          }
        }
      }
    });
  }

  //ROOM
  void readRoom(){
    _database.readRoom().then((event) {
      listRoom.clear();

      for(final data in event.snapshot.children){
        final room = Room.fromJson(data);
        listRoom.add(room);
      }

      _sortList();
    });
  }

  void _sortList(){
    listRoom.sort((a, b) => a.name.toString().toLowerCase().compareTo(b.name.toString().toLowerCase()));
  }

  void showBottomSheetAddOrUpdateRoom({Room? room}){
    if(room != null){
      _etName.text = room.name ?? "";
      _inputName.value = room.name ?? ""; 
    }

    CustomBottomSheet.common(
      title: room != null ? "Update Poli" : "Tambah Poli Baru", 
      content: Obx((){
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(PaddingValues.paddingMain),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _etName,
                    label: "Nama Poli",
                    inputType: TextInputType.text,
                    errorMessage: _errorInputName.value,
                    onChanged: (String? value){
                      _inputName.value = value ?? "";
                      _errorInputName.value = value == null || (value.length < 3) ? "Minimal 3 karakter" : "";
                    },
                  ),
                  const SizedBox(height: PaddingValues.paddingExtra),
                  Row(
                    children: [
                      Visibility(
                        visible: room != null,
                        child: Expanded(
                          flex: 1,
                          child: CustomButtonOutlineColored(
                            title: "Hapus Poli", 
                            colorText: ColorsValues.redError, 
                            colorButton: ColorsValues.white,
                            colorOutline: ColorsValues.redError,
                            isEnable: _inputName.value.isNotEmpty,
                            action: (){
                              _database.deleteRoom(uuid: room!.uuid ?? "")
                              .onError((error, stackTrace){
                                showErrorToast(error.toString());
                              }).then((value){
                                Get.back();
                                showSuccessToast("Berhasil menghapus poli");
                                listRoom.removeWhere((element) => element.uuid == room.uuid);
                                _sortList();
                              });
                            }, 
                          ),
                        ),
                      ),
                      Visibility(
                        visible: room != null,
                        child: const SizedBox(width: PaddingValues.paddingMain)
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomButtonOutlineColored(
                          title: room != null ? "Update Poli" : "Tambah Poli", 
                          colorText: _inputName.value.isEmpty ? ColorsValues.colorPrimary : ColorsValues.white, 
                          colorButton: _inputName.value.isEmpty ? ColorsValues.white : ColorsValues.colorPrimary,
                          colorOutline: ColorsValues.colorPrimary,
                          isEnable: _inputName.value.isNotEmpty,
                          action: (){
                            var setupDataRoom = Room(name: _inputName.value, uuid: room != null ? room.uuid : FirebaseDatabase.instance.ref().push().key);

                            if(room != null){
                              _database.udpateRoom(room: setupDataRoom).onError((error, stackTrace){
                                showErrorToast(error.toString());
                              }).then((value){
                                Get.back();
                                showSuccessToast("Berhasil merubah poli baru");
                                var index = listRoom.indexWhere((element) => element.uuid == room.uuid);
                                listRoom[index] = setupDataRoom;
                              });
                            } else {
                              _database.addRoom(room: setupDataRoom).onError((error, stackTrace){
                                showErrorToast(error.toString());
                              }).then((value){
                                Get.back();
                                listRoom.add(setupDataRoom);
                                showSuccessToast("Berhasil menambahkan poli baru");
                              });
                            }

                             _sortList();
                          }, 
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      )
    ).then((value){
      _etName.clear();
      _errorInputName.value = "";
      _inputName.value = "";
    });
  }
}
