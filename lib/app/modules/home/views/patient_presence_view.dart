import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/patient_presence.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/extension.dart';
import '../../../values/color_values.dart';
import '../../../values/padding_values.dart';
import '../../../values/text_style_values.dart';
import '../controllers/home_controller.dart';

class PatientPresenceView extends GetView<HomeController> {
  const PatientPresenceView({super.key});
  @override
  Widget build(BuildContext context) {
    if(controller.listPatientPresence.isEmpty) controller.readPatientPresence();

    return Scaffold(
      backgroundColor: ColorsValues.white,
      body: Obx((){
          return RefreshIndicator(
            onRefresh: () async => controller.readPatientPresence(),
            color: ColorsValues.colorPrimary,
            child: ListView.separated(
              itemBuilder: (context, index) => itemPatientPresence(patientPresence: controller.listPatientPresence[index]),
              separatorBuilder: (context, index) => const Divider(
                color: ColorsValues.black5,
                thickness: 1,
                height: 1,
              ),
              itemCount: controller.listPatientPresence.length,
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsValues.colorPrimary,
        tooltip: 'Tambah Jumlah Pengunjung',
        onPressed: () => Get.toNamed(Routes.MANAGE_PATIENT_PRESENCE),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget itemPatientPresence({required PatientPresence patientPresence}) {
    var countQty = 0;
    patientPresence.rooms?.forEach((element) {
      countQty += element.qty ?? 0;
    });

    return InkWell(
      onTap: () {
        Get.toNamed(Routes.MANAGE_PATIENT_PRESENCE, arguments: patientPresence);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PaddingValues.paddingMain, vertical: PaddingValues.paddingHalf),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kunjungan Pasein Tanggal ${parseDate(patientPresence.date ?? "-", controller.apiDateFormat, controller.inputDateFormat)}",
              style: TextStyleValues.font14Bold,
            ),
            const SizedBox(height: PaddingValues.cardRadius),
            Text(
              "Sebanyak $countQty Pasien",
              style: TextStyleValues.font14Regular.copyWith(
                color: ColorsValues.black3
              ),
            ),
          ],
        ),
      )
    );
  }
}
