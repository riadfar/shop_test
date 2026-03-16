import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.isEmailVerified,
    required this.createdAt,
    this.lastLoginAt,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        avatarUrl,
        isEmailVerified,
        createdAt,
        lastLoginAt,
      ];

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? avatarUrl,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}