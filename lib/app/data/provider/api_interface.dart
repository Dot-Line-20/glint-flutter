import 'package:glint/app/data/models/schedule.dart';
import 'package:glint/app/data/models/user.dart';

abstract class GTApiInterface {
  Future<Map> login(String email, String password);
  Future<Map> registerUser(
      String email, String password, String name, String birth);
  Future<Map> refreshToken(String refreshToken);
  Future<User> getUser();
  Future<Map> updateUser(
      String email, String password, String name, String birth, String image);
  Future<void> deleteUser(String userId);
  Future<Map> makeSchedule(String name, String startingAt, String endingAt);
  Future<List<Schedule>> getScheduleList();
  Future<Map> getSchedule(String scheduleId);
  Future<Map> updateSchedule(String scheduleId, String name, String startingAt,
      String endingAt, bool isSuccess);
  Future<void> deleteSchedule(String scheduleId);
  Future<int> getSuccessRate();
}
