import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/categories_bloc/category_bloc.dart';
import '../widgets/categoey_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return Container(
              height: 800,
              width: 320,
              child: ListView.builder(
                itemCount: (state is CategoryLoading)
                    ? 10
                    : state.categories.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                    top: 14,
                    bottom: (80 + MediaQuery
                        .of(context)
                        .padding
                        .bottom)),
                itemBuilder: (context, index) =>
                (state is CategoryLoading)
                    ? const CategoryCard()
                    : CategoryCard(
                  category: state.categories[index],
                ),
              ),
            );
          },
        ),
    );
  }
}
