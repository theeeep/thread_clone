import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/navigation_service.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/features/home/widgets/loading_widget.dart';
import 'package:thread_clone/features/notification/controller/notification_controller.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notificationController = Get.put(NotificationController());
  final supabaseService = Get.find<SupabaseService>();

  @override
  void initState() {
    notificationController
        .fetchNotificatons(supabaseService.currentUser.value!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.find<NavigationService>().backToPevPage,
          icon: const Icon(Icons.close),
        ),
        title: const Text("Notifcations"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => notificationController.loading.value
              ? const LoadingWidget()
              : Column(
                  children: [
                    if (notificationController.notificationList.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            notificationController.notificationList.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatarDp(
                            radius: 25,
                            url: notificationController
                                .notificationList[index].user?.metadata?.image,
                          ),
                          title: Text(
                            notificationController
                                .notificationList[index].user!.metadata!.name!,
                          ),
                          trailing: Text(
                            formatDate(notificationController
                                .notificationList[index].createdAt!),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              letterSpacing: 1.5,
                              color: AppPallete.gradient3,
                            ),
                          ),
                          subtitle: Text(
                            notificationController
                                .notificationList[index].notification!,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      )
                    else
                      const Center(child: Text("0 Notifaction! ")),
                  ],
                ),
        ),
      ),
    );
  }
}
