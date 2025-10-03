import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/categories/domain/usecases/get_categories.dart';
import 'package:minimart/src/features/categories/presentation/bloc/categories/categories_bloc.dart';
import 'package:minimart/src/features/categories/presentation/bloc/categories/categories_event.dart';
import 'package:minimart/src/features/categories/presentation/widgets/category_list.dart';
import 'package:minimart/src/features/products/domain/params/product_query_params.dart';
import 'package:minimart/src/features/products/domain/usecases/fetch_products.dart';
import 'package:minimart/src/features/products/presentation/bloc/products/product_bloc.dart';
import 'package:minimart/src/features/products/presentation/bloc/products/product_event.dart';
import 'package:minimart/src/injection/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) =>
          ProductBloc(fetchProducts: sl<FetchProducts>())
            ..add(LoadProducts(params: ProductQueryParams.initial())),
      child: Scaffold(
        body: CustomScrollView(
          controller: controller,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 200,
              pinned: true,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),

                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.location_on, color: Colors.white),
                            SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'X (House), Y (Street), Z (District), 785634, Kerala, India asd',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        height: 45,
                        child: CupertinoSearchTextField(
                          backgroundColor: Colors.white,
                        ),
                      ),

                      SizedBox(height: 25),

                      BlocProvider(
                        create: (context) =>
                            CategoriesBloc(getCategories: sl<GetCategories>())
                              ..add(LoadCategories()),
                        child: CategoryList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(child: Container(color: Colors.purple)),
          ],
        ),
      ),
    );
  }
}

final categories = [
  {"icon": Icons.shopping_bag, "name": "For You"},
  {"icon": Icons.checkroom, "name": "Fashion"},
  {"icon": Icons.phone_android, "name": "Mobile"},
  {"icon": Icons.laptop_mac, "name": "Electronics"},
  {"icon": Icons.kitchen, "name": "Appliances"},
  {"icon": Icons.brush, "name": "Beauty"},
];


  // Column(
        //   children: [
        //     FilterBar(onFilterChanged: (filters) {}),
        //     Expanded(
        //       child: BlocBuilder<ProductBloc, ProductsState>(
        //         builder: (context, state) {
        //           if (state.status == ProductsStatus.initial ||
        //               state.status == ProductsStatus.loading) {
        //             return Center(child: CircularProgressIndicator());
        //           }

        //           if (state.status == ProductsStatus.error &&
        //               state.products.isEmpty) {
        //             return Column(
        //               children: [
        //                 Text(state.errorMessage ?? "Something went wrong"),
        //                 const SizedBox(height: 8),
        //                 ElevatedButton(
        //                   onPressed: () {
        //                     context.read<ProductBloc>().add(
        //                       LoadProducts(
        //                         params: ProductQueryParams.initial(),
        //                       ),
        //                     );
        //                   },
        //                   child: const Text("Retry"),
        //                 ),
        //               ],
        //             );
        //           }

        //           return NotificationListener<ScrollNotification>(
        //             onNotification: (scrollInfo) {
        //               if (scrollInfo.metrics.pixels >=
        //                       scrollInfo.metrics.maxScrollExtent - 100 &&
        //                   state.status != ProductsStatus.loadingMore &&
        //                   !state.hasReachedEnd) {
        //                 context.read<ProductBloc>().add(LoadMoreProducts());
        //               }
        //               return false;
        //             },
        //             child: GridView.builder(
        //               padding: EdgeInsets.symmetric(horizontal: 6),
        //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                 crossAxisCount: 2,
        //                 mainAxisSpacing: 10,
        //                 crossAxisSpacing: 10,
        //                 childAspectRatio: 0.8,
        //               ),
        //               shrinkWrap: true,
        //               itemCount:
        //                   state.products.length +
        //                   (state.hasReachedEnd ? 0 : 1) +
        //                   (state.status == ProductsStatus.loadingMore ? 1 : 0),
        //               itemBuilder: (context, index) {
        //                 if (index < state.products.length) {
        //                   final product = state.products[index];
        //                   return ProductCard(product: product);
        //                 }

        //                 if (index == state.products.length &&
        //                     !state.hasReachedEnd) {
        //                   if (state.status == ProductsStatus.loadingMore) {
        //                     return const Padding(
        //                       padding: EdgeInsets.symmetric(vertical: 16),
        //                       child: Center(child: CircularProgressIndicator()),
        //                     );
        //                   }
        //                 }

        //                 if (state.status == ProductsStatus.ongoingError &&
        //                     index ==
        //                         state.products.length +
        //                             (state.hasReachedEnd ? 0 : 1)) {
        //                   return Padding(
        //                     padding: const EdgeInsets.all(16),
        //                     child: Column(
        //                       children: [
        //                         Text(
        //                           state.errorMessage ??
        //                               "Failed to load more products",
        //                           style: const TextStyle(color: Colors.red),
        //                         ),
        //                         const SizedBox(height: 8),
        //                         ElevatedButton(
        //                           onPressed: () {
        //                             context.read<ProductBloc>().add(
        //                               LoadMoreProducts(),
        //                             );
        //                           },
        //                           child: const Text("Retry"),
        //                         ),
        //                       ],
        //                     ),
        //                   );
        //                 }
        //                 return const SizedBox.shrink();
        //               },
        //             ),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),