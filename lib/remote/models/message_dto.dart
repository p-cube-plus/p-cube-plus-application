class MessageDTO {
  final String message;

  MessageDTO({required this.message});

  factory MessageDTO.fromJson(Map<String, dynamic> json) {
    return MessageDTO(message: json['message']);
  }
}
