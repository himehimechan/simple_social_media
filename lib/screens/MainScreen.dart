import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_social_media/config/config.dart';
import 'package:simple_social_media/modules/HomePage/HomePage.dart';

import 'package:simple_social_media/modules/MainScreen/MainScreen.dart';
import 'package:simple_social_media/modules/NewFeedPage/NewFeedPage.dart';
import 'package:simple_social_media/screens/HomePage.dart';
import 'package:simple_social_media/screens/NewFeedPage.dart';

import '../widgets/dialogs.dart';

class MainScreen extends StatelessWidget {
  final MainScreenController mainScreenC;

  const MainScreen(this.mainScreenC, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Obx(() => Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: mainScreenC.pageController,
            onPageChanged: mainScreenC.onPageChanged,
            children: <Widget>[
              HomePage(Get.put(HomePageController(HomePageService()))),
              NewFeedPage(Get.put(NewFeedPageController(NewFeedPageService()))),
              Container(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.blueGrey,
            elevation: 20,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            backgroundColor: Color(0xff58affa),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.person, size: 30,),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Text("New",style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey,
                ),),
                label: "",
                activeIcon: Text("New",style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,),),
              ),
              BottomNavigationBarItem(
                  icon: Icon(EvaIcons.heart, size: 30,),
                  label: ""
              ),
            ],
            onTap: (index) async {
              debugPrint("debugIndex: $index");
              mainScreenC.navigationTapped(index);
            },
            currentIndex: mainScreenC.indexButtonNavigation.value,
          ),
        )),
        onWillPop: () => Dialogs().showExitDialog(context));
  }
}