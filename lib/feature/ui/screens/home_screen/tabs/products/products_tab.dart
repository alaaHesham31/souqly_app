import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_view_model.dart';
import 'package:e_commerce_app/feature/ui/widgets/filter_tabs_widget.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/wish_list/cubit/wish_list_view_model.dart';
import 'package:e_commerce_app/feature/ui/widgets/product_card.dart';
import 'package:e_commerce_app/feature/ui/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductsTab extends StatefulWidget {
  ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab>
    with AutomaticKeepAliveClientMixin {
  late final ProductsTabViewModel viewModel = getIt<ProductsTabViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.getAllProducts();
    context.read<WishListViewModel>().fetchWishlist();
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true; //  keeps tab alive

  @override
  Widget build(BuildContext context) {
    super.build(context); //  important for keepAlive

    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Image(
            image: AssetImage(AppAssets.appLogo),
            color: AppColors.primaryColor,
            width: 200.w,
          ),
        ),
        body: BlocConsumer<ProductsTabViewModel, ProductsTabStates>(
          //  Only listen for add-to-cart result states
          listenWhen: (prev, curr) =>
              curr is AddToCartSuccessState || curr is AddToCartErrorState,
          listener: (context, state) {
            if (state is AddToCartErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.errorMessage),
                  backgroundColor: AppColors.redColor,
                ),
              );
            } else if (state is AddToCartSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      state.addToCartResponseEntity.message ?? 'Added to cart'),
                  backgroundColor: AppColors.greenColor,
                ),
              );
            }
          },
          // Do not rebuild UI for add-to-cart states (prevents Scaffold replacement)
          buildWhen: (prev, curr) =>
              curr is ProductsLoadingState ||
              curr is ProductsSuccessState ||
              curr is ProductsErrorState,

          builder: (context, state) {
            if (state is ProductsLoadingState &&
                viewModel.filteredProductsList.isEmpty) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }
            if (state is ProductsErrorState) {
              return Center(child: Text(state.error.errorMessage));
            }
            final subCategoriesList = viewModel.allProductsList
                .expand(
                    (product) => product.subcategory!.map((sub) => sub.name))
                .toSet()
                .toList();
            return Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                children: [
                  SearchBarWidget(),
                  SizedBox(
                    height: 24.h,
                  ),
                  SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: subCategoriesList.length,
                      itemBuilder: (context, index) {
                        final subCategory = subCategoriesList[index];
                        return GestureDetector(
                          onTap: () {
                            viewModel.filterProductsBySubCategory(
                                subCategory, index);
                          },
                          child: FilterTabsWidget(
                            backgroundSelectedColor: AppColors.primaryColor,
                            borderUnSelectedColor: AppColors.primaryColor,
                            selectedTextStyle: AppStyles.bold14White,
                            unSelectedTextStyle: AppStyles.bold14Primary,
                            isSelected: viewModel.selectedIndex == index,
                            subCategoryName: subCategory ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: viewModel.filteredProductsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3.2.h,
                            mainAxisSpacing: 16.h,
                            crossAxisSpacing: 16.w),
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                context.push(AppRoutes.productDetailsScreen,
                                    extra:
                                        viewModel.filteredProductsList[index]);
                              },
                              child: ProductCard(
                                product: viewModel.filteredProductsList[index],
                              ));
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
