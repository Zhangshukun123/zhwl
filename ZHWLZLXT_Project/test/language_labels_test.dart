import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/entity/record_entity.dart' as records;
import 'package:zhwlzlxt_project/utils/language_value.dart';

void main() {
  setUp(() {
    Get.clearTranslations();
    Get.addTranslations(LanguageValue().keys);
    Get.locale = const Locale('en', 'US');
  });

  tearDown(() {
    Get.clearTranslations();
    Get.locale = null;
  });

  test('English intermittent modes start with a capital letter', () {
    expect(Globalization.intermittentOne.tr, 'Intermittent1');
    expect(Globalization.intermittentTwo.tr, 'Intermittent2');
    expect(Globalization.intermittentThree.tr, 'Intermittent3');
  });

  test('English setting starts with a capital letter', () {
    expect(Globalization.setting.tr, 'Setting');
  });

  test('English infrared normal status matches the annotation', () {
    expect(Globalization.infrared_start_onLine.tr, 'Current Status: Normal');
  });

  test('Chinese labels and existing disconnected wording stay unchanged', () {
    Get.locale = const Locale('zh', 'CN');
    expect(Globalization.intermittentOne.tr, '断续1');
    expect(Globalization.intermittentTwo.tr, '断续2');
    expect(Globalization.intermittentThree.tr, '断续3');
    expect(Globalization.setting.tr, '设置');
    expect(Globalization.infrared_start_onLine.tr, '当前正常状态');
    expect(Globalization.unlink.tr, '设备未连接');
  });

  test('Other English mode and vibration labels stay unchanged', () {
    expect(Globalization.continuous.tr, 'Continuous');
    expect(Globalization.vibration.tr, 'Vibration');
    expect(Globalization.start.tr, 'Start');
    expect(Globalization.stop.tr, 'Stop');
  });

  final annotatedLabels = <String, String>{
    Globalization.userManagement: 'User Management',
    Globalization.spasm: 'Spasm Muscle',
    Globalization.muscle: 'Muscle Stimulator',
    Globalization.medium: 'Medium Frequency / Interferential Current',
    Globalization.complete: 'Complete Denervation',
    Globalization.partial: 'Partial Denervation',
    Globalization.factory: 'Factory Settings',
    Globalization.recipe: 'Protocol',
    Globalization.back: 'Back',
    Globalization.man: 'Man',
    Globalization.nv: 'Woman',
    Globalization.hint_011: 'Please enter the user age',
    Globalization.hint_012: 'Please enter the user ID Card',
  };
  for (final entry in annotatedLabels.entries) {
    test('Annotated English label: ${entry.value}', () {
      expect(entry.key.tr, entry.value);
    });
  }

  test('Annotated labels keep their Chinese translations', () {
    Get.locale = const Locale('zh', 'CN');
    final chinese = <String, String>{
      Globalization.userManagement: '用户管理',
      Globalization.spasm: '痉挛肌治疗',
      Globalization.muscle: '神经肌肉电刺激',
      Globalization.medium: '中频/干扰电治疗',
      Globalization.complete: '完全失神经',
      Globalization.partial: '部分失神经',
      Globalization.factory: '出厂设置',
      Globalization.recipe: '处方',
      Globalization.back: '返回',
      Globalization.man: '男',
      Globalization.nv: '女',
    };
    for (final entry in chinese.entries) {
      expect(entry.key.tr, entry.value);
    }
  });

  for (final pair in [
    ['Complete denervation', 'Complete Denervation', '完全失神经'],
    ['Partial denervation', 'Partial Denervation', '部分失神经'],
  ]) {
    test('Old and new ${pair[1]} records retain their Chinese mode', () {
      Get.locale = const Locale('zh', 'CN');
      for (final label in pair.take(2)) {
        final record = records.Record(pattern: label);
        expect(record.getInfoList(), contains('模式：${pair[2]}'));
        expect(record.getListTitle()['模式'], pair[2]);
      }
    });
    test('Chinese ${pair[1]} records use the capitalized English mode', () {
      final record = records.Record(pattern: pair[2]);
      expect(record.getInfoList(), contains('Mode：${pair[1]}'));
      expect(record.getListTitle()['Mode'], pair[1]);
    });
  }
}
