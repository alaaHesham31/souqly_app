import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cart/cart_item.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cart/cubit/get_cart_items_view_model.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartDetailsScreen extends StatelessWidget {
  CartDetailsScreen({super.key});

  GetCartItemsViewModel viewModel = getIt<GetCartItemsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Cart",
            style: AppStyles.semiBold20Primary,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder(
            bloc: viewModel..getCartItem(),
            builder: (context, state) {
              if (state is GetCartSuccessState) {
                print(viewModel.cartItems.length);
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(12.w),

                        itemCount: viewModel.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = viewModel.cartItems[index];

                          return CartItem(
                            item: item,
                          );
                        },
                      ),
                    ),
                    buildCheckoutSec()
                  ],
                );
              } else if (state is GetCartErrorState) {
                return Text(state.error.errorMessage);
              } else if (state is GetCartLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }
              return SizedBox();
            }));
  }

  Widget buildCheckoutSec() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 6, offset: Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Total Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total price", style: AppStyles.medium16Grey),
              Text("EGP 3,500", style: AppStyles.bold18Black),
            ],
          ),

          // Checkout Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            onPressed: () {},
            child: Row(
              children: [
                Text(
                  "Check Out",
                  style: AppStyles.medium18White,
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
