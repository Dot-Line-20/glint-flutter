import 'package:glint/app/data/models/chat.dart';
import 'package:glint/app/data/provider/api_interface.dart';

class ChatRepository {
  final GTApiInterface api;

  ChatRepository(this.api);

  Future<List<ChatRoom>> getChatRoomList() => api.getChatRooms();
  Future<ChatRoom> creatChatRoom(String name, List<int> userIds) =>
      api.createChatRoom(name, userIds);

  Future<List<ChatMessage>> getChatMessage(int chatRoomId) =>
      api.getChatMessages(chatRoomId);
}
