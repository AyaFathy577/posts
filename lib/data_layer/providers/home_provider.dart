import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posts/data_layer/models/post_model.dart';

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

  getPosts() {
    _posts = [];
    notifyListeners();
  }
}
