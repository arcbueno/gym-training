import 'dart:convert';

class Session {
  late final String userName;
  late final String userEmail;
  late final String userId;

  Session(
      {required this.userName, required this.userEmail, required this.userId});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': userName});
    result.addAll({'userEmail': userEmail});
    result.addAll({'userId': userId});

    return result;
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      userName: map['userName'],
      userEmail: map['userEmail'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));
}
