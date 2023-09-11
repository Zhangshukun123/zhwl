import 'package:get/get.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';

import '../dataResource/user_sql_dao.dart';
import '../entity/infrared_entity.dart';
import '../entity/jingLuan_entity.dart';
import '../entity/jingPi_entity.dart';
import '../entity/pulsed_entity.dart';
import '../entity/shenJing_entity.dart';
import '../entity/ultrasonic_entity.dart';
import '../entity/zhongPin_entity.dart';
import '../utils/sp_utils.dart';

class TreatmentController extends GetxController {
  var treatmentType = TreatmentType.spasm.obs;
  var user = User().obs;

  Future<void> setUserForType(type) async {
    int userId = -1;
    switch (type) {
      case TreatmentType.ultrasonic:
        userId =
            SpUtils.getInt(UltrasonicField.UltrasonicKey, defaultValue: -1) ??
                -1;
        break;
      case TreatmentType.pulsed:
        userId =
            SpUtils.getInt(PulsedField.PulsedKey, defaultValue: -1) ??
                -1;
        break;
      case TreatmentType.infrared:
        userId =
            SpUtils.getInt(InfraredField.InfraredKey, defaultValue: -1) ??
                -1;
        break;
      case TreatmentType.spasm:
        userId =
            SpUtils.getInt(SpasticField.SpasticKey, defaultValue: -1) ??
                -1;
        break;
      case TreatmentType.percutaneous:
        userId =
            SpUtils.getInt(PercutaneousField.PercutaneousKey, defaultValue: -1) ??
                -1;
        break;
      case TreatmentType.neuromuscular:
        userId =
            SpUtils.getInt(NeuromuscularField.NeuromuscularKey, defaultValue: -1) ??
                -1;
        break;
      case TreatmentType.frequency:
        userId =
            SpUtils.getInt(MidFrequencyField.MidFrequencyKey, defaultValue: -1) ??
                -1;
        break;
    }
    if (userId != -1) {
      var value =
          await UserSqlDao.instance().queryUserForUserId(userId: userId);
      if (value != null && value.length != 0) {
        user.value = User.fromMap(value[0]);
      }
    }
  }
}
