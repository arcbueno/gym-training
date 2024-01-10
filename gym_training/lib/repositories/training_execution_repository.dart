import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_training/repositories/session_repository.dart';

class TrainingExecutionRepository {
  late final FirebaseFirestore firestore;
  late final SessionRepository sessionRepository;
  late final String collectionName;

  TrainingExecutionRepository({
    required this.firestore,
    required this.sessionRepository,
  }) : collectionName =
            '${sessionRepository.getCurrentSession()?.userEmail ?? ''}-TrainingExecutionData';
}
