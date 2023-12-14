class Globalization {
  static const String languageSelected = "languageSelected";
  static const String login = "login"; //登录
  static const String setting = "setting"; //设置
  static const String language = "language"; //语言
  static const String bluetooth = "bluetooth"; //蓝牙
  static const String open = "open"; //打开
  static const String close = "close"; //关闭
  static const String brightness = "brightness"; //亮度
  static const String userManagement = "user management"; //用户管理
  static const String mode = "Mode"; //模式
  static const String time = "Time"; //时间
  static const String power = "Power"; //功率
  static const String soundIntensity = "Sound Intensity"; //声强
  static const String pPower = "Power"; //输出功率
  static const String pSoundIntensity = "Sound Intensity"; //有效声强
  static const String frequency = "Frequency"; //频率
  static const String start = "Start"; //开始
  static const String stop = "Stop"; //停止
  static const String details = "Details"; //详情
  static const String intensity = "Intensity"; //强度
  static const String vibration = "Vibration"; //震动
  static const String currEmStSt = "Current Emergency Stop State"; //当前急停状态
  static const String onLine = "on line"; //当前急停状态
  static const String unlink = "unlink"; //当前急停状态
  static const String temperatureNormals = "temperature normals"; //当前急停状态
  static const String temperatureAnomaly = "temperature anomaly"; //当前急停状态
  static const String OI = "OI"; //当前急停状态
  static const String NeedAttention = "NeedAttention"; //当前急停状态
  static const String Hz = "Hz"; //当前急停状态
  static const String connectionTimeout = "Device connection timeout"; //当前急停状态
  static const String reconnect = "reconnect"; //当前急停状态
  static const String endOfTreatment = "End of treatment"; //当前急停状态
  // ignore: constant_identifier_names
  static const String infrared_start_onLine = "Current normal state"; //当前急停状态
  static const String pulseWidthA = "Pulse Width(A)"; //脉宽A
  static const String pulseWidthB = "Pulse Width(B)"; //脉宽B
  static const String delayTime = "Delay Time"; //延时时间
  static const String pulsePeriod = "Pulse Period"; //脉冲周期
  static const String intensityA = "Intensity(A)"; //强度A
  static const String intensityB = "Intensity(B)"; //强度B
  static const String pulseWidth = "Pulse Width"; //脉宽
  static const String recipe = "Recipe"; //处方
  static const String ultrasound = "Ultrasound Therapy"; //超声疗法
  static const String pulse = "Pulse Magnetic Therapy"; //脉冲磁疗法
  static const String infrared = "Infrared Polarized Light Therapy"; //红外偏振光治疗
  static const String electricity = "Electrotherapy"; //电疗
  static const String spasm = "SpasmMuscleTherapy"; //痉挛肌治疗
  static const String tens = "TENS"; //经皮神经电刺激
  static const String muscle = "MuscleStimulator"; //神经肌肉电刺激
  static const String medium =
      "MediumFrequency/InterferentialCurrentTherapy"; //中频/干扰电治疗
  static const String name = "Name"; //姓名
  static const String tel = "Tel"; //电话
  static const String no = "No."; //编号
  static const String age = "Age"; //年龄
  static const String gender = "Gender"; //性别
  static const String certificate = "Certificate"; //证件
  static const String hospitalNo = "Hospital No."; //住院号
  static const String bedNo = "Bed No."; //床号
  static const String editInfo = "Edit information"; //编辑信息
  static const String treatmentRecords = "Treatment Records"; //治疗记录
  static const String startTreatment = "Start treatment"; //开始治疗
  static const String newUsers = "New Users"; //新增用户
  static const String save = "Save"; //保存
  static const String cancel = "Cancel"; //取消
  static const String addUser = "Add user"; //添加用户
  static const String theme = "Integrated Physiotherapy System"; //综合物理治疗系统
  static const String rememberPassword = "Remember password"; //记住密码
  static const String version = "Current Version Number"; //当前版本号
  static const String confirm = "Confirm"; //确定
  static const String userName = "Please input username"; //请输入用户名
  static const String password = "Please input password"; //请输入密码
  static const String continuous = "Continuous"; //连续
  static const String intermittentOne = "intermittent1"; //断续 1
  static const String intermittentTwo = "intermittent2"; // 断续 2
  static const String intermittentThree = "intermittent3"; // 断续 3
  static const String fast = "Fast Intermittent"; // 快速断续输出
  static const String slow = "Slow Intermittent"; // 慢速断续输出
  static const String complete = "Complete denervation"; // 完全失神经
  static const String partial = "Partial denervation"; // 部分失神经
  static const String factory = "FactorySettings"; // 出厂设置
  static const String sweep = "SweepFrequency"; // 扫频
  static const String output = "OutputPower"; // 输出功率
  static const String detailsSix =
      "1.Connect the electrode pad to the electrotherapy output interface properly\n"
      "2.Set relevant parameters: mode, time and frequency\n"
      "2.1 Mode: select complete denervation and partial denervation through adjustment w > ;\n"
      "2.2 Frequency:The first level (complete denervation): the modulation frequency is adjustable from 0.5Hz to5Hz,and the step is 0.5Hz;The second level (partial denervation): the output pulse frequency is adjustable from 0.5Hz to5Hz,and the step is 0.5Hz;\n"
      "2.3 Treatment Time: adjustable from lmin to 30min, and the step is lmin.\n"
      "3. Place the electrode pad on the part to be treated. Before treatment, clean the part to be treatedthen scrub the skin with medical alcohol to remove the oil on the skin, and then moisten the skinwith water to enhance the conductivity of the skin.\n"
      "4. Click the icon > , there will be a voice prompt of\"Start Neuromuscular Therapy Channel 1\"and the intensity can be adjusted (adjustable from 0 to 99, step is 1). Please adjust the intensityslowly. During the adjustment process, keep asking the patient how they feel .\n"
      "5. When the set treatment time ends or the output is stopped manually, there will be a voiceprompt of\"Stop Neuromuscular Therapy Channel 1\"\n"
      "6. Icons 4 > and icons of \"+ -\" keys are gray to indicate that they are not selectable.Tip: There are two different treatment channels for Neuromuscular Electrical StimulationTherapy . Channel 1 and Channel 2 can be treated individually or simultaneously. The aboveoperation steps take channel 1 as an example.\"\n";
  static const String detailsFive =
      "1.Connect the electrode pad to the electrotherapy output interface properly\n"
      "2.Set related parameters: mode, time, frequency and pulse width\n"
      "2.1 Mode: select continuous, slow intermittent output or fast intermittent output mode byadjustment:\n"
      "2.2 Frequency: adjustable from 2Hz to 160Hz, step 1Hz;\n"
      "2.3 Pulse Width:60us ~ 520us adjustable, step 10us;\n"
      "2.4 Treatment time: adjustable from lmin to 30min, step by lmin.\n"
      "3. Place the electrode pad on the part to be treated. Before the treatment, clean the part to betreated, first scrub the skin with medical alcohol to remove the oil on the skin, and then moistenthe skin with water to enhance the conductivity of the skin.\n"
      "4. Click on the icon  , there will be a voice prompt of \"Start TENS Channel 1\", and the inten.sity can be adjusted (adjustable from 0 to 99, step 1). Please adjust the intensity slowly. Duringthe adjustment process, keep asking the patient's feel.\n"
      "5. When the set treatment time ends or the output is manually stopped, there will be a voiceprompt of\"Stop TENS Channel 1\"\n"
      "6. Icons 4 》 and icons of \"+ -\" keys are gray to indicate that they are not selectable.Tip: There are two different treatment channels for TENS. Channel 1 and Channel 2 can betreated individually or simultaneously. The above operation steps take channel 1 as an example\n";
  static const String detailsFour =
      "1. Connect the electrode pads to the electrotherapy output interface properly.\n"
      "2. Set related parameters: time, pulse period, delay time, pulse width A and pulse width B\n"
      "2.1 Pulse Period: adjustable from 1s to 2s, step is 0.1s;\n"
      "2.2 Pulse Width: adjustable from 0.1ms to 0.5ms, step is 0.lms\n"
      "2.3 Delay Time: the delay time of the second output of a group of outputs is adjustable from 0.1sto 1.5s compared to the first output, the step is 0.1s, and error +20%;\n"
      "2.4 The treatment time is adjustable from lmin to 30min, and the step is lmin.\n"
      "3. Place the electrode pad on the part to be treated. Before treatment, clean the part to be treated.then scrub the skin with medica alcohol, wipe off the oil on the skin, and then moisten the skinwith water to enhance the conductivity of the skin.\n"
      "4. Click the icon > , there will be a voice prompt of\"Start Spasm Muscle Therapy\", the intensity(adjustable from 0 to 99, the step is 1), please adjust the intensity slowly. During the adjustmentprocess, keep asking the patient how they feel.\n"
      "5. When the set treatment time ends or the output is stopped manually, there will be a voiceprompt of\Stop Spasm Muscle Therapy\".\n"
      "6. The icons of\"+ -\"are gray to indicate that they are not selectable.\n";

  static const String detailsThree =
      "1. Properly connect the radiator to the output interface of the infrared polarized light module\n"
      "2,Mode: continuous, intermittent 1, intermittent 2 and intermittent 3, four treatment modesselect different treatment modes by icon .\n"
      "3. Time: adjustable from 0 to 99 minutes, the step is 1 minute, and the time is set by the + and -keys.\n"
      "4. Intensity: adjustable from 1 to 8 gears, the step is 1, and the intensity is set by + and - keys.\n"
      "5. The radiator is connected normally, select the treatment mode, set the treatment time, clickthe icon > . there will be a voice prompt of\"Start Infrared Polarized Light Therapy\", when theset treatment time ends or the output is manually stopped, there will be a \"Stop InfraredPolarized Light Therapy\" voice prompts.\n"
      "6. When the radiator switch is disconnected, the word \"Not Connected\" will be displayed; whenthe switch is closed the word \"Not Connected\" will disappear.\n"
      "7. In the treatment state, press the emergency stop button to stop the output, and the red words\"Emergency Stop State\" will appear on the interface. Rotate the button clockwise to 90°tocancel the emergency stop state, and the prompt information on the interface disappears.Tip: When pressing the emergency stop, the emergency stop icon will be displayed on thebutton of e# the infrared polarized light module synchronously, and it will disappear after theemergency stop state is released.\n"
      "8. The icons <  with \"+ -\" are gray to indicate that they are not selectable.\n";

  static const String AttentionOne =
      "1. Ultrasound therapy must have enough couplant applied to the skin surface to facilitate thetransmission of ultrasound into the human body. At the same time, the probe must becompletely in contact with the skin to ensure the normal conduction of ultrasound. If thecouplant is too little or the probe is in poor contact with the skin, it will be difficult for theultrasound to be transmitted into the human body, and the probe may become hot and may bedamaged.The couplant cannot be replaced by other items.\n"
      "2. The treatment head must move reciprocatingly around the \"treatment part\", and cannot befixed or stay in a certain part.\n"
      "3. Very few patients have occasional burning or tingling sensation during treatment, which is an\"allergic\" reaction of the periosteum to ultrasound, and it can be recovered after stoppingtreatment without any trouble\n"
      "4. Do not apply the couplant on damaged skin and near the eyes and mouth.\n"
      "5. Selection criteria for couplant: the purchased couplant must comply with the YY0299-2016standard.\n"
      "6. Occasionally, local skin redness and itching may occur during use, which will disappear onits own after discontinuation.\n"
      "7. Those who are allergic to the components of the couplant should use it with caution. Thosewith allergic constitution can try it on the wrist first. After 15 minutes, the skin can be appliedwithout any abnormality such as redness, itching and swelling.\n"
      "8. During treatment, the intensity should follow the principle of increasing from little to large.and the intensity should be based on the patient's tolerance.\n";

  static const String detailsOne =
      "1. Properly connect the ultrasound probe and the output interface of the ultrasound module.\n"
      "2. The default display mode is Intermittent 1, the output power is 0, the effective sound intensity is 0,and the time is 10 minutes.\n"
      "2.1 Mode: continuous.intermittent 1, intermittent 2 and intermittent 3, four treatment modes.select different treatment modes through the left and right keys.\n"
      "2.2 Time: the range is adjustable from lmin to 30min, and the step is lmin. You can choose thetreatment time by adjusting \"+ -\". When the treatment time reaches the set value or stopsmanually, there will be a prompt sound of \"Stop Ultrasound Therapy\" and the output will stop\n"
      "3. Output Power: the range is adjustable from 0 to 7.2W, and the step is 0.6W. After starting.there will be a prompt sound of \"Stop Ultrasound Therapy\", and the output power can beadjusted according to the adjustment of\"+ -\"\n"
      "4. Intensity: the range is adjustable from 0 to 1.8W/cm2, and the step is 0.15W/cm?. Whenadjusting the output power, the effective sound intensity changes accordingly.\n"
      "5. When the ultrasound probe is not connected, the prompt message \"Ultrasound probe is notconnected!\" will appear, the ultrasound probe is recognized, and the prompt information disappears.\n"
      "6. When working for a long time, when the ultrasound probe is in a high temperature state, theword \"Over Temperature\" will appear, and the output will be stopped at the same time, and thetime will be in a countdown state. When the temperature of the probe drops to the normalworking temperature, the word \"Over Temperature\" will disappear. The probe continues tooutput.\n"
      "7. The icons   with \"+ -\" are gray to indicate that they are not selectable.\n"; // 输出功率

  static const String detailsTwo =
      "1.1. Choose a square magnetic pad or a circular magnetic pad according to the patient's condition.and properly connect the magnetic pad to the output interface of the pulse magnetic module.2. The default display frequency of the interface is 20 times/min, the intensity is 0, and the timeis 25 minutes.\n"
      "2. The default display frequency of the interface is 20 times/min, the intensity is 0, and the timeis 25 minutes.\n"
      "3.Adjust the frequency, time and intensity through the \"+ -\" keys.\n"
      "3.1 Intensity: adjustable from 0 to 5, step 1;\n"
      "3.2 Frequency: adjustable from 20 times/min to 80 times/min, step 10 times/min;\n"
      "3.3 Time: The range is adjustable from lmin to 99min, and the step is lmin.\n"
      "4. According to the patient's condition and the treatment site, choose the opposite or parallelplacement of the treatment pads.\n"
      "5. When the treatment time reaches the set value or stops manually, there will be a voice promptof\"Stop Pulse Magnetic Therapy\"\n"
      "6. Only after the square magnetic pad is activated, you can choose whether to enable the vibration function.\n"
      "7. The icons of\"+ -\" are gray to indicate that they are not selectable.";

//Intensity
}
