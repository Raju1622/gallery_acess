import 'dart:developer';

import 'package:razorpay_flutter/razorpay_flutter.dart';

typedef RazorpaySuccessHandler = void Function(PaymentSuccessResponse response);
typedef RazorpayErrorHandler = void Function(PaymentFailureResponse response);
typedef RazorpayExternalWalletHandler = void Function(
  ExternalWalletResponse response,
);

class RazorpayService {
  RazorpayService() : _razorpay = Razorpay();

  final Razorpay _razorpay;

  void registerHandlers({
    required RazorpaySuccessHandler onSuccess,
    required RazorpayErrorHandler onError,
    required RazorpayExternalWalletHandler onExternalWallet,
  }) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  void openCheckout({
    required String key,
    required int amountInPaise,
    required String name,
    required String description,
    required String contact,
    required String email,
    String currency = 'INR',
    String? orderId,
    Map<String, dynamic>? notes,
  }) {
    final options = <String, dynamic>{
      'key': key,
      'amount': amountInPaise, // smallest currency unit (paise)
      'name': name,
      'description': description,
      'currency': currency,
      'prefill': {
        'contact': contact,
        'email': email,
      },
      if (orderId != null && orderId.isNotEmpty) 'order_id': orderId,
      if (notes != null) 'notes': notes,
    };

    log('Opening Razorpay checkout', name: 'RazorpayService', error: options);
    _razorpay.open(options);
  }

  void clear() {
    try {
      _razorpay.clear();
    } catch (e) {
      // Best-effort cleanup; plugin might throw if already disposed.
      log('Razorpay clear failed: $e', name: 'RazorpayService');
    }
  }
}
