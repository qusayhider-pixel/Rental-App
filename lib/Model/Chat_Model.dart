class Message {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isMe;

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.isMe,
  });
}

class ChatUser {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;
  final bool isVerified;

  ChatUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isOnline = false,
    this.isVerified = false,
  });
}

class PropertyContext {
  final String title;
  final String imageUrl;
  final String price;

  PropertyContext({
    required this.title,
    required this.imageUrl,
    required this.price,
  });
}

class Chat {
  final int chatID;
  final String? lastMessageContents;
  final String? lastMessageDate;
  final String receiverName;
  final String receiverAvatar;

  Chat({
    required this.chatID,
    required this.lastMessageContents,
    required this.lastMessageDate,
    required this.receiverName,
    required this.receiverAvatar,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatID: json['conversation id'],
      lastMessageContents: json['last message contents'],
      lastMessageDate: json['last message sent at'],
      receiverName: json['receiver name'],
      receiverAvatar: json['receiver avatar'],
    );
  }
}
