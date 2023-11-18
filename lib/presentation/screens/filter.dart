import 'package:flutter/material.dart';
import 'package:piiicks/core/constant/colors.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool is_categories_list_Visible = false;
  bool is_price_range_visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 150),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    is_categories_list_Visible = !is_categories_list_Visible;
                  });
                },
                child: Container(
                  height: 40,
                  color: AppColors.LightGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Category"), Icon(Icons.add)],
                  ),
                ),
              ),
              Visibility(
                  visible: is_categories_list_Visible,
                  child: Container(
                    height: 100,
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Text("catname"),
                        Text("catname"),
                        Text("catname"),
                        Text("catname"),
                      ],
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  setState(() {
                    is_price_range_visible = !is_price_range_visible;
                  });
                },
                child: Container(
                  height: 40,
                  color: AppColors.LightGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Category"), Icon(Icons.add)],
                  ),
                ),
              ),
              Visibility(
                  visible: is_price_range_visible,
                  child: Container(
                    height: 100,
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Text("catname"),
                        Text("catname"),
                        Text("catname"),
                        Text("catname"),
                      ],
                    ),
                  )),
              Text("hhhhhhhhhhhhhhhhhhhh")
            ],
          ),
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/categories_bloc/category_bloc.dart';
import '../../application/filter_cubit/filter_cubit.dart';
import '../../application/products_bloc/product_bloc.dart';
import '../../data/models/product/filter_params_model.dart';
import '../widgets/input_form_button.dart';
import '../widgets/range_slider.dart';


class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FilterCubit>().reset();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 10,
            ),
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, categoryState) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoryState.categories.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemBuilder: (context, index) =>
                    Row(
                      children: [
                        Text(
                          categoryState.categories[index].name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        BlocBuilder<FilterCubit, FilterProductParams>(
                          builder: (context, filterState) {
                            return Checkbox(
                              value: filterState.categories
                                  .contains(categoryState.categories[index]) ||
                                  filterState.categories.isEmpty,
                              onChanged: (bool? value) {
                                context.read<FilterCubit>().updateCategory(
                                    category: categoryState.categories[index]);
                              },
                            );
                          },
                        )
                      ],
                    ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Price Range",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<FilterCubit, FilterProductParams>(
            builder: (context, state) {
              return RangeSliderExample(
                initMin: state.minPrice,
                initMax: state.maxPrice,
              );
            },
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Builder(builder: (context) {
            return InputFormButton(
              color: Colors.black87,
              onClick: () {
                context
                    .read<ProductBloc>()
                    .add(GetProducts(context
                    .read<FilterCubit>()
                    .state));
                Navigator.of(context).pop();
              },
              titleText: 'Continue',
            );
          }),
        ),
      ),
    );
  }
}*/
