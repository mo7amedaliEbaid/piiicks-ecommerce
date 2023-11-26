import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/configs/app_dimensions.dart';
import 'package:piiicks/configs/app_typography.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/constant/assets.dart';
import 'package:piiicks/core/constant/colors.dart';
import 'package:piiicks/core/router/app_router.dart';
import 'package:piiicks/data/models/category/category_model.dart';
import 'package:piiicks/data/models/product/price_tag_model.dart';
import 'package:piiicks/domain/entities/product/product.dart';
import 'package:piiicks/presentation/widgets/quantity_row.dart';

import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../application/cart_bloc/cart_bloc.dart';
import '../../application/wishlist_cubit/wishlist_cubit.dart';
import '../../core/enums/enums.dart';
import '../../data/models/product/product_model.dart';
import '../../domain/entities/cart/cart_item.dart';
import '../../domain/entities/product/price_tag.dart';
import '../widgets/dots_indicator.dart';
import '../widgets/lading_shimmer.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  PageController _pageController = PageController();
  ScrollController _listController = ScrollController();
  int _selectedPageIndex = 0;
  late PriceTag _selectedPriceTag;

  @override
  void initState() {
    super.initState();
    _selectedPriceTag = widget.product.priceTags.first;
    _pageController.addListener(() {
      setState(() {
        _selectedPageIndex = _pageController.page?.round() ?? 0;
        _listController.animateTo(
          _selectedPageIndex * 116.0,
          // Adjust this value based on your item width and margin
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    bool isProductInWishlist =
        context.read<WishlistCubit>().isInWishlist(widget.product.id);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppDimensions.normalize(20)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: Space.all(.9, 0),
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
                  color: AppColors.CommonCyan,
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
                style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
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
                    style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                  ),
                ],
              ),
              Space.yf(1.1),
              Stack(
                children: [
                  Container(
                    height: AppDimensions.normalize(130),
                    color: AppColors.LightGrey,
                    padding: Space.all(0, 1),
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: widget.product.images.length,
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _selectedPageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: AppDimensions.normalize(40)),
                                      child: Dialog(
                                        insetPadding: Space.hf(1.3),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            SizedBox(
                                              height:
                                                  AppDimensions.normalize(170),
                                              width: double.maxFinite,
                                              child: PhotoViewGallery(
                                                pageController:
                                                    PageController(),
                                                scrollPhysics:
                                                    const BouncingScrollPhysics(),
                                                backgroundDecoration:
                                                    BoxDecoration(
                                                  color: Colors.grey.shade400,
                                                ),
                                                pageOptions: [
                                                  PhotoViewGalleryPageOptions(
                                                    imageProvider: NetworkImage(
                                                        widget.product
                                                            .images[index]),
                                                    minScale:
                                                        PhotoViewComputedScale
                                                            .covered,
                                                    maxScale:
                                                        PhotoViewComputedScale
                                                                .covered *
                                                            2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: -AppDimensions.normalize(18),
                                              right:
                                                  -AppDimensions.normalize(4),
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                icon: SvgPicture.asset(
                                                  Assets.Close,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Hero(
                                tag: widget.product.id,
                                child: CachedNetworkImage(
                                  fit: BoxFit.contain,
                                  imageUrl: widget.product.images[index],
                                  placeholder: (context, url) =>
                                      placeholderShimmer(),
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: AppDimensions.normalize(.1),
                          left: 0,
                          right: 0,
                          child: Dotsindicator(
                            dotsIndex: _pageController.hasClients
                                ? _pageController.page?.round()
                                : 0,
                            dotsCount: widget.product.images.length,
                            activeColor: AppColors.CommonCyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                          duration: const Duration(milliseconds: 500),
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
                                    .CommonCyan // Change this to your desired color
                                : Colors.transparent,
                            width: 5.0,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.product.images[index],
                          placeholder: (context, url) => placeholderShimmer(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: AppColors.LightGrey,
                margin: Space.v,
                padding: Space.all(.5, .5),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<WishlistCubit>().addToWishlist(
                            ProductModel.fromEntity(widget.product));
                      },
                      child: Row(
                        children: [
                          isProductInWishlist
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border),
                          Space.xf(.3),
                          Text(
                            "Add to wishlist",
                            style: AppText.h3,
                          )
                        ],
                      ),
                    ),
                    Space.xf(.8),
                    Container(
                      height: AppDimensions.normalize(10),
                      width: 1,
                      color: Colors.grey,
                    ),
                    Space.xf(2.5),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.Share,
                          height: AppDimensions.normalize(10),
                        ),
                        Space.xf(.7),
                        Text(
                          "Share",
                          style: AppText.h3,
                        )
                      ],
                    )
                  ],
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
              Space.yf(1.2),
              Text(
                "Prices",
                style: AppText.h3b,
              ),
              Space.yf(.5),
              Wrap(
                children: widget.product.priceTags
                    .map((priceTag) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPriceTag = priceTag;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: _selectedPriceTag.id == priceTag.id
                                    ? 2.7
                                    : 1.0,
                                color: AppColors.CommonCyan,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                            ),
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(right: 7, bottom: 5),
                            child: Column(
                              children: [
                                Text(priceTag.name),
                                Text("${priceTag.price} \$"),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.LightGrey,
        height: AppDimensions.normalize(33),
        padding: Space.all(.7, .9),
        margin: EdgeInsets.only(
            top: AppDimensions.normalize(1),
            bottom: AppDimensions.normalize(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: QuantityRow(17, 2)),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(AddProduct(
                        cartItem: CartItem(
                            product: widget.product,
                            priceTag: _selectedPriceTag)));
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: const Color(0xfff6f6f6),
                      constraints: BoxConstraints(
                          minHeight: AppDimensions.normalize(120),
                          maxWidth: double.infinity),
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: AppDimensions.normalize(12),
                                left: AppDimensions.normalize(8),
                                right: AppDimensions.normalize(8),
                                bottom: AppDimensions.normalize(5)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "CONTINUE",
                                  style: AppText.h3b,
                                ),
                                Space.yf(1),
                                const Text(
                                    "Lorem Ipsum is simply dummy text of the"),
                                Space.yf(.2),
                                const Text(
                                    "printing and typesetting industry."),
                                Space.yf(2),
                                SizedBox(
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<NavigationCubit>()
                                          .updateTab(NavigationTab.cartTab);
                                      Navigator.popAndPushNamed(
                                          context, AppRouter.mainscreen);
                                    },
                                    child: Container(
                                      padding: Space.vf(.8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.CommonCyan)),
                                      child: Center(
                                          child: Text(
                                        "Proceed to Cart",
                                        style: AppText.h3b?.copyWith(
                                            color: AppColors.CommonCyan),
                                      )),
                                    ),
                                  ),
                                ),
                                Space.yf(1.5),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<NavigationCubit>()
                                          .updateTab(NavigationTab.productsTap);
                                      Navigator.popAndPushNamed(
                                          context, AppRouter.mainscreen);
                                    },
                                    child: Text(
                                      "Continue Shopping",
                                      style: AppText.h3b
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
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
