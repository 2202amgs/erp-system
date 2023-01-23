import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/data/models/transfer_model.dart';

class TransferData {
  // CREATE
  Future<void> create(TransferModel transferModel) async {
    await DioConsumer.post(EndPoint.transfers, body: transferModel.toJson());
  }

  // UPDATE
  Future<void> update(TransferModel transferModel) async {
    await DioConsumer.put(
      EndPoint.transfers + transferModel.id.toString(),
      body: transferModel.toJson(),
    );
  }

  // DELETE
  Future<void> delete(String id) async {
    await DioConsumer.delete(EndPoint.transfers + id);
  }

  // SHOW
}
