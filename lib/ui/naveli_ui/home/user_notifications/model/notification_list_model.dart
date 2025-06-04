class NotificationListModel {
  final List<NotificationData>? data;
  final Pagination? pagination;
  final String? message;

  NotificationListModel({
    this.data,
    this.pagination,
    this.message,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) =>
      NotificationListModel(
        data: json["data"] == null
            ? null
            : List<NotificationData>.from(
                json["data"].map((x) => NotificationData.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "message": message,
      };
}

class NotificationData {
  final String? id;
  final String? name;
  final String? title;
  final String? message;
  final DateTime? time;
  final DateTime? createdAt;
  final dynamic readAt;

  NotificationData({
    this.id,
    this.name,
    this.title,
    this.message,
    this.time,
    this.createdAt,
    this.readAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        message: json["message"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        readAt: json["read_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "message": message,
        "time": time?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "read_at": readAt,
      };
}

class Pagination {
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;
  final dynamic nextPageUrl;
  final dynamic prevPageUrl;

  Pagination({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "per_page": perPage,
        "current_page": currentPage,
        "last_page": lastPage,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
      };
}
