import 'package:car_wash/app/shared/models/vehicle_model.dart';
import 'package:car_wash/app/shared/models/wash_model.dart';
import 'package:car_wash/app/shared/repositories/wash_repositore.dart';
import 'package:car_wash/app/shared/validators/wash_validator.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class NewOrderController {
  final valueTextController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final WashValidator washValidator = WashValidator();
  final WashRepositore washRepositore = WashRepositore();
  final WashModel _washModel = WashModel();
  NewOrderController() {
    valueTextController.afterChange = (String maskedValue, double rawValue){
      priceAdjusted = rawValue;
    };
  }
  set vehicleKind(VehicleKind vehicleKind) {
    _washModel.vehicleKind = vehicleKind;
    tryUpdatePriceValue();
  }

  set washKind(WashKind washKind) {
    _washModel.kind = washKind;
    tryUpdatePriceValue();
  }

  VehicleKind get vehicleKind {
    return _washModel.vehicleKind;
  }

  WashKind get washKind {
    return _washModel.kind;
  }

  save() {
    print('Save');
    // TODO: logs like thechamps
    // washRepositore.post(entity: washModel);
  }

  void tryUpdatePriceValue() {
    valueTextController.updateValue(_washModel.valueAjusted ?? 0.0);
  }

  set priceAdjusted(double value) {
    _washModel.valueAjusted = value;
  }
}
