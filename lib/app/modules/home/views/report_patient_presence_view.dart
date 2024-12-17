import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:poleks/app/data/patient_presence.dart';
import 'package:poleks/app/values/color_values.dart';
import 'package:poleks/app/values/text_style_values.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../../widgets/custom_text_form_field_drop_down.dart';
import '../../../values/image_values.dart';
import '../../../values/padding_values.dart';
import '../controllers/home_controller.dart';

class ReportPatientPresenceView extends GetView<HomeController> {
  const ReportPatientPresenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValues.white,
      body: Obx(() {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(PaddingValues.paddingMain),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextFormFieldDropDown(
                          hint: "Pilih Tahun",
                          selectedItem: controller.selectedDropDownYear.value?.value,
                          suffixIcon: ImageValues.icDropDown,
                          tintIcon: ColorsValues.colorPrimary,
                          items:  controller.dropDownYear,
                          onChanged: (String? value) => controller.onSelectedYear(value: value),
                        ),
                      ),
                      const SizedBox(width: PaddingValues.paddingMain),
                      Expanded(
                        flex: 1,
                        child: CustomTextFormFieldDropDown(
                          hint: "Pilih Bulan",
                          selectedItem: controller.selectedDropDownMonth.value?.value,
                          suffixIcon: ImageValues.icDropDown,
                          tintIcon: ColorsValues.colorPrimary,
                          items:  controller.dropDownMonth,
                          onChanged: (String? value) => controller.onSelectedMonth(value: value),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: controller.selectedDropDownYear.value != null && controller.selectedDropDownMonth.value != null && controller.listRoomPresence.isNotEmpty,
                    child: Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: PaddingValues.paddingMain),
                        child: SfCartesianChart(
                          primaryXAxis: const CategoryAxis(
                            labelStyle: TextStyleValues.font14Regular,
                            labelRotation: 90,
                          ),
                          title: ChartTitle(
                            text: 'Laporan Kunjungan Pasien Bulan ${controller.selectedDropDownMonth.value?.valueName} ${controller.selectedDropDownYear.value?.value}',
                            textStyle: TextStyleValues.font16Bold
                          ),
                          tooltipBehavior: TooltipBehavior(enable: true,),
                          series: <CartesianSeries<RoomsPresence, String>>[
                            ColumnSeries<RoomsPresence, String>(
                              dataSource:  controller.listRoomPresence,
                              xValueMapper: (RoomsPresence room, _) => room.name,
                              yValueMapper: (RoomsPresence room, _) => room.qty,
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                margin: const EdgeInsets.all(PaddingValues.paddingHalf),
                                labelAlignment: ChartDataLabelAlignment.middle,
                                textStyle: TextStyleValues.font14Medium.copyWith(color: ColorsValues.white),
                                overflowMode: OverflowMode.trim
                              ),
                              name: "Bulan ${controller.selectedDropDownMonth.value?.valueName}",
                              color: ColorsValues.orange,
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.selectedDropDownYear.value == null || controller.selectedDropDownMonth.value == null || controller.listRoomPresence.isEmpty,
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            "Data belum tersedia",
                            style: TextStyleValues.font16Medium,
                          ),
                          const SizedBox(height: PaddingValues.paddingHalf),
                          Text(
                            "Pilih bulan dan tahun terlebih dahulu",
                            style: TextStyleValues.font14Regular.copyWith(
                              color: ColorsValues.black1
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}
