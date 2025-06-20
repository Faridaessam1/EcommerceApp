import 'package:e_commerce_app/ui/Products/widgets/product_error_widget.dart';
import 'package:e_commerce_app/ui/Products/widgets/product_grid_item.dart';
import 'package:e_commerce_app/ui/Products/widgets/product_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../ProductDetails/product_details_view.dart';
import 'cubit/products_cubit.dart';
import 'cubit/products_states.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No arguments provided'),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final subcategoryId = args['subcategoryId'] as String?;
    final subcategoryName = args['subcategoryName'] as String?;

    if (subcategoryId == null || subcategoryName == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Invalid arguments provided'),
              Text('SubcategoryId: $subcategoryId'),
              Text('SubcategoryName: $subcategoryName'),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => getIt<ProductCubit>()..getProductsBySubCategory(subcategoryId, isRefresh: true),
      child: ProductsView(
        subcategoryId: subcategoryId,
        subcategoryName: subcategoryName,
      ),
    );
  }
}

class ProductsView extends StatefulWidget {
  final String subcategoryId;
  final String subcategoryName;

  const ProductsView({
    Key? key,
    required this.subcategoryId,
    required this.subcategoryName,
  }) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductCubit>().loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.subcategoryName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductStates>(
        builder: (context, state) {
          final cubit = ProductCubit.get(context);

          if (state is ProductLoadingState && cubit.allProducts.isEmpty) {
            return const ProductLoadingWidget();
          }

          if (state is ProductErrorState && cubit.allProducts.isEmpty) {
            return ProductErrorWidget(
              errorMessage: state.errorMsg,
              onRetry: () => cubit.refreshProducts(),
            );
          }

          // Show "No products found" message when there are no products
          if ((state is ProductSuccessState || state is ProductLoadMoreSuccessState) &&
              cubit.allProducts.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async => cubit.refreshProducts(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Products Found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'There are no products available\nin this category at the moment.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => cubit.refreshProducts(),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return ProductGridItem(
                          product: cubit.allProducts[index],
                          onTap: () {
                            // Navigate to product details
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  product: cubit.allProducts[index],
                                ),
                              ),
                            );
                          },
                          onFavoritePressed: () {
                            // TODO: Handle favorite
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to favorites'),
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        );
                      },
                      childCount: cubit.allProducts.length,
                    ),
                  ),
                ),
                if (state is ProductLoadMoreState)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                if (!cubit.hasMoreProducts && cubit.allProducts.isNotEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'No more products to load',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
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