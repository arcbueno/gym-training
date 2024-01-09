import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_training/pages/home/home_controller.dart';
import 'package:gym_training/pages/home/state.dart';
import 'package:gym_training/pages/login/login_page.dart';
import 'package:gym_training/pages/new_training/new_training_page.dart';
import 'package:gym_training/widgets/home_training_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    _controller = Get.find<HomeController>();
    _controller.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My training list',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _controller.getAll();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {
              var success = await _controller.logout();
              if (success) {
                Get.offAll(() => const LoginPage());
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Obx(
          () => Stack(
            children: [
              Column(
                children: [
                  if (_controller.state.value is HomeSuccess)
                    HomeTrainingList(
                      trainingList:
                          (_controller.state.value as HomeSuccess).trainingList,
                      onNewTraining: _onNewTraining,
                      onRemove: (value) => _controller.onRemove(value),
                      onUpdate: (_) {},
                    ),
                  if (_controller.state.value is HomeError)
                    Text((_controller.state.value as HomeError).errorMessage),
                ],
              ),
              if (_controller.state.value is HomeLoading ||
                  _controller.state.value is HomeInit)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _onNewTraining() async {
    await Get.to(() => const NewTrainingPage());
    await _controller.getAll();
  }
}
