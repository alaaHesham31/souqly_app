import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cart/cart_item.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cart/cubit/get_cart_items_view_model.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartDetailsScreen extends StatefulWidget {
  const CartDetailsScreen({super.key});

  @override
  State<CartDetailsScreen> createState() => _CartDetailsScreenState();
}

class _CartDetailsScreenState extends State<CartDetailsScreen> {
  late final GetCartItemsViewModel viewModel = getIt<GetCartItemsViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.getCartItems();
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart", style: AppStyles.semiBold20Primary),
          centerTitle: true,
        ),
        body: BlocConsumer<GetCartItemsViewModel, ProductsTabStates>(
          listenWhen: (prev, curr) =>
              curr is DeleteCartSuccessState ||
              curr is DeleteCartErrorState ||
              curr is UpdateCountSuccessState,
          listener: (context, state) {
            if (state is DeleteCartErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.errorMessage),
                  backgroundColor: AppColors.redColor,
                ),
              );
            } else if (state is DeleteCartSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.getCartResponseEntity.message ??
                      'Deleted successfully'),
                  backgroundColor: AppColors.greenColor,
                ),
              );
            }
          },
          buildWhen: (prev, curr) =>
              curr is GetCartLoadingState ||
              curr is GetCartSuccessState ||
              curr is GetCartErrorState ||
              curr is UpdateCountSuccessState,
          builder: (context, state) {
            if (state is GetCartLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            if (state is GetCartErrorState) {
              return Center(child: Text(state.error.errorMessage));
            }

            if (state is GetCartSuccessState) {
              final items = state.getCartResponseEntity.data?.products ?? [];
              final total =
                  state.getCartResponseEntity.data?.totalCartPrice ?? 0;
              // final count = state.getCartResponseEntity.data?.products[index].count ?? 0
              if (items.isEmpty) {
                return Center(
                  child: Image(
                    image: AssetImage(AppAssets.emptyCart),
                    height: 200.h,
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(12.w),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return CartItem(
                          item: item,
                          onDelete: () {
                            context
                                .read<GetCartItemsViewModel>()
                                .deleteCartItem(item.product?.id ?? '');
                          },
                        );
                      },
                    ),
                  ),
                  _buildCheckoutSec(total),
                ],
              );
            }

            return const SizedBox(); // fallback
          },
        ),
      ),
    );
  }

  Widget _buildCheckoutSec(num total) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total price", style: AppStyles.medium16Grey),
              Text("EGP $total", style: AppStyles.bold18Black),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            onPressed: () {},
            child: Row(
              children: [
                Text("Check Out", style: AppStyles.medium18White),
                SizedBox(width: 16.w),
                const Icon(Icons.arrow_forward, color: AppColors.whiteColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
