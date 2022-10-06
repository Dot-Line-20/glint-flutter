abstract class FGBPApiInterface {
  Future<Map> login(String email, String password);
  Future<Map> registerUser(
      String email, String password, String name, String birth);
  Future<Map> refreshToken(String refreshToken);
  Future<Map> getUser();
  Future<Map> updateUser(
      String email, String password, String name, String birth, String image);
  Future<void> deleteUser(String userId);
  Future<Map> makeSchedule(String name, String startingAt, String endingAt);
  Future<Map> getScheduleList();
  Future<Map> getSchedule(String scheduleId);
  Future<Map> updateSchedule(String scheduleId, String name, String startingAt,
      String endingAt, bool isSuccess);
  Future<void> deleteSchedule(String scheduleId);
  Future<Map> getSuccessRate();
}
