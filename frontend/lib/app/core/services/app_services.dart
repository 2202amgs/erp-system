import 'package:frontend/presentation/auth/controllers/auth_controller.dart';
import 'package:frontend/presentation/main/controllers/bank_controller.dart';
import 'package:frontend/presentation/main/controllers/buygoods_controller.dart';

import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/services/initial_services.dart';
import 'package:frontend/app/core/shared/local_helper.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:frontend/presentation/main/controllers/client_controller.dart';
import 'package:frontend/presentation/main/controllers/dashboard_controller.dart';
import 'package:frontend/presentation/main/controllers/empmoney_controller.dart';
import 'package:frontend/presentation/main/controllers/expenses_controller.dart';
import 'package:frontend/presentation/main/controllers/polices_controller.dart';
import 'package:frontend/presentation/main/controllers/safe_controller.dart';
import 'package:frontend/presentation/main/controllers/shipments_controller.dart';
import 'package:frontend/presentation/main/controllers/supplier_controller.dart';
import 'package:frontend/presentation/main/controllers/transfer_controller.dart';
import 'package:frontend/presentation/main/controllers/typegoods_contoller.dart';
import 'package:frontend/presentation/main/controllers/user_controller.dart';
import 'package:get/get.dart';

void servicesInject() async {
  LocalHelper.init();
  DioConsumer.init();
}

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(AuthController());
    Get.put(UserController());
    Get.put(ShipmentsController());
    Get.put(PolicyController());
    Get.put(CarController());
    Get.put(ClientController());
    Get.put(SupplierController());
    Get.put(BankController());
    Get.put(SafeController());
    Get.put(TransferController());
    Get.put(EmpMoneyController());
    Get.put(TypeGoodsController());
    Get.put(BuyGoodsController());
    Get.put(ExpensesController());
    Get.put(InitialSrvice()).init();
    Get.put(DashboardController(), permanent: true);
  }
}
