import 'package:get/get.dart';
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

class ChatService extends GetxController {
  final io = IO.io("https://h2o.vg/socket.io");

  @override
  void onInit() {
    super.onInit();
    io.connect();

    // Handle Socket Status
    io.on(SocketEvent.authLogin.value, (data) {
      print("auth:login");
      print(data);
    });

    io.on(SocketEvent.chatJoin.value, (data) {
      print("chat:join");
      print(data);
    });

    io.on(SocketEvent.chatLeave.value, (data) {
      print("chat:leave");
      print(data);
    });

    io.on(SocketEvent.messageCreate.value, (data) {
      print("message:create");
      print(data);
    });

    io.on(SocketEvent.messageDelete.value, (data) {
      print("message:delete");
      print(data);
    });

    io.on(SocketEvent.messageUpdate.value, (data) {
      print("message:update");
      print(data);
    });
  }

  void authLogin(String accessToken) {
    io.emit(SocketEvent.authLogin.value, {"accessToken": accessToken});
  }

  void enterChatRoom(String roomId) {
    io.emit(SocketEvent.chatJoin.value, {"id": roomId});
  }

  void leaveChatRoom(String roomId) {
    io.emit(SocketEvent.chatLeave.value, roomId);
  }

  void sendMessage(String roomId, String message) {
    io.emit(SocketEvent.messageCreate.value, {
      "roomId": roomId,
      "message": message,
    });
  }
}
