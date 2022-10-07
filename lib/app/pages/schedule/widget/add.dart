import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/schedule/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/textfield.dart';

class PickSchedule {
  final SchedulePageController controller = Get.find<SchedulePageController>();
  void bottomSheet() {
    showModalBottomSheet(
      context: Get.overlayContext!,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          controller: controller.draggableScrollableController,
          initialChildSize: 0.5,
          minChildSize: 0.1,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                  color: AppColorTheme.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          height: 5,
                          width: 100,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("일정 등록",
                                style: AppTextTheme.mediumGray1_20),
                            const SizedBox(height: 16),
                            const Text("일정 이름",
                                style: AppTextTheme.mediumGray2_14),
                            GTTextFormField(
                              controller: controller.scheduleNameController,
                            ),
                            const SizedBox(height: 16),
                            const Text("기간",
                                style: AppTextTheme.mediumGray2_14),
                            GTTextFormField(
                              readOnly: true,
                              onTap: controller.pickDateRange,
                              controller: controller.rangeDateController,
                            ),
                            const SizedBox(height: 16),
                            controller.obx(
                              (_) => Obx(
                                () => GTKeyboardReactiveButton(
                                  disabled: !controller.inputValidity,
                                  onTap: controller.inputValidity
                                      ? controller.addSchedule
                                      : null,
                                  child: const Text(
                                    "추가하기",
                                    style: AppTextTheme.boldWhite_18,
                                  ),
                                ),
                              ),
                              onLoading: const GTKeyboardReactiveButton(
                                disabled: false,
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColorTheme.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
