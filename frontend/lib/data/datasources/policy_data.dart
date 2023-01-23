import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/models/policy_model.dart';

class PolicyData {
  // GET
  Future<List<PolicyModel>> get(DateTime dateTime) async {
    List<PolicyModel> data = []; // List Of polices
    var res = await DioConsumer.get(
      EndPoint.polices,
      queryParameters: {
        "date": printDate(dateTime),
      },
    ); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      for (var item in res.data) {
        data.add(PolicyModel.fromJson(item));
      }
    }
    return data;
  }

  // CREATE
  Future<void> create(PolicyModel policyModel) async {
    await DioConsumer.post(
      EndPoint.polices,
      body: policyModel.toJson(),
    );
  }

  // UPDATE
  Future<void> update(PolicyModel policyModel) async {
    await DioConsumer.put(
      EndPoint.polices + policyModel.id.toString(),
      body: policyModel.toJson(),
    );
  }

  // DELETE
  Future<void> delete(String id) async {
    await DioConsumer.delete(EndPoint.polices + id);
  }
}
