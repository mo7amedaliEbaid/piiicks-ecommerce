import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/category/category.dart';
import '../../data/models/product/filter_params_model.dart';

class FilterCubit extends Cubit<FilterProductParams> {
  final TextEditingController productsSearchController = TextEditingController();
  FilterCubit() : super(const FilterProductParams());

  bool isSelectedCategory(Category category) {
    return state.categories.contains(category);
  }

  void update({
    String? keyword,
    List<Category>? categories,
    Category? category,
  }) {
    List<Category> updatedCategories = [];
    if (category != null) {
      updatedCategories.add(category);
    } else if (categories != null) {
      updatedCategories.addAll(categories);
    } else {
      updatedCategories.addAll(state.categories);
    }
    emit(FilterProductParams(
      keyword: keyword ?? state.keyword,
      categories: updatedCategories,
    ));
  }

  void updateCategory({
    required Category category,
  }) {
    List<Category> updatedCategories = [];
    updatedCategories.addAll(state.categories);
    if (updatedCategories.contains(category)) {
      updatedCategories.remove(category);
    } else {
      updatedCategories.add(category);
    }
    emit(state.copyWith(
      categories: updatedCategories,
    ));
  }

  void updateRange(double min, double max) => emit(state.copyWith(
        minPrice: min,
        maxPrice: max,
      ));

  int getFiltersCount() {
    int count = 0;
    count = (state.categories.length) + count;
    count = count + ((state.minPrice!=0 || state.maxPrice!=10000)? 1 : 0);
    return count;
  }

  void reset() => emit(const FilterProductParams());
}
