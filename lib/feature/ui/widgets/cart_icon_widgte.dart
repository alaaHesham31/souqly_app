import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';

import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_view_model.dart';

class CartIconWithBadge extends StatelessWidget {
  const CartIconWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(AppRoutes.cartDetailsScreen),
      child: BlocBuilder<ProductsTabViewModel, ProductsTabStates>(
        builder: (context, state) {
          final cartCount = ProductsTabViewModel.get(context).numOfCartItems;

          return badges.Badge(
            showBadge: cartCount > 0,
            position: badges.BadgePosition.topEnd(top: -10, end: -6),
            badgeContent: Text(
              cartCount.toString(),
              style: AppStyles.light16White,
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: AppColors.greenColor,
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 40.sp,
              color: AppColors.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
