class Message {
  final String from;  // Who sent the message
  final String message;  // The message content
  final DateTime timestamp;  // When the message was sent

  Message({required this.from, required this.message, required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      from: json['from'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'message': message,
    };
  }
}
