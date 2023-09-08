//读写指令
class BYTE00_RW {
  static const String B01 = "01";
  static const String B02 = "02";
}

//功能模块
class BYTE01_MD {
  static const String B00 = "00"; //00-握手
  static const String B01 = "01"; //01-光疗
  static const String B02 = "02"; //02-磁疗
  static const String B03 = "03"; //03-1M超声
  static const String B04 = "04"; //04-3M超声
  static const String B05 = "05"; //05-痉挛肌
  static const String B06 = "06"; //06-经皮神经
  static const String B07 = "07"; //07-神经肌肉
  static const String B08 = "08"; //08-中频干扰电
}

class BYTE02_CN {
  static const String B01 = "0x10"; //超声1Mhz输出通道 //李建成09.06提出修改 跟文档有区别
  static const String B03 = "0x10"; //超声3Mhz输出通道  //李建成09.06提出修改 跟文档有区别
  static const String B61 = "0601"; //电疗经皮神经输出通道1
  static const String B62 = "0602"; //电疗经皮神经输出通道2
  static const String B71 = "0701"; //电疗神经肌肉输出通道1
  static const String B72 = "0702"; //电疗神经肌肉输出通道2
  static const String B81 = "0801"; //电疗中频干扰电输出通道1
  static const String B82 = "0802"; //电疗中频干扰电输出通道2
}

class BYTE03_STOP {
  //通道启停
  static const String B00 = "00"; //00-无效
  static const String B01 = "01"; //01-启动
  static const String B02 = "02"; //02-停止
  static const String B03 = "03"; //03-暂停
}

class BYTE04_PT {
  //工作模式
  static const String B01 = "01"; //01-连续模式1；
  static const String B02 = "02"; //02-断续模式1；
  static const String B03 = "03"; //03-断续模式2；
  static const String B04 = "04"; //04-断续模式3；

//光疗 超声
  static const String B_T_01 = "连续模式1";
  static const String B_T_02 = "断续模式1";
  static const String B_T_03 = "断续模式2";
  static const String B_T_04 = "断续模式3";

  //经皮神经
  static const String S_J_01 = "连续输出";
  static const String S_J_02 = "慢速输出";
  static const String S_J_03 = "快速输出";


  //神经肌肉
  static const String S_P_01 = "完全失神经";
  static const String S_P_02 = "部分失神经";

  static String Value =
      ""; //频率：20-80次/min,步进10   脉冲周期：1s～2s可调，步进为0.1s  工作模式：01- 连续输出，02-慢速输出，03-快速输出；
}

class BYTE05_TIME {
  //工作时间
  static String Value = "";
}

class BYTE06_ST {
  //强度
  static String Value = "";
}

class BYTE07_FQ {
  //频率 脉宽 震动开关
  static String Value = "";
}

class BYTE08_FQ {
  static String Value = "";
}

class BYTE09_FQ {
  static String Value = "";
}

class BYTE10_FQ {
  static String Value = "";
}

class PortData {
  static const String FH = "AB BA"; //帧头
  static const String FE = "CRCH CRCL"; //帧尾
}
