import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/data/models/user_model.dart';

class UserData {
  // GET
  Future<List<UserModel>> get() async {
    List<UserModel> data = []; // List Of Car
    var res = await DioConsumer.get(EndPoint.employee); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      for (var item in res.data) {
        data.add(UserModel.fromJson(item));
      }
    }
    return data;
  }

  // CREATE
  Future<void> create(UserModel userModel) async {
    await DioConsumer.post(EndPoint.employee, body: userModel.toJson());
  }

  // UPDATE
  Future<void> update(UserModel userModel) async {
    await DioConsumer.put(
      EndPoint.employee + userModel.id!,
      body: userModel.toJson(),
    );
  }
}
