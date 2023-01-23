import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/shared/dropdown_lists.dart';
import 'package:frontend/app/core/utils/custom_form_field.dart';
import 'package:frontend/data/models/car_model.dart';
import 'package:frontend/data/models/client_model.dart';
import 'package:frontend/presentation/main/controllers/bank_controller.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:frontend/presentation/main/controllers/client_controller.dart';
import 'package:frontend/presentation/main/controllers/safe_controller.dart';
import 'package:frontend/presentation/main/controllers/shipments_controller.dart';
import 'package:frontend/presentation/main/controllers/supplier_controller.dart';
import 'package:frontend/presentation/main/controllers/typegoods_contoller.dart';
import 'package:get/get.dart';

class ShipmentForm extends GetView<ShipmentsController> {
  ShipmentForm({super.key});
  final CarController _carController = Get.find();
  final ClientController _clientController = Get.find();
  final SupplierController _supplierController = Get.find();
  final BankController _bankController = Get.find();
  final SafeController _safeController = Get.find();
  final TypeGoodsController _typeGoodsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipmentsController>(
      builder: (contoller) {
        return Form(
          key: controller.formKey,
          child: Container(
            width: 400,
            padding: EdgeInsets.all(AppSize.s2),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Wrap(
              runSpacing: AppSize.s2,
              spacing: 10,
              alignment: WrapAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    items: carList(_carController, controller.carId),
                    hint: const Text("السيارة"),
                    onChanged: (value) {
                      controller.carId = value;
                      if (contoller.carId == null) {
                        controller.clearCarControllers();
                        controller.update();
                      } else {
                        for (CarModel car in _carController.cars) {
                          if (value == car.id) {
                            controller.setFilled(car.sailon!);
                            controller.carRatioController.text =
                                car.carRatio.toString();
                          }
                        }
                      }
                    },
                    value: controller.carId,
                    validator: (value) {
                      if (!contoller.isCommerce && value == null) {
                        return "بيانات السيارة ضرورية فى هذه الحالة";
                      }
                      return null;
                    },
                  ),
                ),
                if (controller.carId != null)
                  ..._listOfCars(context)
                      .map((e) => SizedBox(
                            width: 180,
                            child: e,
                          ))
                      .toList(),
                DropdownButtonFormField(
                  items: clientAndSupplierList(_clientController,
                      _supplierController, controller.clientId),
                  hint: const Text("العميل"),
                  onChanged: (value) {
                    controller.clientId = value;
                    for (ClientModel calient in _clientController.clients) {
                      if (value == calient.id) {
                        controller.setPonName(calient.ponName!);
                      }
                    }
                  },
                  value: controller.clientId,
                  validator: (value) {
                    if (value == null) {
                      return 'أختر العميل';
                    }
                    return null;
                  },
                ),
                if (controller.clientId != null)
                  ..._listOfClients(context)
                      .map((e) => SizedBox(
                            width: 180,
                            child: e,
                          ))
                      .toList(),
                SwitchListTile(
                  title: Text(
                    'التجارة',
                    style: Theme.of(context).textTheme.headline6!,
                  ),
                  value: controller.isCommerce,
                  onChanged: (value) {
                    controller.setCommerce(value);
                  },
                ),
                if (controller.isCommerce)
                  ..._listOfCommerce(context)
                      .map((e) => SizedBox(
                            width: 180,
                            child: e,
                          ))
                      .toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _listOfCars(BuildContext context) {
    return [
      CustomFormField(
        controller: controller.custodyController,
        label: 'العهدة',
        formatType: FormatTypes.float,
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'أدخل العهدة';
          }
          return null;
        },
        onChanged: (p0) => controller.update(),
      ),
      if (controller.custodyController.text.isNotEmpty &&
          num.parse(controller.custodyController.text) > 0)
        DropdownButtonFormField(
          items: safeAndBankList(
              _bankController, _safeController, controller.bankId,
              isbank: false),
          hint: const Text("الخزنة"),
          onChanged: (value) {
            controller.bankId = value;
          },
          value: controller.bankId,
          validator: (value) {
            if (value == null) {
              return 'أختر بنك أو خزينة';
            }
            return null;
          },
        ),
      if (!controller.isFilled)
        CustomFormField(
          controller: controller.tipController,
          label: 'الإكرامية',
          formatType: FormatTypes.float,
          validator: (value) {
            if (value.toString().isEmpty) {
              return 'أدخل الإكرامية';
            }
            return null;
          },
        ),
      if (!controller.isFilled)
        CustomFormField(
          controller: controller.t3tController,
          label: 'التعتيق',
          formatType: FormatTypes.float,
          validator: (value) {
            if (value.toString().isEmpty) {
              return 'أدخل التعتيق';
            }
            return null;
          },
        ),
      CustomFormField(
        controller: controller.differenceNolonController,
        label: 'باقى النولون',
        formatType: FormatTypes.float,
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'أدخل باقى النولن';
          }
          return null;
        },
      ),
      if (controller.isFilled)
        CustomFormField(
          controller: controller.carRatioController,
          label: 'نسبة الرأس',
          validator: (value) {
            if (value.toString().isEmpty) {
              return 'أدخل نسبة الرأس';
            }
            if (num.parse(value) > 100) {
              return "أدخل النسبة بشكل صحيح";
            }
            return null;
          },
        ),
      CustomFormField(
        controller: controller.nolonController,
        label: 'النولون',
        formatType: FormatTypes.float,
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'أدخل النولون';
          }
          return null;
        },
      ),
    ];
  }

  List<Widget> _listOfClients(BuildContext context) {
    return [
      CustomFormField(
        controller: controller.factoryController,
        label: 'المصنع',
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'ادخل المصنع';
          }
          return null;
        },
      ),
      CustomFormField(
        controller: controller.permissionNumberController,
        label: 'رقم إذن التحميل',
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'ادخل رقم إذن التحميل';
          }
          return null;
        },
        formatType: FormatTypes.int,
      ),
      CustomFormField(
        controller: controller.sideController,
        label: 'الجهة',
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'أدخل الجهة';
          }
          return null;
        },
      ),
      CustomFormField(
        controller: controller.poneNameController,
        label: 'اسم البون',
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'أدخل اسم البون';
          }
          return null;
        },
      ),
      CustomFormField(
        controller: controller.quantityController,
        label: 'الكمية',
        formatType: FormatTypes.float,
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'أدخل الكمية';
          }
          return null;
        },
      ),
      CustomFormField(
        controller: controller.profitValueController,
        label: 'قيمة الربح',
        formatType: FormatTypes.float,
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'أدخل قيمة الربح';
          }
          return null;
        },
      ),
      CustomFormField(
        controller: controller.notesController,
        label: 'الملاحظات',
      ),
    ];
  }

  List<Widget> _listOfCommerce(context) {
    return [
      DropdownButtonFormField(
        items: typeGoodList(_typeGoodsController, controller.typeGoodsId),
        hint: const Text("الصنف"),
        onChanged: (value) {
          controller.typeGoodsId = value;
        },
        value: controller.typeGoodsId,
        validator: (value) {
          if (value == null) {
            return 'أختر بنك أو خزينة';
          }
          return null;
        },
      ),
      CustomFormField(
        controller: controller.priceController,
        label: 'سعر البضاعة',
        formatType: FormatTypes.float,
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'أدخل سعر البضاعة';
          }
          return null;
        },
      ),
    ];
  }
}
