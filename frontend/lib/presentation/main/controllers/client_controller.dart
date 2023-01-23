import 'package:flutter/cupertino.dart';
import 'package:frontend/data/datasources/client_data.dart';
import 'package:frontend/data/models/client_model.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController clientNameController = TextEditingController();
  TextEditingController ponNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ClientData _clientData = ClientData();
  List<ClientModel> _clients = [];
  bool archive = false;
  get clients {
    List<ClientModel> c = [];
    for (ClientModel car in _clients) {
      if (car.archive! == archive) {
        c.add(car);
      }
    }
    return c;
  }

  List<ClientModel> allClients() {
    return _clients;
  }

  /// Section 3
  /// ===> Config Functions

  void clearControllers() {
    // clear controllers of data
    clientNameController.clear();
    ponNameController.clear();
    phoneController.clear();
  }

  void modelToController(ClientModel clientModel) {
    clientNameController.text = clientModel.clientName!;
    ponNameController.text = clientModel.ponName!;
    phoneController.text = clientModel.phone!;
  }

  ClientModel contollerToModel(ClientModel clientModel) {
    clientModel.userId = clientModel.userId ?? '62f56965b0fc5f78ca4e4451';
    clientModel.clientName = clientNameController.text;
    clientModel.ponName = ponNameController.text;
    clientModel.phone = phoneController.text;

    return clientModel;
  }

  /// Section 4
  /// ===> Server Functions
  void getClients() async {
    _clients = await _clientData.get();
    update();
  }

  void createClient() async {
    await _clientData.create(contollerToModel(ClientModel()));
    getClients();
    Get.back();
  }

  void clientUpdate(ClientModel clientModel) async {
    await _clientData.update(contollerToModel(clientModel));
    getClients();
    Get.back();
  }

  void clientArchive(ClientModel clientModel) async {
    clientModel.archive = !clientModel.archive!;
    await _clientData.update(clientModel);
    getClients();
    Get.back();
  }
}
