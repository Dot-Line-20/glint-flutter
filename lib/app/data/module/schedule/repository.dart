import 'package:glint/app/data/provider/api_interface.dart';

class ScheduleRepository {
  GTApiInterface api;
  ScheduleRepository(this.api);

  // getScheduleList
  Future<Map> getScheduleList() async {
    Map result = await api.getScheduleList();
    return result;
  }

  // makeSchedule
  Future<Map> makeSchedule(
      String name, String startingAt, String endingAt) async {
    Map result = await api.makeSchedule(name, startingAt, endingAt);
    return result;
  }
}
