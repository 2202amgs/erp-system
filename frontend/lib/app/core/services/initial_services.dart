import 'package:frontend/presentation/auth/controllers/auth_controller.dart';
import 'package:frontend/app/core/constants/app_keys.dart';
import 'package:frontend/app/core/shared/local_helper.dart';
import 'package:frontend/presentation/main/controllers/bank_controller.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:frontend/presentation/main/controllers/client_controller.dart';
import 'package:frontend/presentation/main/controllers/expenses_controller.dart';
import 'package:frontend/presentation/main/controllers/safe_controller.dart';
import 'package:frontend/presentation/main/controllers/supplier_controller.dart';
import 'package:frontend/presentation/main/controllers/typegoods_contoller.dart';
import 'package:frontend/presentation/main/controllers/user_controller.dart';
import 'package:get/get.dart';

class InitialSrvice extends GetxService {
  final AuthController _authController = Get.find();
  final BankController _bankController = Get.find();
  final SafeController _safeController = Get.find();
  final ClientController _clientController = Get.find();
  final CarController _carController = Get.find();
  final TypeGoodsController _typeGoodsController = Get.find();
  final SupplierController _supplierController = Get.find();
  final UserController _userController = Get.find();
  final ExpensesController _expensesController = Get.find();

  void init() async {
    if (LocalHelper.get(AppKeys.token) != null) {
      await _authController.getUserData();
      _bankController.getBanks();
      _userController.getUsers();
      _safeController.getSafes();
      _clientController.getClients();
      _carController.getCars();
      _typeGoodsController.gettypeGoods();
      _supplierController.getSuppliers();
      _expensesController.getExpenses();
    }
  }
}
