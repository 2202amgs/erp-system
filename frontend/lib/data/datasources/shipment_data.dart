import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/models/shipment_model.dart';

class ShipmentData {
  // GET
  Future<List<ShipmentModel>> get(DateTime dateTime) async {
    List<ShipmentModel> data = []; // List Of Shipment
    var res = await DioConsumer.get(
      EndPoint.shipment,
      queryParameters: {
        "date": printDate(dateTime),
      },
    ); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      for (var item in res.data) {
        data.add(ShipmentModel.fromJson(item));
      }
    }
    return data;
  }

  // CREATE
  Future<void> create(ShipmentModel shipmentModel) async {
    await DioConsumer.post(
      EndPoint.shipment,
      body: shipmentModel.toJson(),
    );
  }

  // UPDATE
  Future<void> update(ShipmentModel shipmentModel) async {
    await DioConsumer.put(
      EndPoint.shipment + shipmentModel.id.toString(),
      body: shipmentModel.toJson(),
    );
  }

  // DELETE
  Future<void> delete(String id) async {
    await DioConsumer.delete(EndPoint.shipment + id);
  }
}
