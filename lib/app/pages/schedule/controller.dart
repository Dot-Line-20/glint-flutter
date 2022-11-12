import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/category/category.dart';
import 'package:glint/app/data/module/schedule/schedule.dart';
import 'package:glint/app/data/module/schedule/controller.dart';
import 'package:glint/app/widgets/snackbar.dart';

class SchedulePageController extends GetxController with StateMixin {
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  List<Schedule> get scheduleList => scheduleController.scheduleList;

  final DateTime now = DateTime.now();

  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  //Schedule Title
  final TextEditingController scheduleNameController = TextEditingController();
  final Rx<String?> scheduleName = Rx(null);
  void onScheduleChange() {
    String data = scheduleNameController.text;
    scheduleName.value = data.isEmpty ? null : data;
    //print(scheduleName.value);
  }

  //Schedule Content
  final TextEditingController scheduleContentController =
      TextEditingController();
  final Rx<String?> scheduleContent = Rx(null);
  void onScheduleContentChange() {
    String data = scheduleContentController.text;
    scheduleContent.value = data.isEmpty ? null : data;
    //print(scheduleContent.value);
  }

  //Schedule Start & End
  final TextEditingController scheduleStartController = TextEditingController();
  final TextEditingController scheduleEndController = TextEditingController();

  final Rx<DateTime?> scheduleStart = Rx(null);
  final Rx<DateTime?> scheduleEnd = Rx(null);

  void pickSchedule({bool isStart = true}) async {
    if (GetPlatform.isIOS) {
      await showCupertinoModalPopup(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            height: 350,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: now,
                    onDateTimeChanged: (DateTime value) {
                      if (isStart) {
                        scheduleStart.value = value;
                        scheduleStartController.text =
                            value.toString().substring(0, 16);
                      } else {
                        scheduleEnd.value = value;
                        scheduleEndController.text =
                            value.toString().substring(0, 16);
                      }
                    },
                  ),
                ),
                CupertinoButton(
                  child: const Text("Done"),
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            ),
          );
        },
      );
    } else {
      DateTime? picked = await showDatePicker(
        context: Get.overlayContext!,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        if (isAllDay.value) {
          if (isStart) {
            //"${picked.start.year}-${picked.start.month}-${picked.start.day}
            scheduleStart.value = picked;
            scheduleStartController.text = picked.isAllDay;
          } else {
            scheduleEnd.value = picked;
            scheduleEndController.text = picked.isAllDay;
          }
          return;
        }

        TimeOfDay? pickedTime = await showTimePicker(
          context: Get.overlayContext!,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          DateTime pickedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          if (isStart) {
            //"${picked.start.year}-${picked.start.month}-${picked.start.day}
            scheduleStart.value = pickedDateTime;

            scheduleStartController.text = isAllDay.value
                ? pickedDateTime.isAllDay
                : pickedDateTime.format;
          } else {
            scheduleEnd.value = pickedDateTime;
            scheduleEndController.text = isAllDay.value
                ? pickedDateTime.isAllDay
                : pickedDateTime.format;
          }
        }
      }
    }
  }

  // isAllDay
  final RxBool isAllDay = false.obs;

  // Category
  Rx<List<Category>> categories = Rx([]);
  void getCategory() async {
    categories.value = await Get.toNamed("/category");
  }

  final formKey = GlobalKey<FormState>();
  final FocusScopeNode formFocusScopeNode = FocusScopeNode();

  bool get inputValidity {
    return scheduleName.value != null &&
        scheduleContent.value != null &&
        scheduleStart.value != null &&
        scheduleEnd.value != null;
  }

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    scheduleNameController.addListener(onScheduleChange);
    scheduleContentController.addListener(onScheduleContentChange);

    // change isAllDay With Text
    isAllDay.listen((value) {
      if (value) {
        scheduleStartController.text = scheduleStart.value?.isAllDay ?? "";
        scheduleEndController.text = scheduleEnd.value?.isAllDay ?? "";
      } else {
        scheduleStartController.text = scheduleStart.value?.format ?? "";
        scheduleEndController.text = scheduleEnd.value?.format ?? "";
      }
    });

    super.onInit();
  }

  void addSchedule() async {
    if (isAllDay.value) {
      scheduleStart.value = DateTime(
        scheduleStart.value!.year,
        scheduleStart.value!.month,
        scheduleStart.value!.day,
        0,
        0,
      );
      scheduleEnd.value = DateTime(
        scheduleEnd.value!.year,
        scheduleEnd.value!.month,
        scheduleEnd.value!.day,
        23,
        59,
      );
    }

    String startAt = scheduleStart.value!.toIso8601String();
    String endAt = scheduleEnd.value!.toIso8601String();

    List<int> categoryIds = categories.value.map((e) => e.id).toList();

    await scheduleController.addSchedule(scheduleName.value!,
        scheduleContent.value!, startAt, endAt, categoryIds);

    scheduleContentController.clear();
    scheduleNameController.clear();
    scheduleStartController.clear();
    scheduleEndController.clear();
    categories.value = [];
    scheduleName.value = null;
    scheduleContent.value = null;
    scheduleStart.value = null;
    scheduleEnd.value = null;
    isAllDay.value = false;

    Get.back();
  }
}

extension DateTimeFormat on DateTime {
  String get format {
    //월화수목금토일
    String day = ["월", "화", "수", "목", "금", "토", "일"][weekday - 1];
    //오전 / 오후
    String ampm = hour < 12 ? "오전" : "오후";

    return "$month월 ${this.day}일 ($day) $ampm ${hour % 12}시 $minute분 ";
  }

  String get isAllDay {
    //월화수목금토일
    String day = ["월", "화", "수", "목", "금", "토", "일"][weekday - 1];
    //오전 / 오후

    return "$month월 ${this.day}일 ($day)";
  }
}
