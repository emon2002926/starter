import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/controllers/base_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Get.find<BaseController>().openDrawer();
          },
        ),
      ),
      body: const Center(
        child: Text("this is home view"),
      ),
    );
  }
}
