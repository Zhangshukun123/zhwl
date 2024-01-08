import '../utils/treatment_type.dart';
import '../utils/utils_tool.dart';

bool cureState = false;//超声治疗
bool? MccCureState = false;//脉冲磁疗法
bool? HwpzgCureState = false;//红外偏振光治疗
bool? JljCureState = false;//痉挛肌治疗
bool? JpsjCureState = false;//经皮神经电刺激
bool? SjjrCureState = false;//神经肌肉电刺激
bool? ZpgrdCureState = false;//中频/干扰电治疗



checkCure(type) {
  if ((cureState ?? false) && type == TreatmentType.ultrasonic) {
    showToastMsg(msg: '治疗过程中禁止操作');
    return true;
  }
  if ((MccCureState ?? false) && type == TreatmentType.pulsed) {
    showToastMsg(msg: '治疗过程中禁止操作');
    return true;
  }
  if ((HwpzgCureState ?? false) && type == TreatmentType.infrared) {
    showToastMsg(msg: '治疗过程中禁止操作');
    return true;
  }
  if ((JljCureState ?? false) && type == TreatmentType.spasm) {
    showToastMsg(msg: '治疗过程中禁止操作');
    return true;
  }
  if ((JpsjCureState ?? false) && type == TreatmentType.percutaneous) {
    showToastMsg(msg: '治疗过程中禁止操作');
    return true;
  }
  if ((SjjrCureState ?? false) &&type == TreatmentType.neuromuscular) {
    showToastMsg(msg: '治疗过程中禁止操作');
    return true;
  }
  if ((ZpgrdCureState ?? false) &&type == TreatmentType.frequency) {
    showToastMsg(msg: '治疗过程中禁止操作');
    return true;
  }

  return false;
}