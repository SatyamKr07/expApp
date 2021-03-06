import '../../central/shared/colors.dart';
import '../../central/shared/textstyles.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/user_controller.dart';
import '../add_post/add_post.dart';
import '../home/home.dart';
import '../profile/profile.view.dart';
import '../search/search.dart';
import '../search_user/search_user.dart';
import '../story/story_list_page.dart';
import '../story/story_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MyBottomBar extends StatefulWidget {
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  // PersistentTabController pageController = PersistentTabController();

  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.home, size: 20),
            textStyle: const TextStyle(color: Color.fromRGBO(25, 25, 25, 1)),
            // textStyle: KCustomTextstyle.kMedium(context, 8),
            activeColorPrimary: CupertinoColors.systemPurple,
            inactiveColorPrimary: CupertinoColors.white),
        PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.search, size: 20),
            activeColorPrimary: CupertinoColors.systemPurple,
            inactiveColorPrimary: CupertinoColors.white),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.add, color: Colors.white),
          // title: ("Settings"),
          activeColorPrimary: CupertinoColors.systemPurple,
          inactiveColorPrimary: CupertinoColors.white,
        ),
        PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.comment, size: 20),
            activeColorPrimary: CupertinoColors.systemPurple,
            inactiveColorPrimary: CupertinoColors.white),
        PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.person, size: 20),
            activeColorPrimary: CupertinoColors.systemPurple,
            inactiveColorPrimary: CupertinoColors.white),
      ];
    }

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Container(
        color: Colors.black,
        // color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: GetBuilder<HomeController>(
            id: "BOTTOM_BAR",
            builder: (_) {
              return Scaffold(
                // floatingActionButton: FloatingActionButton(
                //   child: Icon(Icons.add),
                //   onPressed: () {
                //     Navigator.of(context).pushNamed("/add-post");
                //   },
                // ),
                backgroundColor: Colors.black,
                // backgroundColor: Theme.of(context).backgroundColor,
                body: Container(
                  color: Colors.black,
                  child: PersistentTabView(context,
                      controller: _.pageController,
                      screens: [
                        Home(),
                        Search(),
                        // SearchUser(),
                        AddPost(),
                        Scaffold(),
                        ProfileView(
                          userId: Get.find<UserController>().appUser.id,
                        ),
                      ],
                      items: _navBarsItems(),
                      popAllScreensOnTapOfSelectedTab: true,
                      popActionScreens: PopActionScreensType.all,
                      confineInSafeArea: true,
                      // backgroundColor: Color.fromRGBO(36, 37, 38, 1),
                      // backgroundColor: Color.fromRGBO(36, 37, 38, 1),
                      backgroundColor: Colors.grey[800]!,
                      // backgroundColor: KConstantColors.bgColorFaint,
                      handleAndroidBackButtonPress: true,
                      resizeToAvoidBottomInset: true,
                      itemAnimationProperties: ItemAnimationProperties(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease),
                      screenTransitionAnimation: ScreenTransitionAnimation(
                          animateTabTransition: true,
                          curve: Curves.ease,
                          duration: Duration(milliseconds: 200)),
                      navBarStyle: NavBarStyle.style17),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PortFolioView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).backgroundColor);
  }
}
