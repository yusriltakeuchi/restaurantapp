import 'package:flutter/material.dart';

import 'package:restaurantapp/core/models/review/review_model.dart';
import 'package:restaurantapp/ui/constant/constant.dart';

class ReviewItem extends StatelessWidget {
  final ReviewModel review;
  const ReviewItem({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: setHeight(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: grayColor.withOpacity(0.4),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: setWidth(20),
                    vertical: setHeight(20),
                  ),
                  child: Icon(
                    Icons.person,
                    color: grayColor,
                  ),
                ),
              ),
              SizedBox(
                width: setWidth(20),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleTitle.copyWith(
                        fontSize: setFontSize(35),
                      ),
                    ),
                    SizedBox(
                      height: setHeight(10),
                    ),
                    Text(
                      review.date,
                      style: styleSubtitle.copyWith(
                        fontSize: setFontSize(30),
                        color: grayDarkColor,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: setHeight(30),
          ),
          Text(
            review.review,
            style: styleSubtitle.copyWith(
              fontSize: setFontSize(35),
              color: blackColor,
            ),
          )
        ],
      ),
    );
  }
}
