import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/application/notifications_cubit/notifications_cubit.dart';
import 'package:piiicks/application/products_bloc/product_bloc.dart';
import 'package:piiicks/application/wishlist_cubit/wishlist_cubit.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/presentation/widgets/lading_shimmer.dart';
import 'package:piiicks/presentation/widgets/square_product_item.dart';
import 'package:piiicks/presentation/widgets/top_row.dart';

import '../../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../../application/categories_bloc/category_bloc.dart';
import '../../application/filter_cubit/filter_cubit.dart';
import '../../core/constant/assets.dart';
import '../../core/constant/colors.dart';
import '../../core/enums/enums.dart';
import '../widgets/dots_indicator.dart';
import '../widgets/square_category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 1;
  PageController _pageController = PageController();

  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage);
    context.read<FilterCubit>().reset();
    context.read<WishlistCubit>().loadWishlist();
    context
        .read<ProductBloc>()
        .add(GetProducts(context.read<FilterCubit>().state));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: AppDimensions.normalize(22)),
        child: Padding(
          padding: Space.h1!,
          child: Column(
            children: [
              TopRow(isFromHome: true, context: context),
              Space.yf(.2),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppDimensions.normalize(110),
                        child: Stack(
                          children: [
                            PageView.builder(
                                controller: _pageController,
                                onPageChanged: (pos) {
                                  setState(() {
                                    currentPage = pos;
                                  });
                                },
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return SvgPicture.asset(
                                    AppAssets.PiiicksIcon,
                                    fit: BoxFit.cover,
                                  );
                                }),
                            Positioned(
                              bottom: AppDimensions.normalize(2),
                              left: 0,
                              right: 0,
                              child: Dotsindicator(
                                dotsIndex: _pageController.hasClients
                                    ? _pageController.page?.round()
                                    : 1,
                                dotsCount: 3,
                                activeColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: AppDimensions.normalize(15),
                            bottom: AppDimensions.normalize(7)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FEATURED CATEGORIES",
                              style: AppText.h2b
                                  ?.copyWith(color: AppColors.CommonCyan),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<NavigationCubit>()
                                    .updateTab(NavigationTab.categoriesTab);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "VIEW ALL",
                                    style: AppText.b2b
                                        ?.copyWith(color: AppColors.CommonCyan),
                                  ),
                                  const Icon(
                                    Icons.double_arrow,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: AppDimensions.normalize(100),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  (state is CategoryLoading)
                                      ? const SquareCategoryItem()
                                      : SquareCategoryItem(
                                          category: state.categories[index],
                                        ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: AppDimensions.normalize(3.5),
                            bottom: AppDimensions.normalize(7)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FEATURED PRODUCTS",
                              style: AppText.h2b
                                  ?.copyWith(color: AppColors.CommonCyan),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<NavigationCubit>()
                                    .updateTab(NavigationTab.productsTap);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "VIEW ALL",
                                    style: AppText.b2b
                                        ?.copyWith(color: AppColors.CommonCyan),
                                  ),
                                  Icon(
                                    Icons.double_arrow,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: AppDimensions.normalize(100),
                            child: (state is ProductError)
                                ? Text(
                                    "Error occured While Loading Products",
                                    style: AppText.b2b,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : (state is ProductEmpty)
                                    ? Text(
                                        "No Featured Products Available",
                                        style: AppText.b2b,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 3,
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder: (context, index) => (state
                                                is ProductLoading)
                                            ? const SquareProductItem()
                                            : state.products.isNotEmpty
                                                ? SquareProductItem(
                                                    product:
                                                        state.products[index],
                                                  )
                                                : LoadingShimmer(
                                                    isSquare: true),
                                      ),
                          );
                        },
                      ),
                      Space.y1!,
                      Image.asset(AppAssets.HomePng),
                      Space.y2!
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
