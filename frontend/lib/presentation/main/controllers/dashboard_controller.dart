import 'package:flutter/material.dart';
import 'package:frontend/presentation/main/view/screens/bank_screen.dart';
import 'package:frontend/presentation/main/view/screens/cars_screen.dart';
import 'package:frontend/presentation/main/view/screens/client_screen.dart';
import 'package:frontend/presentation/main/view/screens/expenses_screen.dart';
import 'package:frontend/presentation/main/view/screens/home_screen.dart';
import 'package:frontend/presentation/main/view/screens/safe_screen.dart';
import 'package:frontend/presentation/main/view/screens/shipments_screen.dart';
import 'package:frontend/presentation/main/view/screens/supplier_screen.dart';
import 'package:frontend/presentation/main/view/screens/typegoods_screen.dart';
import 'package:frontend/presentation/main/view/screens/user_screen.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  GlobalKey<ScaffoldState> formKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  List<Widget> dashboardScreens = const [
    HomeScreen(),
    ShipmentsScreen(),
    CarsScreen(),
    ClientScreen(),
    SupplierScreen(),
    TypeGoodsScreen(),
    BankScreen(),
    SafeScreen(),
    UserScreen(),
    ExpensesScreen(),
  ];

  void changeScreen(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      update();
    }
  }
}
