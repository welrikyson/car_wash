import 'package:car_wash/app/shared/models/wash_model.dart';
import 'package:car_wash/app/shared/repositories/wash_repositore.dart';
import 'package:car_wash/app/shared/validators/wash_validator.dart';

class NewOrderController {
  final WashValidator washValidator = WashValidator();
  final WashRepositore washRepositore = WashRepositore();
  final WashModel washModel = WashModel();

  save(){
    print('Save');
    // washValidator.validate(washModel);
    // washRepositore.post(entity: washModel);
  }
}