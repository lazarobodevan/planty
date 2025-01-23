import 'dart:async';

import 'package:app/models/socket_response.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../services/web_socket_service.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  final WebSocketService _webSocketService = WebSocketService(
      channel: WebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8080')));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Planta",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<SocketResponse>(
          stream: _webSocketService.messages,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Erro: ${snapshot.error}"));
            }

            final socketResponse = snapshot.data;

            return Table(
              border: TableBorder.all(color: Colors.black12),
              children: [
                TableRow(children: [Text(""), Text("Esperado"), Text("Leitura atual")]),
                TableRow(children: [
                  Text("Luz"),
                  Text("45%"),
                  Text("${socketResponse?.lux ?? -1} lux")
                ]),
                TableRow(children: [
                  Text("Temperatura"),
                  Text("20ºC - 30ºC"),
                  Text("${socketResponse?.temperature ?? -1}ºC")
                ]),
                TableRow(children: [
                  Text("Umidade"),
                  Text("60% - 80%"),
                  Text("${socketResponse?.moisture ?? -1}")
                ]),
              ],
            );
          },
        ),
      ),
    );
  }
}
