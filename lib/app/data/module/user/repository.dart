import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/data/provider/api_interface.dart';

class UserRepository {
  final GTApiInterface api;
  UserRepository(this.api);

  ///returns the user info
  ///if the token is invalid, returns null
  ///if the token is valid, returns the user info
  ///[token] is the token of the user
  ///[userId] is the id of the user
  ///[name] is the name of the user
  ///[email] is the email of the user
  ///[birth] is the birth of the user
  Future<User> getUserInfo(int userId) => api.getUser(userId);

  ///returns the user successRate
  Future<int> getSuccessRate() => api.getSuccessRate();
  Future<MetaData> getMetaData(int userId) => api.getMetaData(userId);
}
