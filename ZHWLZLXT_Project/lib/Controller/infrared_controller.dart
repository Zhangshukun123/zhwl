import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../entity/infrared_entity.dart';

class InfraredController extends GetxController{
  var infraredEntity = InfraredEntity().obs;
}