import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/schedule/schedule.dart';
import 'package:glint/app/data/module/schedule/repository.dart';
import 'package:glint/app/widgets/snackbar.dart';

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
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
    }
  }

  //add
  Future addSchedule(
    String name,
    String content,
    String startingAt,
    String endingAt,
    List<int> categoryIds,
  ) async {
    try {
      Schedule result = await repository.makeSchedule(
        name,
        content,
        startingAt,
        endingAt,
        categoryIds,
      );
      _scheduleList.value.add(result);
      _scheduleList.refresh();
    } on DioError catch (e) {
      print(e.response!.data);
      GTSnackBar.open(e.message);
    }
  }
}
