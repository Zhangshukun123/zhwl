import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/entity/infrared_entity.dart';

import '../utils/sp_utils.dart';

class InfraredController extends GetxController {
  var infrared = InfraredEntity().obs;

  void setInfrared(InfraredEntity infraredEntity) {
    infrared.value = infraredEntity;
  }
}
