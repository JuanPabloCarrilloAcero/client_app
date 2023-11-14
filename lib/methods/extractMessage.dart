import 'dart:convert';

String extractMessage(String input) {
  // Split the input by ' - ' to separate the status code and the JSON message
  List<String> parts = input.split(' - ');

  // Parse the JSON message
  Map<String, dynamic> jsonMessage = json.decode(parts[1]);

  // Extract the value associated with the "Valor compra" key
  String message = jsonMessage["Valor compra"][0];
  return message;
}