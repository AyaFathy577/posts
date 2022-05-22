class UserModel {
  late int id;
  late String fName;
  late String lName;
  late String email;

  UserModel(
      {required this.id,
      required this.fName,
      required this.lName,
      required this.email});

  UserModel.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    fName = data["f_name"];
    lName = data["l_name"];
    email = data["email"];
  }
}
