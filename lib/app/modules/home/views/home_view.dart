import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:get/get.dart';
import 'package:poleks/app/modules/home/views/report_patient_presence_view.dart';

import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../utils/custom_image_network.dart';
import '../../../values/color_values.dart';
import '../../../values/padding_values.dart';
import '../../../values/text_style_values.dart';
import '../controllers/home_controller.dart';
import 'patient_presence_view.dart';
import 'room_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Poliklinik Eksekutif RUSD dr Soekandar",
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: PaddingValues.paddingMain),
            child: GestureDetector(
              onTap: () => CustomDialog.generalAlertDialog(
                title: "Peringatan",
                subTitle: "Apakah kamu ingin keluar dari aplikasi ini ?",
                btnCancelText: "Tidak",
                btnConfirmText: "Ya, Keluar",
                btnConfirmAction: () => controller.signOut(),
              ),
              child: SizedBox( 
                width: 48,
                height: 48,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: CustomImageNetwork.imageNetwork(
                    url : controller.getDataUser()?.photoUrl ?? ""
                  )
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: ColorsValues.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ColorsValues.colorPrimary,
            labelColor: ColorsValues.colorPrimary,
            unselectedLabelColor: ColorsValues.greyBlue,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            controller: controller.controller,
            labelStyle: TextStyleValues.font14Bold,
            unselectedLabelStyle: TextStyleValues.font14Medium,
            tabs: const [
              if(kIsWeb) Tab(text: "Laporan Kunjungan"),
              Tab(text: "Kunjungan Pasien"),
              Tab(text: "Poli"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.controller,
              children: [
                if(kIsWeb) ReportPatientPresenceView(),
                PatientPresenceView(),
                RoomView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
