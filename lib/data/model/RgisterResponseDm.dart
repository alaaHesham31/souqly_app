import 'package:e_commerce_app/domain/entities/RegisterResponseEntity.dart';

class RegisterResponseDm extends RegisterResponseEntity {
  RegisterResponseDm({super.message, super.user, super.token, super.statusMsg});

  RegisterResponseDm.fromJson(dynamic json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? UserDm.fromJson(json['user']) : null;
    token = json['token'];
  }
}

class UserDm extends UserEntity {
  UserDm({
    super.name,
    super.email,
    this.role,
  });

  UserDm.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  String? role;
}
