import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/assets.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/domain/entities/product/product.dart';

import '../../application/favourites_cubit/favourites_cubit.dart';
import '../../data/models/product/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  PageController _pageController = PageController();
  ScrollController _listController = ScrollController();
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _selectedPageIndex = _pageController.page?.round() ?? 0;
        _listController.animateTo(
          _selectedPageIndex * 116.0,
          // Adjust this value based on your item width and margin
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppDimensions.normalize(30)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: Space.all(.9, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                Text(
                  "PRODUCT DETAILS",
                  style: AppText.b2b,
                ),
                SvgPicture.asset(
                  Assets.Cart,
                  color: AppColors.CommonBlue,
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: Space.all(.9, .7),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppText.h2b,
              ),
              Space.yf(.6),
              Text(
                "${widget.product.priceTags.first.price} \$",
                style: AppText.h3b?.copyWith(color: AppColors.CommonBlue),
              ),
              Space.yf(.6),
              Row(
                children: [
                  Text(
                    "Category Name : ",
                    style: AppText.h3,
                  ),
                  Text(
                    widget.product.categories.first.name.toUpperCase(),
                    style: AppText.h3b?.copyWith(color: AppColors.CommonBlue),
                  ),
                ],
              ),
              Space.yf(1.1),
              Container(
                height: AppDimensions.normalize(130),
                color: AppColors.LightGrey,
                padding: Space.all(0, 1),
                child: PageView.builder(
                  itemCount: widget.product.images.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedPageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.network(
                      widget.product.images[index],
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
              Container(
                height: AppDimensions.normalize(50),
                color: AppColors.LightGrey,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _listController,
                  itemCount: widget.product.images.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        padding: Space.all(.2, .2),
                        decoration: BoxDecoration(
                          color: AppColors.LightGrey,
                          border: Border.all(
                            color: _selectedPageIndex == index
                                ? AppColors
                                    .CommonBlue // Change this to your desired color
                                : Colors.transparent,
                            width: 5.0,
                          ),
                        ),
                        child: Image.network(
                          widget.product.images[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Space.yf(1.2),
              Text(
                "Description",
                style: AppText.h3b,
              ),
              Space.yf(.5),
              Text(
                widget.product.description,
                style:
                    AppText.b2?.copyWith(height: AppDimensions.normalize(.6)),
              ),
              Space.yf(2),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.LightGrey,
        height: AppDimensions.normalize(33),
        padding: Space.all(.7, .9),
        margin: Space.vf(1.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      width: AppDimensions.normalize(17),
                      color: AppColors.CommonBlue,
                      child: Center(
                        child: SvgPicture.asset(Assets.Minus,
                            color: Colors.white, height: 3),
                      ),
                    ),
                  ),
                  Container(
                    padding: Space.hf(2),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        "1",
                        style: AppText.h3b,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: AppDimensions.normalize(17),
                      color: AppColors.CommonBlue,
                      child: Center(
                        child: SvgPicture.asset(Assets.Plus,
                            color: Colors.white, height: 13),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: (){
                    final productToAdd = ProductModel.fromEntity(
                     widget.product
                    );

                    context.read<FavouritesCubit>().addToFavourites(productToAdd);
                  },
                  child: Text(
                    "Add to cart",
                    style: AppText.h3b?.copyWith(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
