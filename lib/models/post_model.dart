class PostModel {
  final dynamic data;
  final bool? success;
  final String? message;

  PostModel({
    this.data,
    this.success,
    this.message,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      data: json['data'],
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'success': success,
      'message': message,
    };
  }
}
