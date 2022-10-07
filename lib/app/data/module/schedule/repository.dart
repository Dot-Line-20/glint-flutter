import 'package:glint/app/data/models/schedule.dart';
import 'package:glint/app/data/provider/api_interface.dart';

class ScheduleRepository {
  GTApiInterface api;
  ScheduleRepository(this.api);

  // getScheduleList
  Future<List<Schedule>> getScheduleList() => api.getScheduleList();

  // makeSchedule
  Future<Map> makeSchedule(
      String name, String startingAt, String endingAt) async {
    Map result = await api.makeSchedule(name, startingAt, endingAt);
    return result;
  }
}
