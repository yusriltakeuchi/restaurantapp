import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurantapp/ui/constant/constant.dart';

class IdleNoItemCenter extends StatelessWidget {
  final String? title;
  final Color? color;
  final bool useDeviceHeight;
  final String? iconPathSVG;
  final bool? useCenterText;
  final double? paddingTop;

  const IdleNoItemCenter({
    Key? key,
    @required this.title,
    this.color,
    this.useDeviceHeight = true,
    this.iconPathSVG,
    this.useCenterText = true,
    this.paddingTop = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth,
      height: useDeviceHeight ? deviceHeight / 2 : null,
      child: iconPathSVG == null
          ? useCenterText == true
              ? Center(
                  child: Text(
                    title ?? " ",
                    textAlign: TextAlign.center,
                    style: styleSubtitle.copyWith(
                      color: color ?? blackColor,
                      fontSize: setFontSize(36),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                    top: paddingTop!,
                  ),
                  child: Text(
                    title ?? " ",
                    textAlign: TextAlign.center,
                    style: styleSubtitle.copyWith(
                      color: color ?? blackColor,
                      fontSize: setFontSize(40),
                    ),
                  ),
                )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  iconPathSVG ?? "",
                  width: setWidth(deviceWidth),
                  height: deviceHeight * 0.3,
                ),
                Text(
                  title ?? " ",
                  textAlign: TextAlign.center,
                  style: styleSubtitle.copyWith(
                    color: color ?? blackColor,
                    fontSize: setFontSize(40),
                  ),
                )
              ],
            ),
    );
  }
}
