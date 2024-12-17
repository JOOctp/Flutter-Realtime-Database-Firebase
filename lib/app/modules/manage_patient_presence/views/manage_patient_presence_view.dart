import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:poleks/app/data/patient_presence.dart';
import 'package:poleks/app/values/text_style_values.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button_outline_colored.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../utils/date_util.dart';
import '../../../values/color_values.dart';
import '../../../values/image_values.dart';
import '../../../values/padding_values.dart';
import '../controllers/manage_patient_presence_controller.dart';

class ManagePatientPresenceView extends GetView<ManagePatientPresenceController> {
  const ManagePatientPresenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: controller.patientPresence.value != null ? 'Ubah Kunjungan Pasien' : 'Tambah Kunjungan Pasien',
      ),
      backgroundColor: ColorsValues.white,
      body: Obx((){
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: PaddingValues.paddingMain),
                      child: Column(
                        children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: PaddingValues.paddingMain),
                              child: CustomTextFormField(
                                controller: controller.selectDateController,
                                hint: "Pilih Tanggal Kunjungan",
                                inputType: TextInputType.none,
                                suffixIcon: ImageValues.icCalendar,
                                tintIcon: ColorsValues.black4,
                                isEnable: controller.patientPresence.value == null,
                                onTap: (){
                                  DateUtil.datePicker(context: context, initialDate: DateTime.now()).then((value) {
                                    if(value != null){
                                      var now = DateTime.now().toLocal();
                                      var dateTime = DateTime(
                                          value.year,
                                          value.month,
                                          value.day,
                                          now.hour,
                                          now.minute,
                                          now.second,
                                          now.millisecond,
                                          now.microsecond
                                      );
                                      controller.checkPatientPresenceHasData(date: controller.apiDateFormat.format(dateTime))
                                      .then((value){
                                        if(!value.exists){
                                          controller.selectedDateTime.value = dateTime;
                                          controller.selectDateController.text = controller.inputDateFormat.format(dateTime);
                                        } else {
                                          controller.showErrorToast("Tanggal ${controller.inputDateFormat.format(dateTime)} sudah ada kunjungan pasien");
                                        }
                                      });
                                      
                                    }
                                  }
                                );
                              },
                                                        ),
                            ),
                          const SizedBox(height: PaddingValues.paddingMain),
                          ListView.separated(
                            itemCount: controller.listRoom.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => const Divider(
                              color: ColorsValues.black5,
                              thickness: 1,
                              height: 1,
                            ),
                            itemBuilder: (context, index) => itemRoom(index: index,room: controller.listRoom[index]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: ColorsValues.black5,
                  height: 1,
                  thickness: 1,
                ),
                Container(
                  padding: const EdgeInsets.all(PaddingValues.paddingMain),
                  child: CustomButtonOutlineColored(
                    title: controller.patientPresence.value != null ? 'Ubah Kunjungan Pasien' : "Tambah Kunjungan Pasien", 
                    colorText: controller.selectedDateTime.value != null ? ColorsValues.white : ColorsValues.colorPrimary, 
                    colorButton: controller.selectedDateTime.value != null ? ColorsValues.colorPrimary : ColorsValues.white,
                    colorOutline: ColorsValues.colorPrimary,
                    isEnable: controller.selectedDateTime.value != null,
                    action: (){
                      controller.addPatientPresence();
                    },
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
  
  Widget itemRoom({required int index,required RoomsPresence room}) {
    final qtyController = TextEditingController();
    qtyController.text = room.qty?.toString() ?? "0";
    
    return Container(
      color: index % 2 == 0 ? ColorsValues.white : ColorsValues.black5,
      padding: const EdgeInsets.symmetric(horizontal: PaddingValues.paddingMain),
      child: Row(
        children: [
          Expanded(
            child: Text(
              room.name ?? "",
              style: TextStyleValues.font14Regular,
            ),
          ),
          const SizedBox(width: PaddingValues.paddingMain),
          actionButton(
            icon: Icons.remove, 
            backgroudColor: ColorsValues.white, 
            iconColor: ColorsValues.colorPrimary,
            outlineColor: ColorsValues.colorPrimary,
            action: (){
              var qty = int.parse(qtyController.text);
              qty--;
              qtyController.text = qty < 0 ? "0" : qty.toString();
              controller.listRoom[index].qty = qty < 0 ? 0 : qty;
            }
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: PaddingValues.paddingMain),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: PaddingValues.paddingExtra),
              child: IntrinsicWidth(
                child: TextFormField(
                  controller: qtyController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    controller.listRoom[index].qty = int.parse(value.isEmpty ? "0" : value);
                  },
                  textAlign: TextAlign.center,
                  inputFormatters: controller.digitOnly,
                ),
              ),
            ),
          ),
          actionButton(
            icon: Icons.add, 
            backgroudColor: ColorsValues.colorPrimary, 
            iconColor: ColorsValues.white,
            action: (){
              var qty = int.parse(qtyController.text);
              qty++;
              qtyController.text = qty.toString();
              controller.listRoom[index].qty = qty;
            }
          )
        ],
      ),
    );
  }

  Widget actionButton({required IconData icon, required Color backgroudColor, Color? outlineColor, required Color iconColor, VoidCallback? action}){
    return Skeleton.shade(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          borderRadius: BorderRadius.circular(PaddingValues.paddingExtra),
          child: Ink(
            decoration: BoxDecoration(
              color: backgroudColor,
              borderRadius: BorderRadius.circular(PaddingValues.paddingExtra),
              border: Border.all(
                color: outlineColor ?? backgroudColor,
                width: 1.5
              )
            ),
            child: Container(
              padding: const EdgeInsets.all(PaddingValues.cardRadius),
              child: Center(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              )
            ),
          ),
        ),
      ),
    );
  }

}