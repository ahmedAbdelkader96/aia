class GeneralMessageModel {
  String content;
  bool isMe;

  GeneralMessageModel({required this.content, required this.isMe});

  factory GeneralMessageModel.fromJson(Map<String, dynamic> json) {
    return GeneralMessageModel(content: json['content'], isMe: json['isMe']);
  }

  Map<String, dynamic> toJson() => {"content": content, "isMe": isMe};
}
