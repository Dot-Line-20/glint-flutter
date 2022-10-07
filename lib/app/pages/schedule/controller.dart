import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/schedule/service.dart';
import 'package:glint/app/pages/schedule/widget/add.dart';
import 'package:glint/app/widgets/snackbar.dart';

class SchedulePageController extends GetxController with StateMixin {
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  List<dynamic> get scheduleList => scheduleController.scheduleList;

  final DateTime now = DateTime.now();

  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  final TextEditingController scheduleNameController = TextEditingController();
  final TextEditingController rangeDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final FocusScopeNode formFocusScopeNode = FocusScopeNode();

  final Rx<String?> scheduleName = Rx(null);
  final Rx<DateTimeRange?> rangeDate = Rx(null);

  bool get inputValidity {
    return scheduleName.value != null && rangeDate.value != null;
  }

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    scheduleNameController.addListener(onScheduleChange);
    super.onInit();
  }

  void onScheduleChange() {
    String data = scheduleNameController.text;
    scheduleName.value = data.isEmpty ? null : data;
    //print(scheduleName.value);
  }

  void pickDateRange() async {
    DateTimeRange? result = await showDateRangePicker(
        context: Get.overlayContext!,
        initialEntryMode: DatePickerEntryMode.calendar,
        currentDate: now,
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year, 12, 31));
    if (result != null) {
      rangeDate.value = result;
      rangeDateController.text =
          '${result.start.year}-${result.start.month}-${result.start.day} ~ ${result.end.year}-${result.end.month}-${result.end.day}';
    }
  }

  void pickSchedule() {
    PickSchedule().bottomSheet();
  }

  void addSchedule() {
    try {
      String startAt = rangeDate.value!.start.toIso8601String();
      String endAt = rangeDate.value!.end.toIso8601String();

      scheduleController.addSchedule(scheduleName.value!, startAt, endAt);
      Get.back();
    } on DioError catch (e) {
      GTSnackBar.open(e.response!.data["data"][0]["title"]);
    }
  }
}
