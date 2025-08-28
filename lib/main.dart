import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_theme.dart';
import 'package:e_commerce_app/core/utils/my_bloc_observer.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_view_model.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/wish_list/cucit/wish_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/shared_prefrences/shared_preferences_utils.dart';
import 'feature/ui/screens/home_screen/tabs/products/cart/cubit/get_cart_items_view_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesUtils.sharedInit();
  Bloc.observer = MyBlocObserver();
  configureDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<ProductsTabViewModel>()),
      BlocProvider(create: (context) => getIt<GetCartItemsViewModel>()),
      BlocProvider(create: (context) => getIt<WishListViewModel>()),

    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) =>  MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.router,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
