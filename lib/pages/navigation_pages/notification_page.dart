import 'package:flutter/material.dart';
import 'package:desktop_test/constant/assets.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/provider/notification_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_app_bar.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/vms/notification/noti_vm.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: EasyAppBar(text: AppLocalizations.of(context)!.noti)),
      backgroundColor: kBackGroundColor,
      body: const NotificationItemView(),
    );
  }
}

class NotificationItemView extends StatefulWidget {
  const NotificationItemView({super.key});

  @override
  State<NotificationItemView> createState() => _NotificationItemViewState();
}

class _NotificationItemViewState extends State<NotificationItemView>
    with WidgetsBindingObserver {
  bool _isInitialized = false;
  late NotificationProvider _notificationProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadNotification();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _notificationProvider = context.watch<NotificationProvider>();
    if (!_isInitialized) {
      _loadNotification();
    }
    super.didChangeDependencies();
  }

  Future _loadNotification() async {
    await NotificationProvider.getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return StreamBuilder(
        stream: _notificationProvider.notificationsFromStream(),
        builder: (context, snapshot) {
          final notifications = snapshot.data ?? [];
          return notifications.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: context.responsive(kAs35x,
                            lg: kAs100x, md: kAs100x),
                        child: Icon(
                          Icons.notifications,
                          color: kWhiteColor,
                          size: context.responsive(kAs35x,
                              lg: kAs200x, md: kAs180x),
                        ),
                      ),
                      const SizedBox(
                        height: kAs20x,
                      ),
                      EasyText(
                        text: AppLocalizations.of(context)!.no_noti,
                        fontSize: kFs16x,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) => Dismissible(
                    background: const Material(
                        color: Colors.red,
                        child: Padding(
                            padding: EdgeInsets.all(kAs10x),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.delete, color: Colors.white),
                                SizedBox(
                                  width: kAs10x,
                                ),
                                Text('Delete ',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ))),
                    direction: DismissDirection.startToEnd,
                    key: Key(notifications[index].sentTime ?? ''),
                    onDismissed: (direction) {
                      _notificationProvider.deleteNotification(
                          notifications[index].sentTime ?? '');
                    },
                    child: NotificationCard(
                      notification: notifications[index],
                    ),
                  ),
                );
        });
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});

  final NotificationVM notification;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kWhiteColor, borderRadius: BorderRadius.circular(kBr10x)),
      padding: const EdgeInsets.all(kAs20x),
      margin:
          const EdgeInsets.only(left: kAs20x, right: kAs20x, bottom: kAs10x),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 15,
            child: Icon(
              Icons.notifications,
              color: kWhiteColor,
            ),
          ),
          const SizedBox(
            width: kAs20x,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                EasyText(
                  text: notification.title ?? '',
                  fontSize: kFs16x,
                  fontWeight: FontWeight.bold,
                  fontFamily: roboto,
                ),
                const SizedBox(
                  height: kAs5x,
                ),
                EasyText(
                  text: notification.body ?? '',
                  fontSize: kFs14x,
                ),
                const SizedBox(
                  height: kAs5x,
                ),
                EasyText(text: (notification.sentTime ?? '').formatDate())
              ],
            ),
          )
        ],
      ),
    );
  }
}
