import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/app.dart';
import 'package:piiicks/configs/configs.dart';
import '../../application/filter_cubit/filter_cubit.dart';
import '../../application/products_bloc/product_bloc.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_typography.dart';
import '../../core/constant/colors.dart';
import '../../core/error/failures.dart';
import '../../data/models/product/filter_params_model.dart';
import '../widgets/product_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController scrollController = ScrollController();
  String value = '';

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
    App.init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppDimensions.normalize(24)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimensions.normalize(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                Space.xf(6),
                Text(
                  "SEARCH",
                  style: AppText.b1b?.copyWith(color: AppColors.GreyText),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<FilterCubit, FilterProductParams>(
        builder: (context, filterState) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimensions.normalize(5)),
            child: Column(
              children: [
                Space.yf(1.2),
                Row(
                  children: [
                    Container(
                      height: AppDimensions.normalize(20),
                      width: AppDimensions.normalize(95),
                      padding: Space.h1,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: TextField(
                          controller: context
                              .read<FilterCubit>()
                              .productsSearchController,
                          onChanged: (val) => setState(() {}),
                          onSubmitted: (val) {
                            setState(() {
                              value = val;
                            });
                            context.read<ProductBloc>().add(
                                GetProducts(FilterProductParams(keyword: val)));
                          },
                          cursorColor: AppColors.CommonBlue,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Here",
                              hintStyle: AppText.b1
                                  ?.copyWith(fontWeight: FontWeight.w300)),
                        ),
                      ),
                    ),
                    Space.x!,
                    Flexible(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              value = context
                                  .read<FilterCubit>()
                                  .productsSearchController
                                  .text
                                  .toString()
                                  .trim();
                            });
                            context.read<ProductBloc>().add(GetProducts(
                                FilterProductParams(keyword: value)));
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStatePropertyAll(
                              Size(
                                AppDimensions.normalize(42),
                                AppDimensions.normalize(20),
                              ),
                            ),
                          ),
                          child: Text(
                            "Search",
                            style: AppText.h3b?.copyWith(color: Colors.white),
                          )),
                    ),
                  ],
                ),
                Space.yf(1.5),
                context
                        .read<FilterCubit>()
                        .productsSearchController
                        .text
                        .isEmpty
                    ? SizedBox.shrink()
                    : Row(
                        children: [
                          Text(
                            "Search Results for ",
                            style: AppText.h3,
                          ),
                          Text(
                            "' $value '",
                            style: AppText.h3b,
                          ),
                        ],
                      ),
                Space.yf(2),
                context
                        .read<FilterCubit>()
                        .productsSearchController
                        .text
                        .isEmpty
                    ? const SizedBox.shrink()
                    : Expanded(
                        child: BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                            //Result Empty and No Error
                            if (state is ProductLoaded &&
                                state.products.isEmpty) {
                              return Center(
                                child: Container(
                                  height: AppDimensions.normalize(50),
                                  width: AppDimensions.normalize(120),
                                  decoration: const BoxDecoration(
                                      color: AppColors.LightGrey),
                                  child: Center(
                                    child: Padding(
                                      padding: Space.v2!,
                                      child: Column(
                                        children: [
                                          Text(
                                            "NO RESULT FOUND",
                                            style: AppText.h3b?.copyWith(
                                                color: AppColors.CommonBlue),
                                          ),
                                          Space.yf(),
                                          const Text(
                                              "There is no such product"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            //Error and no preloaded data
                            if (state is ProductError &&
                                state.products.isEmpty) {
                              if (state.failure is NetworkFailure) {
                                return const Center(
                                  child: Text("Network Error"),
                                );
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (state.failure is ServerFailure)
                                    const Text("Products not found!"),
                                  if (state.failure is CacheFailure)
                                    const Text("Products not found!"),
                                  IconButton(
                                      onPressed: () {
                                        context.read<ProductBloc>().add(
                                            GetProducts(FilterProductParams(
                                                keyword: context
                                                    .read<FilterCubit>()
                                                    .productsSearchController
                                                    .text)));
                                      },
                                      icon: const Icon(Icons.refresh)),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  )
                                ],
                              );
                            }
                            return GridView.builder(
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
                                return const ProductCard();
                              },
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
