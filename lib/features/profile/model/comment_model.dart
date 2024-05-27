import 'package:thread_clone/features/home/model/user_model.dart';

class CommentModel {
  int? id;
  String? userId;
  int? threadId;
  String? reply;
  String? createdAt;
  UserModel? user;

  CommentModel(
      {this.id,
      this.userId,
      this.threadId,
      this.reply,
      this.createdAt,
      this.user});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    threadId = json['thread_id'];
    reply = json['reply'];
    createdAt = json['created_at'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['thread_id'] = threadId;
    data['reply'] = reply;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
