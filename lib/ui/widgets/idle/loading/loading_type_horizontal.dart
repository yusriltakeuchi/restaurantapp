import 'package:flutter/material.dart';
import 'package:restaurantapp/ui/constant/constant.dart';

class LoadingTypeHorizontal extends StatelessWidget {
  final int length;
  const LoadingTypeHorizontal({
    Key? key,
    this.length = 7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            length,
            (i) => Container(
              width: setWidth(150),
              height: setHeight(40),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: grayColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
