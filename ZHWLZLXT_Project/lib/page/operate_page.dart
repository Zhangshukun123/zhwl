import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OperatePage extends StatefulWidget {
  const OperatePage({Key? key}) : super(key: key);

  @override
  State<OperatePage> createState() => _OperatePageState();
}

class _OperatePageState extends State<OperatePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 10.h,left: 26.w,right: 26.w,bottom: 70.h),
          child: const SingleChildScrollView(
            child: Text('    综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。    综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超    综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超    综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超    综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超声波模块、脉冲磁模块、冲击波模块、肌电生物反馈 模块、红外偏振光模块、电疗模块（痉挛肌+经皮神经+神经肌肉+中频/干扰电）六个治疗模块。综合物理治疗系统包含超',
                style: TextStyle(fontSize: 18,color: Color(0xFF999999)),
            ),

          ),
        ),
      ),
    );
  }
}
