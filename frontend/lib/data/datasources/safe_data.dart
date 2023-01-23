import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/data/models/safe_model.dart';

class SafeData {
  // GET
  Future<List<SafeModel>> get() async {
    List<SafeModel> data = []; // List Of Safe
    var res = await DioConsumer.get(EndPoint.banks,
        queryParameters: {"isBank": false}); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      for (var item in res.data) {
        data.add(SafeModel.fromJson(item));
      }
    }
    return data;
  }

  // CREATE
  Future<void> create(SafeModel safeModel) async {
    await DioConsumer.post(EndPoint.banks, body: safeModel.toJson());
  }

  // UPDATE
  Future<void> update(SafeModel safeModel) async {
    await DioConsumer.put(
      EndPoint.banks + safeModel.id.toString(),
      body: safeModel.toJson(),
    );
  }

  // DELETE
  Future<void> delete(String id) async {
    await DioConsumer.delete(EndPoint.banks + id);
  }

  // SHOW
}
