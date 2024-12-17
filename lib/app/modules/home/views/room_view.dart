import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:poleks/app/values/text_style_values.dart';

import '../../../data/room.dart';
import '../../../values/color_values.dart';
import '../../../values/padding_values.dart';
import '../controllers/home_controller.dart';

class RoomView extends GetView<HomeController> {
  const RoomView({super.key});
  @override
  Widget build(BuildContext context) {
    if(controller.listRoom.isEmpty) controller.readRoom();

    return Scaffold(
      backgroundColor: ColorsValues.white,
      body: Obx((){
          return RefreshIndicator(
            onRefresh: () async => controller.readRoom(),
            color: ColorsValues.colorPrimary,
            child: ListView.separated(
              itemBuilder: (context, index) => itemRoom(room: controller.listRoom[index]),
              separatorBuilder: (context, index) => const Divider(
                color: ColorsValues.black5,
                thickness: 1,
                height: 1,
              ),
              itemCount: controller.listRoom.length,
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsValues.colorPrimary,
        tooltip: 'Tambah Poli',
        onPressed: () => controller.showBottomSheetAddOrUpdateRoom(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget itemRoom({required Room room}) {
    return InkWell(
      onTap: () {
        controller.showBottomSheetAddOrUpdateRoom(room: room);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PaddingValues.paddingMain, vertical: PaddingValues.paddingHalf),
        child: Text(
          room.name ?? "",
          style: TextStyleValues.font14Medium,
        ),
      )
    );
  }
}
