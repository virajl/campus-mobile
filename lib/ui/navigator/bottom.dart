import 'package:campus_mobile_experimental/app_constants.dart';
import 'package:campus_mobile_experimental/core/hooks/bottom_nav_query.dart';
import 'package:campus_mobile_experimental/core/wrappers/push_notifications.dart';
import 'package:campus_mobile_experimental/ui/home/home.dart';
import 'package:campus_mobile_experimental/ui/map/map.dart' as prefix0;
import 'package:campus_mobile_experimental/ui/navigator/top.dart';
import 'package:campus_mobile_experimental/ui/notifications/notifications_list_view.dart';
import 'package:campus_mobile_experimental/ui/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BottomTabBar extends StatefulHookWidget {
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  var currentTab = [
    Home(),
    prefix0.Maps(),
    NotificationsListView(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndexNotifier = useBottomNavigationBar();
    void handleBottomNavigationBarTap(int index) {
      setBottomNavigationBarIndex(index);
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(42),
          child: Provider.of<CustomAppBar>(context).appBar),
      body: PushNotificationWrapper(child: currentTab[currentIndexNotifier.value]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndexNotifier.value,
        onTap: (index) {
          handleBottomNavigationBarTap(index);
          switch (index) {
            case NavigatorConstants.HomeTab:
              Provider.of<CustomAppBar>(context, listen: false)
                  .changeTitle(null);
              break;
            case NavigatorConstants.MapTab:
              Provider.of<CustomAppBar>(context, listen: false)
                  .changeTitle("Maps");
              break;
            case NavigatorConstants.NotificationsTab:
              Provider.of<CustomAppBar>(context, listen: false).changeTitle(
                  "Notifications",
                  done: false,
                  notification: true);
              break;
            case NavigatorConstants.ProfileTab:
              Provider.of<CustomAppBar>(context, listen: false)
                  .changeTitle("Profile");
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            label: 'User Profile',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedFontSize: 0.0,
        selectedFontSize: 0.0,
        selectedItemColor: IconTheme.of(context).color,
        unselectedItemColor: Colors.grey.shade500,
      ),
    );
  }
}
