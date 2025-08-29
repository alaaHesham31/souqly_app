import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/feature/ui/widgets/cart_icon_widgte.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({
    super.key,
  });

  TextEditingController controller = TextEditingController();

  // ProductEntity item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
              controller: controller,
              hintText: 'what do you search for?',
              borderRadius: 20,
              borderColor: AppColors.primaryColor,
              prefixIcon: Icon(
                Icons.search_rounded,
                color: AppColors.primaryColor,
                size: 30.h,
              )),
        ),
        SizedBox(
          width: 8.w,
        ),
        CartIconWithBadge(),
        // InkWell(
        //   onTap: () => context.push(AppRoutes.cartDetailsScreen),
        //   child: BlocBuilder<ProductsTabViewModel, ProductsTabStates>(
        //     builder: (context, state) {
        //       return badges.Badge(
        //         position: badges.BadgePosition.topStart(top: -10, start: -6),
        //         badgeContent: Text(
        //           ProductsTabViewModel.get(context).numOfCartItems.toString(),
        //           style: AppStyles.light16White,
        //         ),
        //         badgeStyle: badges.BadgeStyle(
        //           badgeColor: AppColors.greenColor,
        //         ),
        //         child: Icon(
        //           Icons.shopping_cart_outlined,
        //           size: 30.sp,
        //           color: AppColors.primaryColor,
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
