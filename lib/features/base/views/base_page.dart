import 'package:starter/features/ai_chat/views/chat_screen.dart';
import 'package:starter/features/home/views/home_view.dart';
import 'package:starter/features/projects/views/project_home.dart';

import '../../../core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/app_drawer.dart';
import '../../../core/widgets/bottom_navigation/bottom_navigation.dart';
import '../controllers/base_controller.dart';
import 'package:get/get.dart';


class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BaseController>();

    final screens = [
      const HomeView(),
      const ProjectHome(),
      const ChatScreen(),
      const ProjectHome(),
    ];

    return Obx(() => Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColors.screenBgBottom,
      extendBody: true,
      drawer: const AppDrawer(),

      body: WillPopScope(
        onWillPop: () {
          final key = controller.keyForIndex(controller.currentIndex.value);
          if (key.currentState?.canPop() == true) {
            key.currentState?.pop();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: IndexedStack(
          index: controller.currentIndex.value,
          children: [
            Navigator(
              key: controller.homeNavKey,
              onGenerateInitialRoutes: (_, _) =>
              [MaterialPageRoute(builder: (_) => screens[0])],
            ),
            Navigator(
              key: controller.projectsNavKey,
              onGenerateInitialRoutes: (_, _) =>
              [MaterialPageRoute(builder: (_) => screens[1])],
            ),
            Navigator(
              key: controller.lattiAiNavKey,
              onGenerateInitialRoutes: (_, _) =>
              [MaterialPageRoute(builder: (_) => screens[2])],
            ),
            Navigator(
              key: controller.accountNavKey,
              onGenerateInitialRoutes: (_, _) =>
              [MaterialPageRoute(builder: (_) => screens[3])],
            ),

          ],
        ),
      ),

      bottomNavigationBar: Obx(() => AppNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTabSelected: controller.onTabSelected,
      )),
    ));
  }
}