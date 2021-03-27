import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

import 'package:flutter_offline_chat/classes/general.dart';
import 'package:flutter_offline_chat/classes/models.dart';

class Server {
  Server({this.onError, this.onData});

  Uint8ListCallback onData;
  DynamicCallback onError;
  ServerSocket server;
  bool running = false;
  List<Socket> sockets = [];

  start() async {
    runZonedGuarded(() async {
      server = await ServerSocket.bind(General.serverIp, General.defaultServerPort);
      this.running = true;
      server.listen(onRequest);
      this.onData(Uint8List.fromList('Localhost Server listening on port 4040'.codeUnits));
    }, (Object error, StackTrace stack) async {
      this.onError(error);
    });
  }

  stop() async {
    await this.server?.close();
    this.server = null;
    this.running = false;
  }

  broadCast(String message) {
    print(2);
    // ' ${controller.text}'
    this.onData(Uint8List.fromList('${DateTime.now().microsecondsSinceEpoch}:Server: $message'.codeUnits));
    if(sockets.isNotEmpty) {
      print(Uint8List.fromList('${DateTime.now().microsecondsSinceEpoch}:Server: $message'.codeUnits).length);
      print(utf8.encode('${DateTime
          .now()
          .microsecondsSinceEpoch}:Server: $message'.codeUnits.toString()).length);
      // sockets.last.write(
      //     utf8.encode('${DateTime
      //         .now()
      //         .microsecondsSinceEpoch}:Server: $message'.codeUnits.toString()));
    }
    // print(message.length);
    // print(sockets.last.done)
    // for (Socket socket in sockets) {
    //   socket.write(
    //       Uint8List.fromList('${DateTime
    //           .now()
    //           .microsecondsSinceEpoch}:Server: $message'.codeUnits).toString());
    // // socket.write(
    // //       '${DateTime.now().microsecondsSinceEpoch}:Server: $message');
    // }
  }

  onRequest(Socket socket) {
    if (!sockets.contains(socket)) {
      sockets.add(socket);
    }
    socket.listen((Uint8List data) {
      this.onData(data);
    });
  }
}
