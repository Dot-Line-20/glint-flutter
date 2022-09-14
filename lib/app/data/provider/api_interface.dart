abstract class FGBPApiInterface {
  Future<Map> login(String email, String password);
  Future<Map> registerUser(
      String email, String password, String name, String birth);
}
