import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:restaurantapp/core/models/category/category_model.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/core/models/review/review_model.dart';
import 'package:restaurantapp/core/utils/navigation/navigation_utils.dart';
import 'package:restaurantapp/core/viewmodels/restaurant/restaurant_provider.dart';
import 'package:restaurantapp/gen/assets.gen.dart';
import 'package:restaurantapp/gen/fonts.gen.dart';
import 'package:restaurantapp/ui/constant/constant.dart';
import 'package:restaurantapp/ui/widgets/chip/chip_item.dart';
import 'package:restaurantapp/ui/widgets/idle/idle_item.dart';
import 'package:restaurantapp/ui/widgets/review/review_item.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantProvider(),
      child: Scaffold(
        body: Consumer<RestaurantProvider>(
          builder: (context, restaurantProv, _) {
            if (restaurantProv.restaurant == null && !restaurantProv.onSearch) {
              restaurantProv.getRestaurant(id);
              return const IdleLoadingCenter();
            }

            if (restaurantProv.restaurant == null && restaurantProv.onSearch) {
              return const IdleLoadingCenter();
            }

            if (restaurantProv.restaurant!.id.isEmpty) {
              return IdleNoItemCenter(
                title: "Restaurant not found",
                iconPathSVG: Assets.images.illustrationNotfound.path,
              );
            }

            return RestaurantDetailSliverBody(
              restaurant: restaurantProv.restaurant!,
            );
          },
        ),
      ),
    );
  }
}

class RestaurantDetailSliverBody extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantDetailSliverBody({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        body: RestaurantDetailContentBody(
          restaurant: restaurant,
        ),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: deviceHeight * 0.4,
              floating: false,
              pinned: true,
              title: Text(
                restaurant.name,
                style: styleTitle.copyWith(
                  fontSize: setFontSize(45),
                  color: blackColor,
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: grayColor.withOpacity(0.4),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => navigate.pop(),
                      borderRadius: BorderRadius.circular(12),
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ),
              flexibleSpace: _flexibleSpace(),
              backgroundColor: Colors.white,
            )
          ];
        });
  }

  Widget _flexibleSpace() {
    return FlexibleSpaceBar(
      centerTitle: true,
      collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Hero(
              tag: restaurant.id,
              child: Image.network(
                restaurant.image?.mediumResolution ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: -3,
            left: 0,
            right: 0,
            child: Container(
              height: setHeight(80),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Container(
                  width: deviceWidth * 0.12,
                  height: setHeight(15),
                  decoration: BoxDecoration(
                    color: grayColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(42),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantDetailContentBody extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantDetailContentBody({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RestaurantDetailInfoWidget(
            restaurant: restaurant,
          ),
          _RestaurantDetailMenuWidget(
            restaurant: restaurant,
          ),
          _RestaurantDetailReviewWidget(
            reviews: restaurant.reviews,
          )
        ],
      ),
    );
  }
}

class _RestaurantDetailReviewWidget extends StatelessWidget {
  final List<ReviewModel>? reviews;
  const _RestaurantDetailReviewWidget({
    Key? key,
    required this.reviews,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: setWidth(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review",
            style: styleTitle.copyWith(
              fontSize: setFontSize(38),
            ),
          ),
          SizedBox(
            height: setHeight(20),
          ),
          reviews!.isEmpty
            ? IdleNoItemCenter(
                title: "No review",
                iconPathSVG: Assets.images.illustrationNotfound.path,
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviews!.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {

                  final review = reviews?[index];
                  return ReviewItem(
                    review: review!
                  );
                },
              )
        ],
      ),
    );
  }
}

class _RestaurantDetailCategoryWidget extends StatelessWidget {
  final List<CategoryModel>? categories;
  const _RestaurantDetailCategoryWidget({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _menuItems(
      title: "Category",
      iconPath: Assets.icons.iconFood.path,
      items: categories != null ? categories!.map((e) => e.name).toList() : [],
    );
  }

  Widget _menuItems({
    required String title,
    required String iconPath,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: styleTitle.copyWith(
            fontSize: setFontSize(35),
          ),
        ),
        SizedBox(
          height: setHeight(10),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items
                .asMap()
                .map((index, value) => MapEntry(
                    index,
                    ChipItem(
                      name: value,
                      isFirst: false,
                      onClick: () {},
                    )))
                .values
                .toList(),
          ),
        )
      ],
    );
  }
}

class _RestaurantDetailMenuWidget extends StatelessWidget {
  final RestaurantModel restaurant;
  const _RestaurantDetailMenuWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: setHeight(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: setWidth(40),
            ),
            child: Text(
              "Menus",
              style: styleTitle.copyWith(
                fontSize: setFontSize(38),
              ),
            ),
          ),
          SizedBox(
            height: setHeight(10),
          ),
          _menuItems(
            title: "Foods",
            iconPath: Assets.icons.iconFood.path,
            items: restaurant.menus != null
                ? restaurant.menus!.foods.map((e) => e.name).toList()
                : [],
          ),
          SizedBox(
            height: setHeight(20),
          ),
          _menuItems(
            title: "Drinks",
            iconPath: Assets.icons.iconDrink.path,
            items: restaurant.menus != null
                ? restaurant.menus!.drinks.map((e) => e.name).toList()
                : [],
          )
        ],
      ),
    );
  }

  Widget _menuItems({
    required String title,
    required String iconPath,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: setWidth(40),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: setWidth(40),
                height: setHeight(40),
                color: primaryColor,
              ),
              SizedBox(
                width: setWidth(10),
              ),
              Text(
                title,
                style: styleTitle.copyWith(
                  fontSize: setFontSize(35),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: setHeight(10),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items
                .asMap()
                .map((index, value) => MapEntry(
                    index,
                    ChipItem(
                      name: value,
                      isFirst: index == 0,
                      onClick: () {},
                    )))
                .values
                .toList(),
          ),
        )
      ],
    );
  }
}

class _RestaurantDetailInfoWidget extends StatefulWidget {
  final RestaurantModel restaurant;
  const _RestaurantDetailInfoWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<_RestaurantDetailInfoWidget> createState() =>
      _RestaurantDetailInfoWidgetState();
}

class _RestaurantDetailInfoWidgetState
    extends State<_RestaurantDetailInfoWidget> {
  bool viewMore = false;
  void toggleViewMore() {
    setState(() {
      viewMore = !viewMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: setWidth(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.restaurant.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: styleTitle.copyWith(
              fontSize: setFontSize(55),
            ),
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Row(
            children: [
              RatingBar(
                initialRating: widget.restaurant.rating,
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
                " (${widget.restaurant.rating.toString()})",
                style: styleSubtitle.copyWith(
                  fontSize: setFontSize(30),
                  color: grayDarkColor,
                ),
              )
            ],
          ),
          SizedBox(
            height: setHeight(10),
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
                  (widget.restaurant.address!.isNotEmpty ? "${widget.restaurant.address}, " : "") + widget.restaurant.city,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: styleSubtitle.copyWith(
                    fontSize: setFontSize(35),
                    color: grayDarkColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: setHeight(10),
            ),
            child: Divider(
              color: blackColor.withOpacity(0.5),
            ),
          ),
          _RestaurantDetailCategoryWidget(
            categories: widget.restaurant.categories,
          ),
          SizedBox(
            height: setHeight(10),
          ),
          Text(
            "Description",
            style: styleTitle.copyWith(
              fontSize: setFontSize(38),
            ),
          ),
          SizedBox(
            height: setHeight(10),
          ),
          InkWell(
            onTap: () => toggleViewMore(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: viewMore == true
                      ? widget.restaurant.description
                      : "${widget.restaurant.description.substring(0, widget.restaurant.description.length ~/ 2)}...",
                  style: styleSubtitle.copyWith(
                    fontSize: setFontSize(38),
                    color: blackColor,
                    fontFamily: FontFamily.nunitoSans,
                  ),
                ),
                TextSpan(
                  text: viewMore == false ? "View More" : "",
                  style: styleTitle.copyWith(
                    fontSize: setFontSize(38),
                    color: primaryColor,
                    fontFamily: FontFamily.nunitoSans,
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
