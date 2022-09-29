import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/ui/constant/constant.dart';

class RestaurantItem extends StatelessWidget {
  final RestaurantModel restaurant;
  final VoidCallback onClick;
  final VoidCallback? onClickFavorite;
  final bool isFavorite;
  const RestaurantItem({
    Key? key,
    required this.restaurant,
    required this.onClick,
    this.onClickFavorite,
    this.isFavorite = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: setHeight(20),
          horizontal: setWidth(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Hero(
                    tag: restaurant.id,
                    child: Container(
                      width: setWidth(200),
                      height: setHeight(
                        isSmallPhoneHeight(context) ? 180 : 150,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(
                            restaurant.image?.mediumResolution ?? "",
                          ),
                          fit: BoxFit.cover,
                        ),
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
                          restaurant.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: styleTitle.copyWith(
                            fontSize: setFontSize(40),
                          ),
                        ),
                        SizedBox(
                          height: setHeight(5),
                        ),
                        Row(
                          children: [
                            RatingBar(
                              initialRating: restaurant.rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              itemCount: 5,
                              itemSize: 13,
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                half: const Icon(
                                  Icons.star_half,
                                  color: Colors.amber,
                                ),
                                empty: const Icon(
                                  Icons.star_border,
                                  color: Colors.amber,
                                ),
                              ),
                              onRatingUpdate: (rating) {
                                debugPrint(rating.toString());
                              },
                            ),
                            Text(
                              " (${restaurant.rating.toString()})",
                              style: styleSubtitle.copyWith(
                                fontSize: setFontSize(30),
                                color: grayDarkColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: setHeight(5),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: primaryColor,
                              size: 15,
                            ),
                            SizedBox(
                              width: setWidth(5),
                            ),
                            Expanded(
                              child: Text(
                                restaurant.city,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: styleSubtitle.copyWith(
                                  fontSize: setFontSize(35),
                                  color: grayDarkColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () => onClickFavorite != null ? onClickFavorite!() : null,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: setWidth(20),
                  vertical: setHeight(20),
                ),
                child: AnimatedCrossFade(
                  firstChild: Icon(
                    Icons.favorite,
                    color: primaryColor,
                    size: 20,
                  ),
                  secondChild: Icon(
                    Icons.favorite_border,
                    color: primaryColor,
                    size: 20,
                  ),
                  crossFadeState: isFavorite
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
