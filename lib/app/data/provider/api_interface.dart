import 'package:file_picker/file_picker.dart';
import 'package:glint/app/data/module/category/category.dart';
import 'package:glint/app/data/service/chat/chat.dart';
import 'package:glint/app/data/module/comment/comment.dart';
import 'package:glint/app/data/module/post/post.dart';
import 'package:glint/app/data/module/schedule/schedule.dart';
import 'package:glint/app/data/module/user/user.dart';

abstract class GTApiInterface {
  // AUTH
  Future<Map> login(String email, String password);
  Future<Map> registerUser(
      String email, String password, String name, String birth);
  Future<Map> refreshToken(String refreshToken);
  // USER
  Future<User> getUser();
  Future<User> getOtherUser(int userId);
  Future<Map> updateUser(
      String email, String password, String name, String birth, String image);
  Future<void> deleteUser(String userId);
  Future<int> getSuccessRate();
  Future<MetaData> getMetaData();

  //SCHEDULE
  Future<Schedule> makeSchedule(
    int? parentScheduleId,
    String name,
    String content,
    String startingAt,
    String endingAt,
    List<int> categoryIds,
  );
  Future<List<Schedule>> getScheduleList();
  Future<Map> getSchedule(String scheduleId);
  Future<Map> updateSchedule(String scheduleId, String name, String startingAt,
      String endingAt, bool isSuccess);
  Future<void> deleteSchedule(String scheduleId);

  // POST
  Future<void> createPost(
      String title, String content, List<int> mediaIds, List<int> categoryIds);
  Future<List<Post>> getPosts(int index, int size);
  Future<void> updatePost(int postId, String title, String content);
  Future<void> deletePost(int postId);

  // LIKE
  Future<void> likePost(int postId);
  Future<void> unlikePost(int postId);

  // COMMENT
  Future<Comment> createComment(int postId, String content);
  Future<List<Comment>> getComments(int postId);
  Future<void> updateComment(int postId, int commentId, String content);
  Future<void> deleteComment(int postId, int commentId);

  // MEDIA
  Future<List<int>> uploadFile(
      FilePickerResult result, Function(int, int)? onSendProgress);
  Future<List<int>> uploadFileForWeb(
      FilePickerResult result, Function(int, int)? onSendProgress);
  Future<List<int>> uploadManyFiles(
      FilePickerResult result, Function(int, int)? onSendProgress);
  Future<List<int>> uploadManyFilesForWeb(
      FilePickerResult result, Function(int, int)? onSendProgress);
  Future<void> getFile(String fileId);

  // CATEGORY
  Future<Category> createCategory(String name);
  Future<List<Category>> getCategories(String partialName);
  Future<Category> getCategorie(int categoryId);

  //CHAT
  Future<ChatRoom> createChatRoom(String name, List<int> userIds);
  Future<List<ChatRoom>> getChatRooms();
  Future<List<ChatMessage>> getChatMessages(int chatId);
}
