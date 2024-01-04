import 'package:gym_training/repositories/session_repository.dart';
import 'package:gym_training/repositories/training_repository.dart';

class HomeController {
  late final SessionRepository sessionRepository;
  late final TrainingRepository trainingRepository;

  HomeController({
    required this.sessionRepository,
    required this.trainingRepository,
  });

  Future<bool> logout() {
    return sessionRepository.logout();
  }

  Future<void> getAll() async {
    trainingRepository.getAll();
  }
}
