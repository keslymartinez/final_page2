


class SessionEntity {

  bool isLogged;
  String? id;
  String? username;
  String? email;
  String? imageUrl;

  SessionEntity({
    required this.isLogged,
    this.id,
    this.username,
    this.email,
    this.imageUrl,
  });


}