// lib/data/payment/payment_service.dart
import 'package:dio/dio.dart';

class PaymentService {
  final Dio dio;
  PaymentService(this.dio);

  /// Call backend /api/paymob/create-payment
  /// Returns map { iframeUrl, orderId, paymentToken }
  Future<Map<String, dynamic>> createPayment({
    required double amount,
    required String merchantOrderId,
    required Map<String, dynamic> billingData,
  }) async {
    final resp = await dio.post(
      '/api/paymob/create-payment',
      data: {
        'amount': amount,
        'merchant_order_id': merchantOrderId,
        'billing_data': billingData,
      },
      options: Options(
        sendTimeout: const Duration(seconds: 15000),
        receiveTimeout: const Duration(seconds: 15000),
      ),
    );
    // If server responded 200 but body structure changed, handle it
    final data = resp.data;
    if (data == null) throw Exception('Empty response from server');
    return {
      "iframeUrl": data['iframeUrl'] as String?,
      "orderId": data['orderId']?.toString(),
      "paymentToken": data['paymentToken'] as String?,
    };
  }

  Future<Map<String, dynamic>> verify(String orderId) async {
    final resp = await dio.get(
      '/api/paymob/verify',
      queryParameters: {'orderId': orderId},
    );
    return resp.data as Map<String, dynamic>;
  }
}
