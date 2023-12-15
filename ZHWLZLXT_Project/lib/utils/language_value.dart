import 'package:get/get_navigation/src/root/internacionalization.dart';

import '../base/globalization.dart';

class LanguageValue extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          Globalization.login: "login",
          Globalization.setting: "setting",
          Globalization.language: "Language",
          Globalization.bluetooth: "Bluetooth",
          Globalization.open: "Open",
          Globalization.close: "Close",
          Globalization.brightness: "Brightness",
          Globalization.userManagement: "UserManagement",
          Globalization.mode: "Mode",
          Globalization.time: "Time",
          Globalization.power: "Power",
          Globalization.soundIntensity: "SoundIntensity",
          Globalization.pPower: "Power",
          Globalization.pSoundIntensity: "SoundIntensity",
          Globalization.frequency: "Frequency",
          Globalization.start: "Start",
          Globalization.stop: "Stop",
          Globalization.details: "Details",
          Globalization.intensity: "Intensity",
          Globalization.vibration: "Vibration",
          Globalization.currEmStSt: "Current Emergency Stop State",
          Globalization.pulseWidthA: "Pulse Width(A)",
          Globalization.pulseWidthB: "Pulse Width(B)",
          Globalization.delayTime: "Delay Time",
          Globalization.pulsePeriod: "Pulse Period",
          Globalization.intensityA: "Intensity(A)",
          Globalization.intensityB: "Intensity(B)",
          Globalization.pulseWidth: "Pulse Width",
          Globalization.recipe: "Recipe",
          Globalization.ultrasound: "Ultrasound Therapy",
          Globalization.pulse: "Pulse Magnetic Therapy",
          Globalization.infrared: "Infrared Polarized Light Therapy",
          Globalization.electricity: "Electrotherapy",
          Globalization.spasm: "SpasmMuscle",
          Globalization.tens: "TENS",
          Globalization.muscle: "MuscleStimulator",
          Globalization.medium: "MediumFrequency/InterferentialCurrent",
          Globalization.name: "Name",
          Globalization.tel: "Tel",
          Globalization.no: "No.",
          Globalization.age: "Age",
          Globalization.gender: "Gender",
          Globalization.certificate: "Certificate",
          Globalization.hospitalNo: "Hospital No.",
          Globalization.bedNo: "Bed No.",
          Globalization.editInfo: "EditInformation",
          Globalization.treatmentRecords: "Treatment Records",
          Globalization.startTreatment: "Start treatment",
          Globalization.newUsers: "New Users",
          Globalization.save: "Save",
          Globalization.cancel: "Cancel",
          Globalization.addUser: "Add user",
          Globalization.theme: "Integrated Physiotherapy System",
          Globalization.rememberPassword: "Remember password",
          Globalization.version: "Current Version Number",
          Globalization.confirm: "Confirm",
          Globalization.userName: "Please input username",
          Globalization.password: "Please input password",
          Globalization.continuous: "Continuous",
          Globalization.intermittentOne: "intermittent1",
          Globalization.intermittentTwo: "intermittent2",
          Globalization.intermittentThree: "intermittent3",
          Globalization.fast: "Fast Intermittent",
          Globalization.slow: "Slow Intermittent",
          Globalization.complete: "Complete denervation",
          Globalization.partial: "Partial denervation",
          Globalization.factory: "FactorySettings",
          Globalization.sweep: "SweepFrequency",
          Globalization.output: "OutputPower",
          Globalization.user: "User",
          Globalization.times: "times",
        },
        "zh_CN": {
          Globalization.login: "登录",
          Globalization.setting: "设置",
          Globalization.language: "语言",
          Globalization.bluetooth: "蓝牙",
          Globalization.open: "打开",
          Globalization.close: "关闭",
          Globalization.brightness: "亮度调节",
          Globalization.userManagement: "用户管理",
          Globalization.mode: "模式",
          Globalization.time: "时间",
          Globalization.power: "功率",
          Globalization.soundIntensity: "声强",
          Globalization.pPower: "输出功率",
          Globalization.pSoundIntensity: "有效声强",
          Globalization.frequency: "频率",
          Globalization.start: "开始",
          Globalization.stop: "停止",
          Globalization.details: "详情",
          Globalization.intensity: "强度",
          Globalization.vibration: "振动",
          Globalization.currEmStSt: "当前急停状态",
          Globalization.onLine: "链接正常",
          Globalization.unlink: "链接异常",
          Globalization.temperatureNormals: "温度正常",
          Globalization.temperatureAnomaly: "温度异常",
          Globalization.Hz: "频率",
          Globalization.connectionTimeout: "设备连接超时",
          Globalization.reconnect: "正在尝试重新连接",
          Globalization.endOfTreatment: "治疗结束",
          Globalization.OI: "操作说明",
          Globalization.NeedAttention: "注意事项",
          Globalization.infrared_start_onLine: "当前正常状态",
          Globalization.pulseWidthA: "脉宽(A)",
          Globalization.pulseWidthB: "脉宽(B)",
          Globalization.delayTime: "延时时间",
          Globalization.pulsePeriod: "脉冲周期",
          Globalization.intensityA: "强度(A)",
          Globalization.intensityB: "强度(B)",
          Globalization.pulseWidth: "脉宽",
          Globalization.recipe: "处方",
          Globalization.setTime: "设定时间",
          Globalization.cureTime: "治疗时长",
          Globalization.openTime: "震动打开时间",
          Globalization.ultrasound: "超声疗法",
          Globalization.pulse: "脉冲磁疗法",
          Globalization.infrared: "红外偏振光治疗",
          Globalization.electricity: "电疗",
          Globalization.spasm: "痉挛肌治疗",
          Globalization.tens: "经皮神经电刺激",
          Globalization.muscle: "神经肌肉电刺激",
          Globalization.medium: "中频/干扰电治疗",
          Globalization.hint_007: "请输入电话",
          Globalization.man: "男",
          Globalization.nv: "女",
          Globalization.name: "姓名",
          Globalization.tel: "电话",
          Globalization.no: "编号",
          Globalization.age: "年龄",
          Globalization.gender: "性别",
          Globalization.certificate: "证件",
          Globalization.hospitalNo: "住院号",
          Globalization.bedNo: "床号",
          Globalization.editInfo: "编辑信息",
          Globalization.treatmentRecords: "治疗记录",
          Globalization.startTreatment: "开始治疗",
          Globalization.newUsers: "新增用户",
          Globalization.save: "保存",
          Globalization.cancel: "取消",
          Globalization.addUser: "添加用户",
          Globalization.theme: "综合物理治疗系统",
          Globalization.rememberPassword: "记住密码",
          Globalization.version: "当前版本号",
          Globalization.confirm: "确定",
          Globalization.userName: "请输入用户名",
          Globalization.password: "请输入密码",
          Globalization.continuous: "连续",
          Globalization.intermittentOne: "断续1",
          Globalization.intermittentTwo: "断续2",
          Globalization.intermittentThree: "断续3",
          Globalization.fast: "快速断续输出",
          Globalization.slow: "慢速断续输出",
          Globalization.complete: "完全失神经",
          Globalization.partial: "部分失神经",
          Globalization.factory: "出厂设置",
          Globalization.sweep: "扫频",
          Globalization.output: "输出功率",
          Globalization.back: "返回",
          Globalization.startTimeDate: "开始时间",
          Globalization.endTimeDate: "结束时间",
          Globalization.hint_001: "获取用户信息错误，请退出重新登录！",
          Globalization.hint_002: "请输入治疗方式",
          Globalization.hint_003: "导出成功，导出文件",
          Globalization.hint_004: "获取权限失败，请打开内部存储权限",
          Globalization.hint_005: "请选择时间段",
          Globalization.hint_006: "未找到数据",
          Globalization.hint_007: "请输入电话",
          Globalization.hint_008: "更新成功",
          Globalization.hint_009: "更新失败",
          Globalization.ExportMonth: "导出当月",
          Globalization.ExportYear: "导出当年",
          Globalization.ExportAll: "全部导出",
          Globalization.therapyMethod: "治疗方式",
          Globalization.derivedRecord: "导出记录",
          Globalization.RecordTime: "记录时间",
          Globalization.date: "日期",
          Globalization.user: "用户",
          Globalization.times: "次",
          Globalization.AttentionFour:
              '1.电极片放置在人体上以后，不要操作治疗系统的电源开关，否则可能会产生瞬间电击感。治疗前，必须先打开电源开关，再把电极片放置在人体上，治疗结束后，必须先把电极片从患者身上取下来，再关闭电源开关。\n'
                  '2.治疗时，强度应遵循由小到大的原则，循序渐进，强度以患者耐受力为准。若出现停电，请及时关闭电源开关，并摘除患者身上电极片。\n'
                  '3.自粘电极片只能本人使用，不能与他人共用，避免交叉感染；与使用者接触的其它电极片，在治疗前后，应先用清水清洗后再使用医用棉球酿75%的医用酒精对电极片导电面进行擦试消毒后使用。\n'
                  '4.电极片使用时应与皮肤紧密、均匀接触。\n'
                  // '5.首次进行干扰电治疗使用吸附电极时，应先点击操作界面上的“水瓶”按钮进行排水操作，等15s后停止排水方可进行治疗。\n'
                  // '6.吸附压力大小应适度，长时间大的负压可能导致吸附电极处皮肤出现红紫乃至于出现水泡的现象，因此在吸附电极放置完毕后应将压力大小调至保证吸附电极不脱落情况下的最小值，避免发生上述情况。\n'
                  '5．靠近胸部使用电极片会增加心脏纤顿的危险，治疗时避免靠近胸部的刺激。',
          Globalization.AttentionThree:
              '1.必须避免使用易燃麻醉剂或氧化性气体如氧化亚氮（N₂O）和氧气（O₂）等；某些材料如棉毛物，在富含氧气时会被设备产生的高温点燃；用于清洗、消毒的溶剂和可燃溶液应在使用红外偏振光模块前使其挥发；避免内部气体点燃的危险。\n'
                  '2.在使用过程中，要注意辐射距离应大于1cm；应避免眼或生殖器受到直射或散射辐射的照射，严禁直视辐射窗口。\n'
                  '3.在治疗过程中，患者产生任何不适或出现意外情况时，请按急停开关，均应立即停止治疗。',
          Globalization.AttentionTwo:
              '1.开机前必须检查各处连接是否良好，接口处不能松动、滑脱，上电后，用脉冲磁模块显示默认设置状态，应根据实际需要设定各参数。\n'
                  '2.治疗时，患者产生任何不适或出现意外情况时（如对磁场敏感者可能产生头晕、呕吐等晕磁现象），均应立即停止治疗。\n'
                  '3.请使用该模块标配的治疗磁垫，不得随意更换为其它厂商提供的部件或材料，否则有可能因与该模块不匹配，造成输出值不稳定降低安全度，影响治疗效果或损坏该模块。\n'
                  '4.治疗垫不可以在重叠放置时通电，也不能重叠、重压、折弯放置。\n'
                  '5.请不要接近有手表、手饰等金属制品以及有磁性的物品。\n'
                  '6.治疗时，患者产生任何不适或出现意外情况时，均应立即停止治疗。',
          Globalization.detailsSeven: '中频/干扰电模块包括中频、干扰电两种治疗模式。\n'
              '处方1～50是中频治疗处方，在中频治疗模式下有通道一、通道二两个治疗通道，互不干扰；\n'
              '处方51～60是干扰电治疗处方，在干扰电治疗模式下两个通道同时工作。\n'
              '中频操作说明：\n'
              '1.将电极片与中频输出接口妥善连接。\n'
              '2.处方选择范围1～50。\n'
              '3.治疗时间已在处方内，不需要设置。\n'
              '4.点击开始按钮，可以调节强度（0～99可调，步进为1），请慢速调节强度，在调节的过程中，不断询问患者的感受。\n'
              '5.当设定治疗时间结束或手动停止输出，输出停止。\n'
              '6.“+、-”键的图标为灰色表示不可选。\n'
              '提示：中频治疗有两个不同的治疗通道，通道一、通道二可以单独进行治疗，也可以司时进行治疗。上述操作步骤以通道一为例。\n'
              '干扰电操作说明：\n'
              '1.干扰电输出，需要使用四个干扰电极片。\n'
              '2.处方选择范围51～60。\n'
              '3.治疗时间已在处方内，不需要设置。\n'
              '4.点击开始按钮，可以调节强度（0～99可调，步进为1），请慢速调节输出强度，如果是负压吸附治疗调节吸附压力，在调节的过程中不断询问患者的感受。\n'
              '5.当设定治疗时间结束或手动停止输出，输出停止。\n'
              '6.“+、-”键的图标为灰色表示不可选。',
          Globalization.detailsSix: '1.将电极片与电疗输出接口妥善连接。\n'
              '2.设置相关参数：模式、时间和频率；\n'
              '2.1模式：通过调节选择完全失神经和部分失神经；\n'
              '2.2频率：\n'
              '第I档（完全失神经）：调制频率为0.5Hz～5Hz可调，步进为0.5Hz；\n'
              '第Ⅱ档（部分失神经）：输出脉冲频率为0.5Hz～5Hz可调，步进为0.5Hz；\n'
              '2.3治疗时间：1min~30min可调，步进为1min。\n'
              '3.将电极片放置在需治疗部位，在治疗前，先将需要治疗的部位进行清洁，再用医用酒精擦洗皮肤擦除皮肤上的油脂，再用清水润湿皮肤加强皮肤的导电性。\n'
              '4.点击开始按钮，可以调节强度（0～99可调，步进为1），请慢速调节强度，在调节的过程中，不断询问患者的感受。\n'
              '5.当设定治疗时间结束或手动停止输出，输出停止。\n'
              '6.“+、-”键的图标为灰色表示不可选。\n'
              '提示：神经肌肉电刺激治疗有两个不同的治疗通道，通道一、通道二可以单独进行治疗，也可以同时进行治疗。上述操作步骤以通道一为例。',
          Globalization.detailsFive: '1.将电极片与电疗输出接口妥善连接。\n'
              '2.设置相关参数：模式、时间、频率和脉宽；\n'
              '2.1模式：通过调节选择连续、慢速断续输出或快速断续输出模式；\n'
              '2.2频率：2Hz～160Hz可调，步进1Hz；\n'
              '2.3脉宽：60us～520us可调，步进10us；\n'
              '2.4冶疗时间：1min~30min可调，步进1min。\n'
              '3.将电极片放置在需治疗部位，在治疗前，先将需要治疗的部位进行清洁，先用医用酒精擦洗皮肤擦除皮肤上的油脂，再用清水润湿皮肤加强皮肤的导电性。\n'
              '4.点击开始按钮，可以调节强度（0～99可调，步进1），请慢速调节强度，在调节的过程中，不断询问患者的感受。\n'
              '5.当设定治疗时间结束或手动停止输出，输出停止。\n'
              '6.“+、-”键的图标为灰色表示不可选。\n'
              '提示：经皮神经电刺激治疗有两个不同的治疗通道，通道一、通道二可以单独进行治疗，也可以同时进行治疗。上述操作步骤以通道一为例。',
          Globalization.detailsFour: '1.将电极片与电疗输出接口妥善连接。\n'
              '2.设置相关参数：时间、脉冲周期、延时时间、脉宽A和脉宽B；\n'
              '2.1脉冲周期：1s～2s可调，步进为0.1s；\n'
              '2.2脉冲宽度：0.1ms~0.5ms可调，步进为0.1ms；\n'
              '2.3延时时间：一组输出的第二路输出比第一路输出延时时间为0.1s～1.5s可调，步进为0.1s，允差±20%；\n'
              '2.4治疗时间为1min~30min可调，步进为1min。\n'
              '3.将电极片放置在需治疗部位，在治疗前，先将需要治疗的部位进行清洁，再用医用酒精擦洗皮肤，擦去皮肤上的油脂，再用清水润湿皮肤加强皮肤的导电性。\n'
              '4.点击开始按钮，强度（0～99可调，步进为1），请慢速调节强度，在调节的过程中，不断询问患者的感受。\n'
              '5.当设定治疗时间结束或手动停止输出时，输出停止。\n'
              '6.“+、-”的图标为灰色表示不可选。',
          Globalization.detailsThree: '1.将辐射器与红外偏振光模块输出接口妥善连接。\n'
              '2.模式：连续、断续1、断续2和断续3四种治疗模式，通过图标选择不同的治疗模式。\n'
              '3.时间：范围0~99min可调，步进1min，通过+、-键设置时间。\n'
              '4.强度：1～8个档位可调，步进为1，通过+、-键设置强度。\n'
              '5.辐射器正常连接，选择治疗模式，设定治疗时间，点击开始按钮开始治疗，当设定治疗时间结束或手动停止输出，停止输出。\n'
              // '6.辐射器开关断开界面会显示“未连接”字样；开关闭合“未连接”字样消失。\n'
              '6.在治疗状态下，按下急停按钮，输出停止，界面会出现“急停状态”红色字样，确认急停事件消除后，可将急停按钮顺时针旋转按钮为90°，可解除急停状态，此时界面急停状态变成正常状态。\n'
              '提示：按下急停时，红外偏振光模块按钮上同步显示急停图标，待急停状态解除后消失。\n'
              '7.“+、-”的图标为灰色表示不可选。',
          Globalization.detailsTwo: '1.将磁垫与脉冲磁模块输出接口妥善连接。\n'
              '2.界面默认显示频率20次/min，强度0，时间20min。\n'
              '3.通过“+、-”键调节频率、时间和强度。\n'
              '3.1强度：范围0～5可调，步进1；\n'
              '3.2频率：范围20次/min～80次/min可调，步进10次/min；\n'
              '3.3时间：范围1min~99min可调，步进1min。\n'
              '4.根据患者情况和治疗部位，选择治疗垫对置或平行放置方式。\n'
              '5.治疗时间达到设定值或手动停止时，输出停止。\n'
              // '6.只有方形磁垫启动后才可以选择是否开启振动功能。\n'
              '6.“+、-”的图标为灰色表示不可选。',
          Globalization.AttentionOne:
              "1.超声波治疗必须要有足够的耦合剂涂抹在皮肤表层，以便于超声波导入人体，同时治疗头要完全接触皮肤才能保证超声波的正常传导。耦合剂过少或探头与皮肤接触不良，超声波就难以传导入人体，治疗头易发烫可能会受到损害，耦合剂不可用其他物品代替。\n"
                  "2.治疗头必须围绕“治疗部位”作往复式移动，不能固定或停留在某一部位。\n"
                  "3.极个别患者在治疗时偶有烧灼感或刺痛感，这是骨膜对超声波的“过敏”反应，停止治疗即可恢复，无任何后患。\n"
                  "4.耦合剂切勿涂抹于皮肤破损及近眼睛和嘴部等位置。\n"
                  "5.耦合剂的选用标准：所购买的耦合剂要符合YY0299-2016标准。\n"
                  "6.使用中偶有局部皮肤发红、发痒，停用后可自行消失。\n"
                  "7.对耦合剂组成成分过敏者慎用，过敏体质者，可先在手腕试用，待15分钟以后皮肤无红痒肿胀等异常现象，即可使用。\n"
                  "8.治疗时，强度应遵循由小到大的原则，循序渐进，功率以患者耐受力为准。",
          Globalization.detailsOne: "1.将超声波治疗头与超声波模块输出接口妥善连接。 \n"
              "2.默认显示模式“断续1”，输出功率0，有效声强0，时间20min。\n"
              "2.1模式：连续、断续1、断续2和断续3四种治疗模式，通过选择框选择不同的治疗模式。\n"
              "2.2时间：范围1min~30min可调，步进1min，调节	“+、-”可以选择治疗时间，治疗时间达到设定值或手动停止时，输出停止。\n"
              "3.1.1M输出功率：范围0~7.2W可调，步进0.6W，启动后，根据调节“+、-”来调节输出功率大小。\n"
              "3.2.3M输出功率：范围0~6W可调，步进0.6W，启动后，根据调节“+、-”来调节输出功率大小。\n"
              "4.1.1M有效声强：范围0~1.8W/cm²可调，步进0.15W/cm²，调节输出功率时，有效声强随之变化。\n"
              "4.2.3M有效声强：范围0~3W/cm²可调，步进0.3W/cm²，调节输出功率时，有效声强随之变化。\n"
              "5.超声波治疗头未连接时，会出现“链接异常!”提示信息，识别到超声治疗头，提示“链接正常”。\n"
              "6.长时间工作，超声治疗头处于高温状态时，会出现“温度异常”提示字样，同时停止输出，时间处于倒计时状态，当治疗头温度降低到工作正常温度时，“温度异常”字样变为“温度正常”，治疗头继续输出。\n"
              "7.“+、-”的图标为灰色表示不可选。",
        }
      };
}
