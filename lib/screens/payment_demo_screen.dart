import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../services/razorpay_service.dart';

class PaymentDemoScreen extends StatefulWidget {
  const PaymentDemoScreen({super.key});

  @override
  State<PaymentDemoScreen> createState() => _PaymentDemoScreenState();
}

class _PaymentDemoScreenState extends State<PaymentDemoScreen> {
  final RazorpayService _razorpayService = RazorpayService();

  final TextEditingController _keyController =
      TextEditingController(text: 'rzp_test_S5hRLDcaa1aIU7');
  final TextEditingController _amountController =
      TextEditingController(text: '100'); // INR
  final TextEditingController _nameController =
      TextEditingController(text: 'Payment Demo');
  final TextEditingController _descController =
      TextEditingController(text: 'Demo payment');
  final TextEditingController _emailController =
      TextEditingController(text: 'test@example.com');
  final TextEditingController _contactController =
      TextEditingController(text: '9999999999');

  @override
  void initState() {
    super.initState();
    _razorpayService.registerHandlers(
      onSuccess: _onPaymentSuccess,
      onError: _onPaymentError,
      onExternalWallet: _onExternalWallet,
    );
  }

  @override
  void dispose() {
    _razorpayService.clear();
    _keyController.dispose();
    _amountController.dispose();
    _nameController.dispose();
    _descController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _onPaymentSuccess(PaymentSuccessResponse response) {
    _showSnack('Payment success: ${response.paymentId}', Colors.green);
  }

  void _onPaymentError(PaymentFailureResponse response) {
    _showSnack(
        'Payment failed: ${response.code} - ${response.message}', Colors.red);
  }

  void _onExternalWallet(ExternalWalletResponse response) {
    _showSnack('External wallet: ${response.walletName}', Colors.blue);
  }

  void _showSnack(String text, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: color),
    );
  }

  void _startPayment() {
    final key = _keyController.text.trim();
    final amountInr = int.tryParse(_amountController.text.trim());

    if (key.isEmpty || key.startsWith('rzp_test_xxxxxxxxxx')) {
      _showSnack('Add your Razorpay TEST key in Key field', Colors.orange);
      return;
    }
    if (amountInr == null || amountInr <= 0) {
      _showSnack('Enter valid amount (INR)', Colors.orange);
      return;
    }

    _razorpayService.openCheckout(
      key: key,
      amountInPaise: amountInr * 100,
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      contact: _contactController.text.trim(),
      email: _emailController.text.trim(),
      notes: {'source': 'gallery_access_demo'},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Razorpay Payment Demo'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter TEST credentials',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _keyController,
                      decoration: const InputDecoration(
                        labelText: 'Key (rzp_test_...)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Amount (INR)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: 'Currency',
                              hintText: 'INR',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Merchant Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _contactController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Contact',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _startPayment,
                        icon: const Icon(Icons.payment),
                        label: const Text(
                          'Pay Now (Test)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
