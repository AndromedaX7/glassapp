import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

num dw(num design) {
  return ScreenUtil().setWidth(design);
}

num dh(num design) {
  return ScreenUtil().setHeight(design);
}

num sp(num design) {
  return ScreenUtil().setSp(design);
}

num sp2(num design, bool allowFontScalingSelf) {
  return ScreenUtil().setSp(design, allowFontScalingSelf: allowFontScalingSelf);
}

initDisplay(BuildContext context) {
  ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: false);
}
