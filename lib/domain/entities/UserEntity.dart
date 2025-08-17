class UserResponseEntity {
  UserResponseEntity({this.message, this.user, this.token, this.statusMsg});

  UserResponseEntity.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserEntity.fromJson(json['user']) : null;
    token = json['token'];
    statusMsg = json['statusMsg'];
  }

  String? message;
  UserEntity? user;
  String? token;
  String? statusMsg;
}

class UserEntity {
  UserEntity({
    this.name,
    this.email,
    this.role,
  });

  UserEntity.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  String? name;
  String? email;
  String? role;
}
