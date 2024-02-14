import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/repositories/session_repository.dart';

class TrainingRepository {
  late final FirebaseFirestore firestore;
  late final SessionRepository sessionRepository;
  late final String collectionName;

  TrainingRepository({required this.firestore, required this.sessionRepository})
      : collectionName = sessionRepository.getCurrentSession()?.userId ?? '';

  CollectionReference<Map<String, dynamic>> _getPath() {
    return firestore
        .collection('TrainingData')
        .doc(collectionName)
        .collection('TrainingData');
  }

  Future<List<TrainingDay>> getAll() async {
    List<TrainingDay> all = <TrainingDay>[];
    var result = await _getPath().where('isActive', isEqualTo: true).get();
    for (var element in result.docs) {
      all.add(TrainingDay.fromFirebase(element.data()));
    }

    return all;
  }

  Future<void> createNew(TrainingDay trainingDay) async {
    await _getPath().add(trainingDay.toMapNew());
  }

  Future<void> remove(TrainingDay trainingDay) async {
    var deactivated = trainingDay.copyWith(isActive: false);

    await _getPath().doc(trainingDay.id).update(deactivated.toMapNew());
  }
}
