import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/socket_response.dart';

class WebSocketService {
  final WebSocketChannel channel;
  late final StreamController<SocketResponse> _controller;

  WebSocketService({required this.channel}) {
    _controller = StreamController<SocketResponse>.broadcast();
    channel.stream.listen((data) {
      // Aqui você pode processar os dados e enviar para o stream
      final socketResponse = parseSocketResponse(data); // Substitua pela lógica real de parsing
      _controller.add(socketResponse);
    });
  }

  Stream<SocketResponse> get messages => _controller.stream;

  void dispose() {
    _controller.close();
  }

  // Método de parsing para converter os dados recebidos em SocketResponse
  SocketResponse parseSocketResponse(dynamic data) {
    // Lógica de parsing do JSON ou outro formato
    return SocketResponse.fromJson(jsonDecode(data));
  }
}
