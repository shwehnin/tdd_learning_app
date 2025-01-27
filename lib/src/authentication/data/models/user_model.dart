import 'dart:convert';

import 'package:tdd_learning_app/core/utils/typedef.dart';
import 'package:tdd_learning_app/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.name, required super.avatar, required super.createdAt});

  factory UserModel.fromJson(String source) => UserModel.fromMap(jsonDecode(source) as DataMap);

  const UserModel.empty() : this(
    id: '1',
    name: '_empty.name',
    avatar: '_empty.avatar',
    createdAt: '_empty.createdAt'
  );

  UserModel.fromMap(DataMap map) : this(
    id: map['id'] as String,
    avatar: map['avatar'] as String,
    name: map['name'] as String,
    createdAt: map['createdAt'] as String,
  );

  DataMap toMap() => {
    'id': id,
    'name': name,
    'avatar': avatar,
    'createdAt': createdAt,
  };

  String toJson() => jsonEncode(toMap());

  UserModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? createdAt,
}) {
    return UserModel(id: id ?? this.id, name: name ?? this.name, avatar: avatar ?? this.avatar, createdAt: createdAt ?? this.createdAt);
  }
}