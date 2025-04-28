class ApiResponse {
  final int status;
  final Message msg;

  ApiResponse({required this.status, required this.msg});

  // Factory constructor to create an instance from a JSON map
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      msg: Message.fromJson(json['msg']),
    );
  }

  // Convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg.toJson(),
    };
  }
}

class Message {
  final String title;
  final String description;
  final String periodMsg;
  final String image;
  final String color;

 const Message({required this.title, required this.description, required this.image, required this.periodMsg,  required this.color});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      image: json['image'],
      periodMsg: json['periodMsg'] ?? json['ovlOrNextPeriodMsg'],
      color: json['textColor']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      "textColor":color
    };
  }
}
