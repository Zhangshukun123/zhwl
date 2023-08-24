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
        if (SpUtils.getString(UltrasonicField.UltrasonicKey)?.isNotEmpty ==
            true) {
          userId = Ultrasonic.fromJson(
                      SpUtils.getString(UltrasonicField.UltrasonicKey)!)
                  .userId ??
              -1;
        } else {
          userId = -1;
        }
        break;
      case TreatmentType.pulsed:
        if (SpUtils.getString(PulsedField.PulsedKey)?.isNotEmpty == true) {
          userId = Pulsed.fromJson(SpUtils.getString(PulsedField.PulsedKey)!)
                  .userId ??
              -1;
        } else {
          userId = -1;
        }
        break;
      case TreatmentType.infrared:
        if (SpUtils.getString(InfraredField.InfraredKey)?.isNotEmpty == true) {
          userId = InfraredEntity.fromJson(
                      SpUtils.getString(InfraredField.InfraredKey)!)
                  .userId ??
              -1;
        } else {
          userId = -1;
        }
        break;
      case TreatmentType.spasm:
        if (SpUtils.getString(SpasticField.SpasticKey)?.isNotEmpty == true) {
          userId = Spastic.fromJson(SpUtils.getString(SpasticField.SpasticKey)!)
                  .userId ??
              -1;
        } else {
          userId = -1;
        }
        break;
      case TreatmentType.percutaneous:
        if (SpUtils.getString(PercutaneousField.PercutaneousKey)?.isNotEmpty ==
            true) {
          userId = Percutaneous.fromJson(
                      SpUtils.getString(PercutaneousField.PercutaneousKey)!)
                  .userId ??
              -1;
        } else {
          userId = -1;
        }
        break;
      case TreatmentType.neuromuscular:
        if (SpUtils.getString(NeuromuscularField.NeuromuscularKey)
                ?.isNotEmpty ==
            true) {
          userId = Neuromuscular.fromJson(
                      SpUtils.getString(NeuromuscularField.NeuromuscularKey)!)
                  .userId ??
              -1;
        } else {
          userId = -1;
        }
        break;
      case TreatmentType.frequency:
        if (SpUtils.getString(MidFrequencyField.MidFrequencyKey)?.isNotEmpty ==
            true) {
          userId = MidFrequency.fromJson(
                      SpUtils.getString(MidFrequencyField.MidFrequencyKey)!)
                  .userId ??
              -1;
        } else {
          userId = -1;
        }
        break;
    }
    print('--------------${userId}');
    if (userId != -1) {
      var value =
          await UserSqlDao.instance().queryUserForUserId(userId: userId);
      if (value != null && value.length != 0) {
        user.value = User.fromMap(value[0]);
      }
    }
  }
}
