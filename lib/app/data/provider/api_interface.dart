import 'package:file_picker/file_picker.dart';
import 'package:glint/app/data/models/comment.dart';
import 'package:glint/app/data/models/post.dart';
import 'package:glint/app/data/models/schedule.dart';
import 'package:glint/app/data/models/user.dart';

abstract class GTApiInterface {
  // AUTH
  Future<Map> login(String email, String password);
  Future<Map> registerUser(
      String email, String password, String name, String birth);
  Future<Map> refreshToken(String refreshToken);
  // USER
  Future<User> getUser();
  Future<Map> updateUser(
      String email, String password, String name, String birth, String image);
  Future<void> deleteUser(String userId);
  Future<int> getSuccessRate();

  //SCHEDULE
  Future<Map> makeSchedule(String name, String startingAt, String endingAt);
  Future<List<Schedule>> getScheduleList();
  Future<Map> getSchedule(String scheduleId);
  Future<Map> updateSchedule(String scheduleId, String name, String startingAt,
      String endingAt, bool isSuccess);
  Future<void> deleteSchedule(String scheduleId);

  // POST
  Future<void> createPost(String title, String content, List<int> mediaIds);
  Future<List<Post>> getPosts();
  Future<void> updatePost(int postId, String title, String content);
  Future<void> deletePost(int postId);

  // LIKE
  Future<void> likePost(int postId);
  Future<void> unlikePost(int postId);

  // COMMENT
  Future<void> createComment(int postId, String content);
  Future<List<Comment>> getComments(int postId);
  Future<void> updateComment(int postId, int commentId, String content);
  Future<void> deleteComment(int postId, int commentId);

  // MEDIA
  Future<List<int>> uploadFile(
      FilePickerResult result, Function(int, int)? onSendProgress);
  Future<List<int>> uploadManyFiles(FilePickerResult result);
  Future<void> getFile(String fileId);
}
