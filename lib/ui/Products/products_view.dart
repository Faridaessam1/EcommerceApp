import 'package:e_commerce_app/ui/Products/widgets/product_error_widget.dart';
import 'package:e_commerce_app/ui/Products/widgets/product_grid_item.dart';
import 'package:e_commerce_app/ui/Products/widgets/product_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import 'cubit/products_cubit.dart';
import 'cubit/products_states.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // استقبال الـ arguments من Navigator
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No arguments provided'),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Go Back'),
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
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Invalid arguments provided'),
              Text('SubcategoryId: $subcategoryId'),
              Text('SubcategoryName: $subcategoryName'),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Go Back'),
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

    // Debug prints
    print("ProductsView initialized");
    print("SubcategoryId: ${widget.subcategoryId}");
    print("SubcategoryName: ${widget.subcategoryName}");
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              // TODO: Navigate to cart
            },
          ),
        ],
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
                            // TODO: Navigate to product details
                          },
                          onFavoritePressed: () {
                            // TODO: Handle favorite
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