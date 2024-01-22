import 'package:get/get.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/pages/home/state.dart';
import 'package:gym_training/repositories/session_repository.dart';
import 'package:gym_training/repositories/training_execution_repository.dart';
import 'package:gym_training/repositories/training_repository.dart';

class HomeController {
  late final SessionRepository sessionRepository;
  late final TrainingRepository trainingRepository;
  late final TrainingExecutionRepository trainingExecutionRepository;

  Rx<HomeState> state = Rx<HomeState>(HomeInit());

  HomeController({
    required this.sessionRepository,
    required this.trainingRepository,
    required this.trainingExecutionRepository,
  });

  Future<bool> logout() {
    return sessionRepository.logout();
  }

  changeView() {
    if (state.value is HomeListSuccess) {
      getAllExecutions();
      return;
    }
    getAll();
  }

  refresh() {
    if (state.value is HomeCalendarSuccess) {
      getAllExecutions();
      return;
    }
    getAll();
  }

  Future<void> getAll() async {
    try {
      state.value = HomeLoading();
      var trainingList = await trainingRepository.getAll();
      state.value = HomeListSuccess(trainingList: trainingList);
    } catch (e) {
      state.value = HomeError(errorMessage: e.toString());
    }
  }

  Future<void> getAllExecutions() async {
    try {
      state.value = HomeLoading();
      var executionList = await trainingExecutionRepository.getAllExecutions();
      var trainingList = await trainingRepository.getAll();
      state.value = HomeCalendarSuccess(
          trainingList: trainingList, executionList: executionList);
    } catch (e) {
      state.value = HomeError(errorMessage: e.toString());
    }
  }

  Future<void> onRemove(TrainingDay training) async {
    try {
      state.value = HomeLoading();
      await trainingRepository.remove(training);
      await getAll();
    } catch (e) {
      state.value = HomeError(errorMessage: e.toString());
    }
  }
}
