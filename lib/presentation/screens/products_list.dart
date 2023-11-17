import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piiicks/configs/configs.dart';

import 'package:shimmer/shimmer.dart';

import '../../application/products_bloc/product_bloc.dart';
import '../../configs/app_dimensions.dart';
import '../../core/constant/assets.dart';
import '../../core/constant/colors.dart';
import '../../core/error/failures.dart';
import '../../core/router/app_router.dart';
import '../widgets/product_item.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final ScrollController scrollController = ScrollController();

  void _scrollListener() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double scrollPercentage = 0.7;
    if (currentScroll > (maxScroll * scrollPercentage)) {
      if (context.read<ProductBloc>().state is ProductLoaded) {
        context.read<ProductBloc>().add(const GetMoreProducts());
      }
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: AppDimensions.normalize(24)),
        child:
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          //Result Empty and No Error
          if (state is ProductLoaded && state.products.isEmpty) {
            return const Center(
              child: Text(
                "Products not found!",
              ),
            );
          }
          //Error and no preloaded data
          if (state is ProductError && state.products.isEmpty) {
            if (state.failure is NetworkFailure) {
              return const Center(
                child: Text(
                  "Network failure\nTry again!",
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.failure is ServerFailure)
                  const Text("Server Failure"),
                if (state.failure is CacheFailure)
                  const Text("Products not found!"),
                IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                )
              ],
            );
          }
          return RefreshIndicator(
            onRefresh: () async {},
            child: Column(
              children: [
                Padding(
                  padding: Space.h1!,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed(AppRouter.search);
                          },
                          child: const Icon(Icons.search)),
                      Text(
                        "All Products".toUpperCase(),
                        style: AppText.b1b?.copyWith(color: AppColors.GreyText),
                      ),
                      const Icon(Icons.shopping_basket_outlined)
                    ],
                  ),
                ),
                Space.y1!,
                Container(
                  color: AppColors.LightGrey,
                  height: AppDimensions.normalize(25),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Assets.SortIcon),
                            Space.x!,
                            Text("Sort by",
                                style: AppText.b1
                                    ?.copyWith(color: AppColors.GreyText))
                          ],
                        ),
                        Container(
                          width: 1,
                          margin: Space.vf(.5),
                          color: Colors.grey.shade400,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(Assets.FilterIcon),
                            Space.x!,
                            Text("Filter",
                                style: AppText.b1
                                    ?.copyWith(color: AppColors.GreyText))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Space.y!,
                Expanded(
                  child: GridView.builder(
                    padding: Space.all(1),
                    itemCount: state.products.length +
                        ((state is ProductLoading) ? 10 : 0),
                    controller: scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 6,
                    ),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (state.products.length > index) {
                        return ProductCard(
                          product: state.products[index],
                        );
                      }
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade100,
                        highlightColor: Colors.white,
                        child: const ProductCard(),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
