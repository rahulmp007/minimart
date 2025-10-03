import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/categories/presentation/bloc/categories/categories_bloc.dart';
import 'package:minimart/src/features/categories/presentation/bloc/categories/categories_event.dart';
import 'package:minimart/src/features/categories/presentation/bloc/categories/categories_state.dart';
import 'package:minimart/src/features/categories/presentation/widgets/category_item.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  final indicatorWidth = 80 * 0.6;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesInitial || state is CategoriesLoading) {
            return Center(
              child: Transform.scale(
                scale: 0.5,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is CategoriesSuccess) {
            final categoryList = state.categories;

            return SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isSelected = index == state.currentSelectedIndex;

                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: GestureDetector(
                      onTap: () {
                        context.read<CategoriesBloc>().add(
                          ChangeCategory(category: categoryList[index]),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // The category item
                          CategoryItem(category: categoryList[index]),

                          // Indicator shown only for the selected item
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 6,
                            width: isSelected ? indicatorWidth * 0.6 : 0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
