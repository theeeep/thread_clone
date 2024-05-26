class LikesModel {
  String? userId;
  int? threadId;

  LikesModel({this.userId, this.threadId});

  LikesModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    threadId = json['thread_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['thread_id'] = threadId;
    return data;
  }
}
