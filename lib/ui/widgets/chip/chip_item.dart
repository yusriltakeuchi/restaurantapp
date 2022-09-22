import 'package:flutter/material.dart';
import 'package:restaurantapp/ui/constant/constant.dart';

class ChipItem extends StatelessWidget {
  final String name;
  final bool isFirst;
  final double leftMargin;
  final VoidCallback onClick;
  const ChipItem({
    Key? key,
    required this.name,
    required this.isFirst,
    this.leftMargin = 40,
    required this.onClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: setWidth(20),
        top: setHeight(20),
        bottom: setHeight(20),
        left: isFirst ? setWidth(leftMargin) : 0,
      ),
      decoration: BoxDecoration(
        color: grayColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onClick(),
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: setWidth(30),
              vertical: setHeight(10),
            ),
            child: Text(
              name,
              style: styleTitle.copyWith(
                fontSize: setFontSize(35),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
