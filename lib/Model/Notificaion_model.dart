class NotificationModel {
  final String sender;

  final String avatar;
  final String title;
  final String content;
  final int status;

  NotificationModel.NotificationModel({
    required this.sender,
    required this.avatar,
    required this.title,
    required this.content,
    required this.status,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel.NotificationModel(
      sender: json['sender'],
      avatar: json['avatar'],
      title: json['title'],
      content: json['content'],
      status: json['status'],
    );
  }
}
