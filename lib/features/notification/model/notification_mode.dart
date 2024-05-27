import 'package:thread_clone/features/home/model/user_model.dart';

class NottificationModel {
  int? id;
  int? threadId;
  String? notification;
  String? createdAt;
  String? userId;
  UserModel? user;

  NottificationModel(
      {this.id,
      this.threadId,
      this.notification,
      this.createdAt,
      this.userId,
      this.user});

  NottificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    threadId = json['thread_id'];
    notification = json['notification'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['thread_id'] = threadId;
    data['notification'] = notification;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
