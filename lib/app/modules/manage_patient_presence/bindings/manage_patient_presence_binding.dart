import 'package:get/get.dart';

import '../controllers/manage_patient_presence_controller.dart';

class ManagePatientPresenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagePatientPresenceController>(
      () => ManagePatientPresenceController(),
    );
  }
}
