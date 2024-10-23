import 'package:flutter/material.dart';

class PaymentMethod {
  final String name;
  final String logoPath;

  PaymentMethod(this.name, this.logoPath);
}

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod('bkash', 'assets/logo/bkash1.png'),
    PaymentMethod('Nagad', 'assets/logo/nagad.jpg'),
    PaymentMethod('Rocket', 'assets/logo/rocket.png'),
    PaymentMethod('Upai', 'assets/logo/upai.png'),
  ]; // Predefined payment methods with logos

  // Function to add a new payment method
  void _addPaymentMethod(String method) {
    setState(() {
      _paymentMethods.add(PaymentMethod(method, 'assets/logos/default.png')); // Placeholder logo
    });
  }

  // Function to remove a payment method
  void _removePaymentMethod(int index) {
    setState(() {
      _paymentMethods.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text('Payment Methods'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddPaymentDialog(context),
          ),
        ],
      ),
      body: _paymentMethods.isEmpty
          ? const Center(child: Text('No payment methods added.'))
          : ListView.builder(
        itemCount: _paymentMethods.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              _paymentMethods[index].logoPath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            title: Text(_paymentMethods[index].name),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removePaymentMethod(index),
            ),
          );
        },
      ),
    );
  }

  // Function to show a dialog to add a new payment method
  void _showAddPaymentDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Payment Method'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter payment method'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  _addPaymentMethod(controller.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
