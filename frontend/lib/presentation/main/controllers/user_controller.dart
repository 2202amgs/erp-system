import 'package:flutter/cupertino.dart';
import 'package:frontend/data/datasources/user_data.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isAdmin = false;

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserData _userData = UserData();
  List<UserModel> _users = [];
  bool archive = false;

  get users {
    List<UserModel> u = [];
    for (UserModel user in _users) {
      if (user.archive! == archive) {
        u.add(user);
      }
    }
    return u;
  }

  List<UserModel> allUsers() {
    return _users;
  }

  /// Section 3
  /// ===> Config Functions
  void setIsAdmin(bool value) {
    // Change Sailon state
    isAdmin = value;
    update();
  }

  void clearControllers() {
    // clear controllers of data
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    isAdmin = false;
  }

  void modelToController(UserModel userModel) {
    clearControllers();
    nameController.text = userModel.name!;
    emailController.text = userModel.email!;
    isAdmin = userModel.isAdmin!;
  }

  UserModel contollerToModel(UserModel userModel) {
    userModel.name = nameController.text;
    userModel.email = emailController.text;
    userModel.password = passwordController.text;
    userModel.isAdmin = isAdmin;
    return userModel;
  }

  /// Section 4
  /// ===> Server Functions
  void getUsers() async {
    _users = await _userData.get();
    update();
  }

  void createUser() async {
    Get.back();
    await _userData.create(contollerToModel(UserModel()));
    getUsers();
  }

  void userUpdate(UserModel userModel) async {
    Get.back();
    await _userData.update(contollerToModel(userModel));
    getUsers();
  }

  void userArchive(UserModel userModel) async {
    Get.back();
    userModel.archive = !userModel.archive!;
    await _userData.update(userModel);
    getUsers();
  }
}
