import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/schedule/repository.dart';

class ScheduleController extends GetxController with StateMixin<List<Map>> {
  final ScheduleRepository repository;
  ScheduleController(this.repository);

  Rx<List<dynamic>> _scheduleList = Rx<List<dynamic>>([]);
  List<dynamic> get scheduleList => _scheduleList.value;

  @override
  void onInit() {
    fetchScheduleList();
    super.onInit();
  }

  Future fetchScheduleList() async {
    try {
      Map result = await repository.getScheduleList();
      _scheduleList.value = result["data"];
    } on DioError catch (e) {
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
    } on DioError catch (e) {
      rethrow;
    }
  }
}
