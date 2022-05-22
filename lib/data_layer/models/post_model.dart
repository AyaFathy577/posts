import 'package:posts/data_layer/models/user_model.dart';

class PostModel {
  late int id;
  late UserModel userModel;
  late String description;
  late String link;
  late bool isBookmark;
  late bool isLike;
  late int numOfLikes;

  PostModel({
    required this.id,
    required this.userModel,
    required this.description,
    required this.link,
    required this.isBookmark,
    required this.isLike,
    required this.numOfLikes,
  });

  PostModel.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    userModel = UserModel.fromJson(data["user"]);
    description = data["description"];
    link = data["link"];
    isBookmark = data["is_bookmark"];
    isLike = data["is_like"];
    numOfLikes = data["num_of_likes"];
  }

  Map<String, dynamic> toJson(PostModel postModel) => {
        "id": postModel.id,
        "user": userModelToJson(postModel.userModel),
        "description": postModel.description,
        "link": postModel.link,
        "is_bookmark": postModel.isBookmark,
        "is_like": postModel.isLike,
        "num_of_likes": postModel.numOfLikes,
      };

  Map<String, dynamic> userModelToJson(UserModel userModel) => {
        "id": userModel.id,
        "f_name": userModel.fName,
        "l_name": userModel.lName,
        "email": userModel.email,
      };
}
