import 'dart:developer';

import 'package:get/get.dart';
import 'package:glint/app/data/service/auth/service.dart';
import 'package:glint/app/data/service/chat/chat.dart';
import 'package:glint/app/data/service/chat/repository.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum SocketStatus { connecting, connected, disconnecting, disconnected }

enum SocketEvent {
  authLogin,
  chatJoin,
  chatLeave,
  messageCreate,
  messageDelete,
  messageUpdate,
}

extension SocketEventExtension on SocketEvent {
  String get value {
    switch (this) {
      case SocketEvent.authLogin:
        return "auth:login";
      case SocketEvent.chatJoin:
        return "chat:join";
      case SocketEvent.chatLeave:
        return "chat:leave";
      case SocketEvent.messageCreate:
        return "message:create";
      case SocketEvent.messageDelete:
        return "message:delete";
      case SocketEvent.messageUpdate:
        return "message:update";
    }
  }
}

class ChatService extends GetxService {
  ChatRepository repository;
  ChatService(this.repository);

  final io = IO.io("https://h2o.vg", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });

  final Rx<List<ChatRoom>> chatRooms = Rx([]);
  Rx<List<Message>> messages = Rx([]);

  Future<ChatService> init() async {
    log("[CHAT SERVICE] init");

    io.connect();
    io.onConnect((id) {
      log("[CHAT SERVICE] connected :id $id");
      authLogin();
    });

    // Handle Socket Status
    io.on(SocketEvent.authLogin.value, (data) {
      log("[CHAT SERVICE] authLogin");
    });

    io.on(SocketEvent.chatJoin.value, (data) {
      log("[CHAT SERVICE] chatJoin");
    });

    io.on(SocketEvent.chatLeave.value, (data) {
      log("[CHAT SERVICE] chatLeave");
    });

    io.on(SocketEvent.messageCreate.value, (data) {
      log("[CHAT SERVICE] messageCreate");
      Message message = Message.fromJson(data["data"]);
      messages.value.add(message);
      messages.refresh();
    });

    io.on(SocketEvent.messageDelete.value, (data) {
      log("[CHAT SERVICE] messageDelete");
    });

    io.on(SocketEvent.messageUpdate.value, (data) {
      log("[CHAT SERVICE] messageUpdate");
    });

    chatRooms.value = await getChatRooms();

    log("[CHAT SERVICE] init done");

    return this;
  }

  void authLogin() async {
    String accessToken = Get.find<AuthService>().accessToken!;
    io.emit(SocketEvent.authLogin.value, {"accessToken": accessToken});
  }

  void enterChatRoom(int roomId) {
    messages.value.clear();
    io.emit(SocketEvent.chatJoin.value, {"id": roomId});
  }

  void leaveChatRoom() {
    messages.value.clear();
    io.emit(SocketEvent.chatLeave.value);
  }

  void sendMessage(String message) {
    io.emit(SocketEvent.messageCreate.value, {
      "content": message,
    });
  }

  void deleteMessage(int messageId) {
    io.emit(SocketEvent.messageDelete.value, {
      "id": messageId,
    });
  }

  Future<List<ChatRoom>> getChatRooms() async {
    return repository.getChatRoomList();
  }

  Future<List<ChatMessage>> getChatMessages(int roomId,
      {int index = 0, int size = 10}) async {
    return repository.getChatMessage(roomId, index: index, size: size);
  }

  @override
  void onClose() {
    io.disconnect();
    super.onClose();
  }
}
