import 'package:flutter/cupertino.dart';
import 'package:frontend/data/datasources/car_data.dart';
import 'package:frontend/data/models/car_model.dart';
import 'package:get/get.dart';

class CarController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  TextEditingController locoNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController carRatio = TextEditingController();
  bool sailon = false;

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CarData _carData = CarData();
  List<CarModel> _cars = [];
  bool archive = false;
  bool clicked = false;
  bool? type;
  get cars {
    List<CarModel> c = [];
    for (CarModel car in _cars) {
      if (car.archive! == archive) {
        if (car.sailon == type || type == null) {
          c.add(car);
        }
      }
    }
    return c;
  }

  List<CarModel> allCars() {
    return _cars;
  }

  List<CarModel> allSilon() {
    return _cars.where((element) => element.sailon == true).toList();
  }

  /// Section 3
  /// ===> Config Functions
  void setSailon(bool value) {
    // Change Sailon state
    sailon = value;
    update();
  }

  void setType(bool? value) {
    type = value;
    update();
  }

  void clearControllers() {
    // clear controllers of data
    ownerNameController.clear();
    driverNameController.clear();
    phoneController.clear();
    locoNumberController.clear();
    carNumberController.clear();
    carRatio.clear();
    sailon = false;
  }

  void modelToController(CarModel carModel) {
    ownerNameController.text = carModel.ownerName!;
    driverNameController.text = carModel.driverName!;
    locoNumberController.text = carModel.locoNumber.toString();
    phoneController.text = carModel.phone.toString();
    carNumberController.text = carModel.locoNumber.toString();
    sailon = carModel.sailon!;
    if (carModel.sailon!) {
      carRatio.text = carModel.carRatio.toString();
    }
  }

  CarModel contollerToModel(CarModel carModel) {
    carModel.ownerName = ownerNameController.text;
    carModel.driverName = driverNameController.text;
    carModel.carNumber = int.parse(carNumberController.text);
    carModel.locoNumber = int.parse(locoNumberController.text);
    carModel.phone = phoneController.text;
    carModel.sailon = sailon;
    carModel.carRatio = sailon ? int.parse(carRatio.text) : null;
    return carModel;
  }

  /// Section 4
  /// ===> Server Functions
  void getCars() async {
    _cars = await _carData.get();
    update();
  }

  void createCar() async {
    await _carData.create(contollerToModel(CarModel()));
    getCars();
    Get.back();
  }

  void carUpdate(CarModel carModel) async {
    Get.back();
    await _carData.update(contollerToModel(carModel));
    getCars();
  }

  Future<void> carArchive(CarModel carModel) async {
    clicked = true;
    carModel.archive = !carModel.archive!;
    await _carData.update(carModel);
    getCars();
    clicked = false;
  }
}
