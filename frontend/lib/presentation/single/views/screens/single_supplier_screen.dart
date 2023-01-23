import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/single/controllers/single_client_controller.dart';
import 'package:frontend/presentation/single/views/widgets/client/single_client_buy_goods_table.dart';
import 'package:frontend/presentation/single/views/widgets/client/single_client_head_container.dart';
import 'package:frontend/presentation/single/views/widgets/client/single_client_shipment_table.dart';
import 'package:frontend/presentation/single/views/widgets/client/single_client_toolbar.dart';
import 'package:frontend/presentation/single/views/widgets/client/single_client_transfer_table.dart';
import 'package:get/get.dart';

class SingleSupplierScreen extends StatelessWidget {
  SingleSupplierScreen({Key? key}) : super(key: key);
  final SingleClientController controller = Get.put(SingleClientController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: GetBuilder<SingleClientController>(
          builder: (controller) {
            return Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  controller.singleClientModel == null,
              widgetBuilder: (context) => controller.loading
                  ? const Center(child: RefreshProgressIndicator())
                  : const NoData(),
              fallbackBuilder: (context) {
                return Container(
                  padding: EdgeInsets.all(AppSize.s1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header
                      SingleClientToolBar(),
                      SizedBox(height: AppSize.s5),
                      SingleClientHeadContainer(),
                      SizedBox(height: AppSize.s5),
                      // Tables
                      const TabBar(
                        tabs: [
                          Tab(
                            child: Text('التوريدات'),
                          ),
                          Tab(
                            child: Text('النقلات'),
                          ),
                          Tab(
                            child: Text('الدفعات'),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            SingleClientBuyGoodsTable(),
                            SingleClientShipmentTable(),
                            SingleClientTransferTable(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
