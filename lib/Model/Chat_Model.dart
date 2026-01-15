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

class Messages {
  final String content;
  final String time;
  final bool isMe;

  Messages({required this.content, required this.time, required this.isMe});

  factory Messages.fromJson(Map<String, dynamic> json)
  {
    return Messages(
        content: json['contents'],
        time: json['sent at'],
        isMe: json['isMe']
    );
  }

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

class Conversation {
  final String senderName;
  final String senderAvatar;
  final String receiverName;
  final String receiverPhone;
  final String receiverAvatar;
  final String aptImage;
  final String aptTitle;
  final String aptPrice;

  Conversation({
    required this.senderName,
    required this.senderAvatar,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAvatar,
    required this.aptImage,
    required this.aptTitle,
    required this.aptPrice});

  factory Conversation.fromJson(Map<String, dynamic>json){
    return Conversation(
        senderName: json['sender name'],
        senderAvatar: json['sender avatar'],
        receiverName: json['receiver name'],
        receiverPhone: json['receiver phone number'],
        receiverAvatar: json['receiver avatar'],
        aptImage: json['Property information']['image'],
        aptTitle: json['Property information']['title'],
        aptPrice: json['Property information']['price per night']
    );
  }
}
