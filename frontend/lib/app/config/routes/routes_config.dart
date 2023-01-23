import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/middleware/auth_middleware.dart';
import 'package:frontend/presentation/main/view/screens/dashboard_screen.dart';
import 'package:frontend/presentation/auth/views/screens/login_screen.dart';
import 'package:frontend/presentation/single/views/screens/single_bank_screen.dart';
import 'package:frontend/presentation/single/views/screens/single_car_screen.dart';
import 'package:frontend/presentation/single/views/screens/single_client_screen.dart';
import 'package:frontend/presentation/single/views/screens/single_emp_screen.dart';
import 'package:frontend/presentation/single/views/screens/single_expenses_screen.dart';
import 'package:frontend/presentation/single/views/screens/single_supplier_screen.dart';
import 'package:frontend/presentation/single/views/screens/single_typegodds_screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> pages = [
  GetPage(
    name: AppRoutes.login,
    page: () => LoginScreen(),
    middlewares: [AuthMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.dashboard,
    page: () => const DashboardScreen(),
  ),
  GetPage(
    name: AppRoutes.car,
    page: () => SingleCarScreen(),
  ),
  GetPage(
    name: AppRoutes.client,
    page: () => SingleClientScreen(),
  ),
  GetPage(
    name: AppRoutes.supplier,
    page: () => SingleSupplierScreen(),
  ),
  GetPage(
    name: AppRoutes.user,
    page: () => SingleEmpScreen(),
  ),
  GetPage(
    name: AppRoutes.typeGoods,
    page: () => SingleTypeGoodsScreen(),
  ),
  GetPage(
    name: AppRoutes.expenses,
    page: () => SingleExpensesScreen(),
  ),
  GetPage(
    name: AppRoutes.bank,
    page: () => SingleBankScreen(),
  ),
];
