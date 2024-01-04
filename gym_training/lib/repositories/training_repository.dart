import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/repositories/session_repository.dart';

class TrainingRepository {
  late final FirebaseFirestore firestore;
  late final SessionRepository sessionRepository;
  late final String collectionName;

  TrainingRepository({required this.firestore, required this.sessionRepository})
      : collectionName =
            '${sessionRepository.getCurrentSession()?.userEmail ?? ''}-TrainingData';

  Future<List<TrainingDay>> getAll() async {
    List<TrainingDay> all = <TrainingDay>[];
    var result = await firestore.collection(collectionName).get();
    for (var element in result.docs) {
      all.add(TrainingDay.fromFirebase(element));
    }
    return all;
  }
}
