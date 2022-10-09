import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/models/schedule.dart';
import 'package:glint/app/data/module/schedule/repository.dart';

class ScheduleController extends GetxController
    with StateMixin<List<Schedule>> {
  final ScheduleRepository repository;
  ScheduleController(this.repository);

  final Rx<List<Schedule>> _scheduleList = Rx<List<Schedule>>([]);
  List<Schedule> get scheduleList => _scheduleList.value;

  @override
  void onInit() {
    fetchScheduleList();
    super.onInit();
  }

  Future fetchScheduleList() async {
    try {
      _scheduleList.value = await repository.getScheduleList();
    } on DioError {
      rethrow;
    }
  }

  //add
  Future addSchedule(String name, String startingAt, String endingAt) async {
    try {
      Map result = await repository.makeSchedule(name, startingAt, endingAt);
      if (result["status"] == "success") {
        fetchScheduleList();
      }
    } on DioError {
      rethrow;
    }
  }
}
