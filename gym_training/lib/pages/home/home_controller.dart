import 'package:get/get.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/pages/home/state.dart';
import 'package:gym_training/repositories/session_repository.dart';
import 'package:gym_training/repositories/training_repository.dart';

class HomeController {
  late final SessionRepository sessionRepository;
  late final TrainingRepository trainingRepository;

  Rx<HomeState> state = Rx<HomeState>(HomeInit());

  HomeController({
    required this.sessionRepository,
    required this.trainingRepository,
  });

  Future<bool> logout() {
    return sessionRepository.logout();
  }

  Future<void> getAll() async {
    try {
      state.value = HomeLoading();
      var trainingList = await trainingRepository.getAll();
      state.value = HomeSuccess(trainingList: trainingList);
    } catch (e) {
      state.value = HomeError(errorMessage: e.toString());
    }
  }
}
