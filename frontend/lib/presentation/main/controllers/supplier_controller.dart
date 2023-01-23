import 'package:flutter/material.dart';
import 'package:frontend/data/datasources/client_data.dart';
import 'package:frontend/data/models/client_model.dart';
import 'package:get/get.dart';

class SupplierController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController clientNameController = TextEditingController();
  TextEditingController ponNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ClientData _clientData = ClientData();
  List<ClientModel> _suppliers = [];
  bool archive = false;
  get suppliers {
    List<ClientModel> s = [];
    for (ClientModel supplier in _suppliers) {
      if (supplier.archive! == archive) {
        s.add(supplier);
      }
    }
    return s;
  }

  List<ClientModel> allSupplier() {
    return _suppliers;
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
    clientModel.clientName = clientNameController.text;
    clientModel.ponName = ponNameController.text;
    clientModel.phone = phoneController.text;

    return clientModel;
  }

  /// Section 4
  /// ===> Server Functions
  void getSuppliers() async {
    _suppliers = await _clientData.get(isClient: false);
    update();
  }

  void createSupplier() async {
    await _clientData.create(contollerToModel(ClientModel(isClient: false)));
    getSuppliers();
    Get.back();
  }

  void supplierUpdate(ClientModel clientModel) async {
    await _clientData.update(contollerToModel(clientModel));
    getSuppliers();
    Get.back();
  }

  void supplierArchive(ClientModel clientModel) async {
    clientModel.archive = !clientModel.archive!;
    await _clientData.update(clientModel);
    getSuppliers();
    Get.back();
  }
}
