// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LectioAccount {
  int gymId;
  String username;
  String password;

  LectioAccount({
    required this.gymId,
    required this.username,
    required this.password,
  });

  LectioAccount copyWith({
    int? gymId,
    String? username,
    String? password,
  }) {
    return LectioAccount(
      gymId: gymId ?? this.gymId,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gymId': gymId,
      'username': username,
      'password': password,
    };
  }

  factory LectioAccount.fromMap(Map<String, dynamic> map) {
    return LectioAccount(
      gymId: map['gymId'] as int,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LectioAccount.fromJson(String source) =>
      LectioAccount.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LectioAccount(gymId: $gymId, username: $username, password: $password)';

  @override
  bool operator ==(covariant LectioAccount other) {
    if (identical(this, other)) return true;

    return other.gymId == gymId &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => gymId.hashCode ^ username.hashCode ^ password.hashCode;
}
