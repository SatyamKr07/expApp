import 'package:commentor/src/central/shared/colors.dart';
import 'package:commentor/src/central/shared/textstyles.dart';
import 'package:commentor/src/pages/home/home.dart';
import 'package:commentor/src/pages/profile/profile.view.dart';
import 'package:commentor/src/pages/story/story_list_page.dart';
import 'package:commentor/src/pages/story/story_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MyBottomBar extends StatefulWidget {
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  PersistentTabController pageController = PersistentTabController();

  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.home, size: 20),
            textStyle: const TextStyle(color: Color.fromRGBO(25, 25, 25, 1)),
            // textStyle: KCustomTextstyle.kMedium(context, 8),
            activeColorPrimary: CupertinoColors.systemPurple,
            inactiveColorPrimary: CupertinoColors.systemGrey),
        PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.search, size: 20),
            activeColorPrimary: CupertinoColors.systemPurple,
            inactiveColorPrimary: CupertinoColors.systemGrey),
        PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.comment, size: 20),
            activeColorPrimary: CupertinoColors.systemPurple,
            inactiveColorPrimary: CupertinoColors.systemGrey),
        PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.person, size: 20),
            activeColorPrimary: CupertinoColors.systemPurple,
            inactiveColorPrimary: CupertinoColors.systemGrey),
      ];
    }

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   child: Icon(Icons.add),
            //   onPressed: () {
            //     Navigator.of(context).pushNamed("/add-post");
            //   },
            // ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: Container(
              child: PersistentTabView(context,
                  controller: pageController,
                  screens: [Home(), StoryListPage(), Scaffold(), ProfileView()],
                  items: _navBarsItems(),
                  popAllScreensOnTapOfSelectedTab: true,
                  popActionScreens: PopActionScreensType.all,
                  confineInSafeArea: true,
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
                  navBarStyle: NavBarStyle.style6),
            ),
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
