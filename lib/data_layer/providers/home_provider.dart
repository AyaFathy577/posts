import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posts/constants/variables.dart';
import 'package:posts/data_layer/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  String _description = "";
  XFile? _pickedFile;
  List<PostModel> _posts = [];

  String get description => _description;

  XFile? get pickedFile => _pickedFile;

  List<PostModel> get posts => _posts;

  init() {
    _description = "";
    _pickedFile = null;
    notifyListeners();
  }

  updateText(String val) {
    _description = val;
    notifyListeners();
  }

  updatePicked(XFile? val) {
    _pickedFile = val;
    notifyListeners();
  }

  getPosts() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var loadedPosts = sharedPref.getString(Variables.posts);
    if (loadedPosts != null) {
      _posts = PostModel.decode(loadedPosts);
    } else {
      _posts = [];
    }
    notifyListeners();
  }

  addPost(PostModel postModel) async {
    _posts = [..._posts, postModel];
    notifyListeners();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(Variables.posts, PostModel.encode(_posts));
  }

  removePost(int index) async {
    _posts.removeAt(index);
    _posts = [..._posts];
    notifyListeners();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(Variables.posts, PostModel.encode(_posts));
  }
}
