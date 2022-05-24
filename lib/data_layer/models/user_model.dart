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

  static Map<String, dynamic> toJson(UserModel userModel) => {
    "id": userModel.id,
    "f_name": userModel.fName,
    "l_name": userModel.lName,
    "email": userModel.email,
  };

}
