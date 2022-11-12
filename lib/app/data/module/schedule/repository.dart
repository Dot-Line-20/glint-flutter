import 'package:glint/app/data/module/schedule/schedule.dart';
import 'package:glint/app/data/provider/api_interface.dart';

class ScheduleRepository {
  GTApiInterface api;
  ScheduleRepository(this.api);

  // getScheduleList
  Future<List<Schedule>> getScheduleList() => api.getScheduleList();

  // makeSchedule
  Future<Schedule> makeSchedule(
          int? parentScheduleId,
          String name,
          String content,
          String startingAt,
          String endingAt,
          List<int> categoryIds) =>
      api.makeSchedule(
        parentScheduleId,
        name,
        content,
        startingAt,
        endingAt,
        categoryIds,
      );
}
