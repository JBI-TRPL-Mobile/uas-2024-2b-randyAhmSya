class Messegemodel {
  final String id;
  final String senderId;
  final String receiverId;
  final String messege;
  final DateTime timestamp;
  final bool isRead;

  Messegemodel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.messege,
    required this.timestamp,
    this.isRead = false,
  });

  factory Messegemodel.fromJson(Map<String, dynamic> json) {
    return Messegemodel(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      messege: json['messege'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
    );
  }

  String get content => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'messege': messege,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }
}
