import 'package:dio/dio.dart';
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

import '../../../../../../../data/payment/payment_service.dart';
import '../../../../../payment/payment_webview.dart';

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
            onPressed: () {
              print('is pressed');
              _onCheckoutPressed(total);
            },
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

  final PaymentService paymentService = PaymentService(
    Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000')),
  );

  Future<void> _onCheckoutPressed(num total) async {
    // billing data example
    final billingData = {
      "apartment": "NA",
      "email": "test@test.com",
      "floor": "NA",
      "first_name": "Alaa",
      "last_name": "Hesham",
      "street": "Test Street",
      "building": "123",
      "phone_number": "01000000000",
      "shipping_method": "NA",
      "postal_code": "12345",
      "city": "Cairo",
      "country": "EG",
      "state": "Cairo",
    };

    final merchantOrderId = DateTime.now().millisecondsSinceEpoch.toString();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      debugPrint('[checkout] calling createPayment...');
      final result = await paymentService
          .createPayment(
            amount: (total as num).toDouble(),
            merchantOrderId: merchantOrderId,
            billingData: billingData,
          )
          .timeout(const Duration(seconds: 20));

      debugPrint('[checkout] createPayment result: $result');

      Navigator.of(context).pop(); // hide loader

      final String? url = result['iframeUrl'] as String?;
      final String? orderId = result['orderId'] as String?;

      if (url == null || url.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid payment URL from server')));
        return;
      }

      final success = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
            builder: (_) => PaymentWebviewScreen(
                url: url, orderId: orderId ?? merchantOrderId)),
      );

      if (success == true) {
        // verify with backend
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()));
        final verifyResp =
            await paymentService.verify(orderId ?? merchantOrderId);
        Navigator.of(context).pop(); // hide loader

        debugPrint('[checkout] verifyResp: $verifyResp');

        final bool paid = verifyResp['tx'] != null &&
            (verifyResp['tx']['success'] == true ||
                (verifyResp['tx'] is Map && verifyResp['tx']['data'] != null));
        if (paid) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Payment succeeded'),
              backgroundColor: Colors.green));
          context.read<GetCartItemsViewModel>().getCartItems();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Payment not verified'),
              backgroundColor: Colors.red));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Payment cancelled')));
      }
    } on DioException catch (e) {
      Navigator.of(context).pop(); // hide loader
      debugPrint('[checkout] DioException: ${e.message}');
      debugPrint('[checkout] request uri: ${e.requestOptions.uri}');
      debugPrint(
          '[checkout] response: ${e.response?.statusCode} ${e.response?.data}');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Payment error: ${e.message}')));
    } on Exception catch (e) {
      Navigator.of(context).pop(); // hide loader
      debugPrint('[checkout] Exception: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Payment error: $e')));
    }
  }
}
