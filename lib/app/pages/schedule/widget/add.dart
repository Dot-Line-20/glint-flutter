import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/schedule/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/textfield.dart';

class PickSchedule {
  final SchedulePageController controller = Get.find<SchedulePageController>();
  void show() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: Get.overlayContext!,
      isScrollControlled: true,
      isDismissible: true, // set this to true
      useRootNavigator: true,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          controller: controller.draggableScrollableController,
          initialChildSize: 0.9,
          minChildSize: 0.1,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("일정 등록", style: AppTextTheme.T3),
                              Obx(
                                () => TextButton(
                                    onPressed: () {
                                      controller.inputValidity
                                          ? controller.addSchedule()
                                          : null;
                                    },
                                    child: Text(
                                      "등록",
                                      style: AppTextTheme.Explain.copyWith(
                                          color: controller.inputValidity
                                              ? AppColorTheme.BUTTON1
                                              : AppColorTheme.Gray2),
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text("일정 이름",
                              style: AppTextTheme.Main.copyWith(
                                  color: AppColorTheme.Gray2)),
                          GTTextFormField(
                            controller: controller.scheduleNameController,
                          ),
                          const SizedBox(height: 16),
                          Text("일정 내용",
                              style: AppTextTheme.Main.copyWith(
                                  color: AppColorTheme.Gray2)),
                          GTTextFormField(
                            controller: controller.scheduleContentController,
                          ),
                          const SizedBox(height: 16),

                          // Switch with 하루종일
                          Row(
                            children: [
                              Text("하루종일",
                                  style: AppTextTheme.T5
                                      .copyWith(color: AppColorTheme.Gray2)),
                              //small Size Switch
                              Obx(
                                () => Switch(
                                  value: controller.isAllDay.value,
                                  onChanged: (value) {
                                    controller.isAllDay.value = value;
                                  },
                                  activeColor: AppColorTheme.BUTTON1,
                                ),
                              ),
                            ],
                          ),

                          Text("시작",
                              style: AppTextTheme.Main.copyWith(
                                  color: AppColorTheme.Gray2)),
                          GTTextFormField(
                            readOnly: true,
                            onTap: () => controller.pickSchedule(),
                            controller: controller.scheduleStartController,
                          ),

                          const SizedBox(height: 16),
                          Text("종료",
                              style: AppTextTheme.Main.copyWith(
                                  color: AppColorTheme.Gray2)),
                          GTTextFormField(
                            readOnly: true,
                            onTap: () =>
                                controller.pickSchedule(isStart: false),
                            controller: controller.scheduleEndController,
                          ),

                          const SizedBox(height: 16),
                          //categories
                          Text("카테고리",
                              style: AppTextTheme.Main.copyWith(
                                  color: AppColorTheme.Gray2)),
                          _categoryPicker(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Row _categoryPicker() {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 25,
              maxHeight: 30,
            ),
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.value.length,
                itemBuilder: (context, index) {
                  // radius random color
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColorTheme.BUTTON1,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Text(
                        controller.categories.value[index].name,
                        style: AppTextTheme.T6
                            .copyWith(color: AppColorTheme.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        // add iconbutton
        GTIconButton(
          "assets/images/rabbi.svg",
          onTap: controller.getCategory,
        ),
      ],
    );
  }
}
