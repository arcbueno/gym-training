import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_training/models/training_execution.dart';
import 'package:gym_training/repositories/session_repository.dart';

class TrainingExecutionRepository {
  late final FirebaseFirestore firestore;
  late final SessionRepository sessionRepository;
  late final String collectionName;

  TrainingExecutionRepository({
    required this.firestore,
    required this.sessionRepository,
  }) : collectionName = sessionRepository.getCurrentSession()?.userId ?? '';

  CollectionReference<Map<String, dynamic>> _getPath() {
    return firestore
        .collection('TrainingExecutionData')
        .doc(collectionName)
        .collection('TrainingExecutionData');
  }

  Future<TrainingExecution?> getLast(String id) async {
    var result = await _getPath()
        .orderBy('executionDate', descending: false)
        .where('trainingId', isEqualTo: id)
        .get();
    if (result.docs.isEmpty) return null;
    return TrainingExecution.fromFirebase(result.docs.last.data());
  }

  Future<void> newExecution(TrainingExecution execution) async {
    await _getPath().add(execution.toMap());
  }
}
