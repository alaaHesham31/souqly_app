import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/feature/ui/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteTab extends StatelessWidget {
  FavouriteTab({super.key});

  TextEditingController controller = TextEditingController();

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
      body: Padding(
        padding:  EdgeInsets.all(12.sp),
        child: Column(
          children: [
            SearchBarWidget(controller: controller, onCartTab: () {}),
            SizedBox(
              height: 12.h,
            ),
            Expanded(
              child: ListView.builder(
                // padding: EdgeInsets.all(12.w),
                itemCount: 7,
                itemBuilder: (context, index) {
                  return ;
                  //   CartItem(
                  //   item: item,
                  //   isInFavTab: true,
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
