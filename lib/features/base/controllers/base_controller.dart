import 'package:flutter/material.dart';
import 'package:get/get.dart';






class BaseController extends GetxController {
  final RxInt currentIndex = 0.obs;
  int lastTapTime = 0;

  final homeNavKey     = GlobalKey<NavigatorState>();
  final projectsNavKey = GlobalKey<NavigatorState>();
  final lattiAiNavKey  = GlobalKey<NavigatorState>();
  final accountNavKey  = GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() => scaffoldKey.currentState?.openDrawer();

  GlobalKey<NavigatorState> keyForIndex(int index) {
    switch (index) {
      case 1:  return projectsNavKey;
      case 2:  return lattiAiNavKey;
      case 3:  return accountNavKey;
      default: return homeNavKey;
    }
  }
  void onTabSelected(int index) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (index == currentIndex.value && currentTime - lastTapTime < 500) {
      keyForIndex(index).currentState?.popUntil((route) => route.isFirst);
    } else {
      currentIndex.value = index;
    }
    lastTapTime = currentTime;
  }

}