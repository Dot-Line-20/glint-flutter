import 'package:glint/app/data/provider/api_interface.dart';

class AuthRepository {
  final GTApiInterface api;

  AuthRepository(this.api);

  Future<Map> login(String email, String password) async {
    return await api.login(email, password);
  }

  ///returnes Register Result
  ///[email] is the email of the user
  ///[password] is the password of the user
  ///[name] is the name of the user
  ///[birth] is the birth of the user
  Future<Map> registerUser(
      String email, String password, String name, String birth) async {
    return await api.registerUser(email, password, name, birth);
  }

  ///refreshes the token
  ///[refreshToken] is the refresh token of the user
  ///returns the new token
  ///if the refresh token is invalid, returns null
  ///if the refresh token is valid, returns the new token
  Future refreshAccessToken(String refreshToken) async {
    return await api.refreshToken(refreshToken);
  }
}
