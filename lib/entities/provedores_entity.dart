
class ProvedorEntity {

  String id;
  String name;
  String lastName;
  String? providerMail;
  String? providerState;

  ProvedorEntity({
    required this.id,
    required this.name,
    required this.lastName,
    this.providerMail,
    this.providerState,
  });

}