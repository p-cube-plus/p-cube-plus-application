import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Message {
  final String message;

  Message({required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(message: json['message']);
  }
}
