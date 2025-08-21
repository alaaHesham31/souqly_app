import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_view_model.dart';
import 'package:e_commerce_app/feature/ui/widgets/product_card.dart';
import 'package:e_commerce_app/feature/ui/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductsTab extends StatelessWidget {
  ProductsTab({super.key});

  ProductsTabViewModel viewModel = getIt<ProductsTabViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage(AppAssets.appLogo),
          color: AppColors.primaryColor,
          width: 200.w,
        ),
      ),
      body: BlocBuilder<ProductsTabViewModel, ProductsTabStates>(
        bloc: viewModel..getAllProducts(),
        builder: (context, state) {
          if (state is ProductsLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is ProductsErrorState) {
            return Text(state.error.errorMessage);
          } else if (state is ProductsSuccessState) {
            return Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                children: [
                  SearchBarWidget(
                      controller: viewModel.controller, onCartTab: () {}),
                  SizedBox(
                    height: 24.h,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: viewModel.allProductsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3.2.h,
                            mainAxisSpacing: 16.h,
                            crossAxisSpacing: 16.w),
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                context.push(AppRoutes.productDetailsScreen,
                                    extra: viewModel.allProductsList[index]);
                              },
                              child: ProductCard(
                                item: viewModel.allProductsList[index],
                              ));
                        }),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
