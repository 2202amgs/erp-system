import 'package:flutter/material.dart';
import 'package:frontend/data/models/bank_model.dart';
import 'package:frontend/data/models/car_model.dart';
import 'package:frontend/data/models/client_model.dart';
import 'package:frontend/data/models/expenses_model.dart';
import 'package:frontend/data/models/safe_model.dart';
import 'package:frontend/data/models/typegoods_model.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:frontend/presentation/main/controllers/bank_controller.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:frontend/presentation/main/controllers/client_controller.dart';
import 'package:frontend/presentation/main/controllers/expenses_controller.dart';
import 'package:frontend/presentation/main/controllers/safe_controller.dart';
import 'package:frontend/presentation/main/controllers/supplier_controller.dart';
import 'package:frontend/presentation/main/controllers/typegoods_contoller.dart';
import 'package:frontend/presentation/main/controllers/user_controller.dart';

List<DropdownMenuItem> carList(CarController carController, String? carId) {
  List<DropdownMenuItem> c = [];

  for (CarModel car in carController.allCars()) {
    if (car.archive == false || car.id == carId) {
      c.add(DropdownMenuItem(
        value: car.id,
        child: Text("${car.driverName}-${car.carNumber}"),
      ));
    }
  }
  return c;
}

List<DropdownMenuItem> locoList(CarController carController, String? carId) {
  List<DropdownMenuItem> c = [];

  for (CarModel car in carController.allSilon()) {
    if (car.archive == false || car.id == carId) {
      c.add(DropdownMenuItem(
        value: car.id,
        child: Text("${car.driverName}-${car.locoNumber}"),
      ));
    }
  }
  return c;
}

List<DropdownMenuItem> safeAndBankList(
    BankController bankController, SafeController safeController, String? id,
    {bool isbank = true}) {
  List<DropdownMenuItem> b = [];
  List<DropdownMenuItem> s = [];

  for (BankModel bank in bankController.allBanks()) {
    if (bank.archive == false || bank.id == id) {
      b.add(DropdownMenuItem(
        value: bank.id,
        child: Text(bank.name!),
      ));
    }
  }
  for (SafeModel safe in safeController.allSafes()) {
    if (safe.archive == false || safe.id == id) {
      s.add(DropdownMenuItem(
        value: safe.id,
        child: Text(safe.name!),
      ));
    }
  }
  return isbank ? [...b, ...s] : [...s, ...b];
}

// Client And Supplier List
List<DropdownMenuItem> clientAndSupplierList(ClientController clientController,
    SupplierController supplierController, String? id,
    {bool isClient = true}) {
  List<DropdownMenuItem> c = [];
  List<DropdownMenuItem> s = [];

  for (ClientModel client in clientController.allClients()) {
    if (client.archive == false || client.id == id) {
      c.add(DropdownMenuItem(
        value: client.id,
        child: Text(client.clientName!),
      ));
    }
  }
  for (ClientModel supplier in supplierController.allSupplier()) {
    if (supplier.archive == false || supplier.id == id) {
      s.add(DropdownMenuItem(
        value: supplier.id,
        child: Text(supplier.clientName!),
      ));
    }
  }

  return isClient ? [...c, ...s] : [...s, ...c];
}

// Type Goods List
List<DropdownMenuItem> typeGoodList(
    TypeGoodsController typeGoodsController, String? id) {
  List<DropdownMenuItem> l = [];

  for (TypeGoodsModel typeGoods in typeGoodsController.alltypeGoods()) {
    if (typeGoods.archive == false || typeGoods.id == id) {
      l.add(DropdownMenuItem(
        value: typeGoods.id,
        child: Text(typeGoods.name!),
      ));
    }
  }
  return l;
}

List<DropdownMenuItem> userList(UserController userController, String? userId) {
  List<DropdownMenuItem> c = [];

  for (UserModel user in userController.allUsers()) {
    if (user.archive == false || user.id == userId) {
      c.add(DropdownMenuItem(
        value: user.id,
        child: Text("${user.name}"),
      ));
    }
  }
  return c;
}

List<DropdownMenuItem> expensesList(
    ExpensesController expensesController, String? expensesId) {
  List<DropdownMenuItem> c = [];

  for (ExpensesModel expenses in expensesController.allExpenses()) {
    if (expenses.archive == false || expenses.id == expensesId) {
      c.add(DropdownMenuItem(
        value: expenses.id,
        child: Text("${expenses.name}"),
      ));
    }
  }
  return c;
}
