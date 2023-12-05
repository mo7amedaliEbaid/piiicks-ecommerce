import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/application/notifications_cubit/notifications_cubit.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    context.read<NotificationsCubit>().getSavedNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Notifications", context,
          automaticallyImplyLeading: true),
      body: BlocBuilder<NotificationsCubit, List<String>>(
        builder: (context, notifications) {
          return Padding(
            padding: Space.all(1, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (notifications.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: AppDimensions.normalize(110)),
                      child: Text(
                        'No Notifications',
                        style: AppText.b1b,
                      ),
                    ),
                  ),
                for (var notification in notifications)
                  Padding(
                    padding: Space.v!,
                    child: DottedBorder(
                      child: Padding(
                        padding: Space.all(),
                        child: Text(
                          notification,
                          style: AppText.b1b?.copyWith(height: 1.7),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NotificationsCubit>().clearNotifications();
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
