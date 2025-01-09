import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../model/address_model.dart';
import '../../model/order.dart';
import '../../model/order_info.dart';
import '../../model/product_model.dart';
import '../../provider/bucket_provider.dart';
import '../../provider/checkout_provider.dart';
import '../../provider/profile_provider.dart';
import '../../provider/wallet_provider.dart';
import '../Thank_you_page.dart';
import '../common/colors.dart';
import '../wallet_screen.dart';
import 'address_page.dart'; // Import the AddressPage

class BucketListPage extends StatelessWidget {
  static const routeName = '/bucketlist';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckoutProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Bucket',
            style: TextStyle(color: white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: white),
          centerTitle: true,
          backgroundColor: primary,
          actions: [
            IconButton(
              icon: Icon(Icons.account_balance_wallet, color: white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletPage()),
                );
              },
            ),
          ],
        ),
        body: Consumer<BucketProvider>(
          builder: (context, bucketProvider, child) {
            final bucket = bucketProvider.bucket;
            return bucket.isEmpty
                ? _buildEmptyBucketView(context)
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          // Bucket List Section
                          _buildBucketList(bucket),
                          SizedBox(height: 24),
                          // Address Selection Section
                          AddressSelectionSection(),
                          SizedBox(height: 24),
                          // Pickup Date Selection Section
                          PickupDateSection(),
                          SizedBox(height: 24),
                          //GST method
                          GSTBillSection(),
                          SizedBox(height: 24),
                          // Coupon Section
                          CouponSection(),
                          SizedBox(height: 24),
                          // Payment Method Selection Section
                          PaymentMethodSection(),
                          SizedBox(height: 24),
                          // Total Price and Place Order Section
                          TotalAndPlaceOrderSection(),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  /// Builds the view when the bucket is empty
  Widget _buildEmptyBucketView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_basket_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            SizedBox(height: 20),
            Text(
              'Your bucket is empty',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to shopping page or home
                Navigator.pop(context);
              },
              child: Text(
                'Start Shopping',
                style: TextStyle(color: white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the bucket list section with items
  Widget _buildBucketList(List<Product> bucket) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Products',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: bucket.length,
          itemBuilder: (context, index) {
            final product = bucket[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: SvgPicture.asset(
                  product.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
                title: Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.production_quantity_limits,
                        size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      'x${product.quantity}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.currency_rupee,
                        size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      '${product.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                trailing: Text(
                  '\₹ ${(product.price * product.quantity).toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primary),
                ),
                onLongPress: () {
                  _removeProduct(context, product);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  /// Handles product removal from the bucket
  void _removeProduct(BuildContext context, Product product) {
    Provider.of<BucketProvider>(context, listen: false)
        .removeProduct(product.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} removed from bucket'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

/// Address Selection Section
/// Address Selection Section
class AddressSelectionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Delivery Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.edit, color: primary),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressPage()),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 16),
        profileProvider.selectedAddress == null
            ? Center(
                child: Text(
                  'No address selected. Please select or add a new address.',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              )
            : Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(
                    'Name: ${profileProvider.selectedAddress!.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Number: ${profileProvider.selectedAddress!.mobileNumber}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Address:${profileProvider.selectedAddress!.fullAddress}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.check_circle, color: primary),
                ),
              ),
      ],
    );
  }
}

/// Pickup Date Selection Section
class PickupDateSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pickup Date',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: checkoutProvider.selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
            );

            checkoutProvider.setSelectedDate(pickedDate);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: primary),
                SizedBox(width: 16),
                Text(
                  checkoutProvider.selectedDate != null
                      ? DateFormat('yyyy-MM-dd')
                          .format(checkoutProvider.selectedDate!)
                      : 'Select Pickup Date',
                  style: TextStyle(
                    fontSize: 16,
                    color: checkoutProvider.selectedDate != null
                        ? Colors.black
                        : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Payment Method Selection Section
class PaymentMethodSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        RadioListTile<PaymentMethod>(
          title: Text('Cash on Delivery'),
          value: PaymentMethod.CashOnDelivery,
          groupValue: checkoutProvider.selectedPaymentMethod,
          onChanged: (PaymentMethod? value) {
            if (value != null) {
              checkoutProvider.setPaymentMethod(value);
            }
          },
        ),
        RadioListTile<PaymentMethod>(
          title: Text('Wallet'),
          value: PaymentMethod.Wallet,
          groupValue: checkoutProvider.selectedPaymentMethod,
          onChanged: (PaymentMethod? value) {
            if (value != null) {
              checkoutProvider.setPaymentMethod(value);
            }
          },
        ),
        RadioListTile<PaymentMethod>(
          title: Text('Online Payment'),
          value: PaymentMethod.Online,
          groupValue: checkoutProvider.selectedPaymentMethod,
          onChanged: (PaymentMethod? value) {
            if (value != null) {
              checkoutProvider.setPaymentMethod(value);
            }
          },
        ),
      ],
    );
  }
}

/// Total Price and Place Order Section
/// Total Price and Place Order Section
class TotalAndPlaceOrderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bucketProvider = Provider.of<BucketProvider>(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    final walletProvider = Provider.of<WalletProvider>(context);

    double subtotal = bucketProvider.bucket
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
    double couponDiscount = checkoutProvider.couponDiscount ?? 0;
    double gstAmount = checkoutProvider.wantGSTBill ? (subtotal * 0.18) : 0;
    double totalPrice = subtotal - couponDiscount + gstAmount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Subtotal
        _buildPriceRow('Subtotal', subtotal),
        SizedBox(height: 8),
        // Coupon Discount
        _buildPriceRow('Coupon Discount', -couponDiscount, couponDiscount > 0),
        SizedBox(height: 8),
        // GST Amount
        _buildPriceRow(
            'GST Amount (18%)', gstAmount, checkoutProvider.wantGSTBill),
        SizedBox(height: 8),
        // Divider
        Divider(color: Colors.grey[400]),
        SizedBox(height: 8),
        // Total Amount
        _buildPriceRow('Total', totalPrice),
        SizedBox(height: 16),
        // Place Order Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (checkoutProvider.selectedDate != null)
                ? () => _placeOrder(context, totalPrice)
                : null, // Disable button if conditions aren't met
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_checkout, color: white),
                SizedBox(width: 8),
                Text(
                  'Place Order',
                  style: TextStyle(color: white, fontSize: 18),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
          ),
        ),
      ],
    );
  }

  /// Helper method to build a price row with optional bold and color formatting
  Widget _buildPriceRow(String label, double amount,
      [bool isVisible = true, bool isBold = false, bool isPrimary = false]) {
    if (!isVisible) return SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        Text(
          '\₹ ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isPrimary ? primary : Colors.grey[800],
          ),
        ),
      ],
    );
  }

  /// Place order method (same as before)
  void _placeOrder(BuildContext context, double totalPrice) {
    // Implement order logic here
  }
}

/// Handles placing the order based on selected payment method
void _placeOrder(BuildContext context, double totalPrice) {
  final checkoutProvider =
      Provider.of<CheckoutProvider>(context, listen: false);
  final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
  final walletProvider = Provider.of<WalletProvider>(context, listen: false);
  final bucketProvider = Provider.of<BucketProvider>(context, listen: false);

  // Validate Address
  if (profileProvider.selectedAddress == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please select a delivery address.')),
    );
    return;
  }

  // Validate Pickup Date
  if (checkoutProvider.selectedDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please select a pickup date.')),
    );
    return;
  }

  // Handle Payment Methods
  switch (checkoutProvider.selectedPaymentMethod) {
    case PaymentMethod.CashOnDelivery:
      _handleCashOnDelivery(context, bucketProvider, totalPrice);
      break;
    case PaymentMethod.Wallet:
      _handleWalletPayment(context, bucketProvider, walletProvider, totalPrice);
      break;
    case PaymentMethod.Online:
      _handleOnlinePayment(context, bucketProvider, totalPrice);
      break;
  }
}

/// Handles Cash on Delivery payment
void _handleCashOnDelivery(
    BuildContext context, BucketProvider bucketProvider, double totalPrice) {
  _createOrder(context, bucketProvider, totalPrice);
}

/// Handles Wallet payment
void _handleWalletPayment(BuildContext context, BucketProvider bucketProvider,
    WalletProvider walletProvider, double totalPrice) {
  if (walletProvider.wallet.balance >= totalPrice) {
    walletProvider.deductFunds(totalPrice);
    _createOrder(context, bucketProvider, totalPrice);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment deducted from your wallet.')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Insufficient wallet balance!')),
    );
  }
}

/// Handles Online payment (Simulation)
void _handleOnlinePayment(
    BuildContext context, BucketProvider bucketProvider, double totalPrice) {
  // Implement actual online payment gateway integration here
  // For demonstration, we'll assume payment is successful
  _createOrder(context, bucketProvider, totalPrice);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Payment successful via Online Payment!')),
  );
}

/// Creates a new order and navigates to Thank You Page
void _createOrder(
    BuildContext context, BucketProvider bucketProvider, double totalPrice) {
  final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
  final checkoutProvider =
      Provider.of<CheckoutProvider>(context, listen: false);

  final DateTime now = DateTime.now();
  final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  final String formattedTime = DateFormat('hh:mm a').format(now);

  // Create a new Order
  final newOrder = Order(
    orderNumber: DateTime.now().millisecondsSinceEpoch.toString(),
    dateOfPickup:
        DateFormat('yyyy-MM-dd').format(checkoutProvider.selectedDate!),
    status: 'Confirmed',
    quantity: bucketProvider.bucket.fold(0, (sum, item) => sum + item.quantity),
    price: totalPrice,
    details: _generateOrderDetails(bucketProvider.bucket),
    statusTimeline: {
      'Order Placed': '$formattedTime, $formattedDate',
      'Packed': 'N/A',
      'Picked': 'N/A',
      'Delivered': 'N/A',
    },
  );

  // Add the new order to the orders list
  orders.add(newOrder); // Ensure 'orders' is defined and managed appropriately

  // Clear the bucket
  bucketProvider.clearBucket();

  // Show confirmation
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Order placed successfully!')),
  );

  // Navigate to Thank You Page
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => ThankYouPage()),
  );
}

/// Helper method to generate order details string
String _generateOrderDetails(List<Product> bucket) {
  return bucket.map((item) => '${item.quantity} x ${item.title}').join(', ');
}

/// GST Bill Selection Section
/// GST Bill Selection Section
class GSTBillSection extends StatefulWidget {
  @override
  _GSTBillSectionState createState() => _GSTBillSectionState();
}

class _GSTBillSectionState extends State<GSTBillSection> {
  bool _wantGSTBill = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do you want a GST Bill?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.receipt_long,
              color: _wantGSTBill ? primary : Colors.grey,
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              _wantGSTBill ? 'Yes' : 'No',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _wantGSTBill ? primary : Colors.grey[600],
              ),
            ),
            Spacer(),
            Switch(
              value: _wantGSTBill,
              onChanged: (value) {
                setState(() {
                  _wantGSTBill = value;
                });
                // Save this value to checkoutProvider
                Provider.of<CheckoutProvider>(context, listen: false)
                    .setGSTBill(_wantGSTBill);
              },
              activeColor: primary,
            ),
          ],
        ),
        if (_wantGSTBill)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'A GST bill will be generated for this order.',
              style: TextStyle(fontSize: 14, color: Colors.green[700]),
            ),
          ),
        SizedBox(height: 16),
        Divider(color: Colors.grey[400]),
      ],
    );
  }
}

/// Coupon Section where the user can apply coupon codes
class CouponSection extends StatefulWidget {
  @override
  _CouponSectionState createState() => _CouponSectionState();
}

class _CouponSectionState extends State<CouponSection> {
  final TextEditingController _couponController = TextEditingController();
  String? _couponErrorMessage;
  bool _isCouponApplied = false;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Apply Coupon',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _couponController,
          decoration: InputDecoration(
            labelText: 'Enter coupon code',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary, width: 2),
            ),
            errorText: _couponErrorMessage,
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 14),
            suffixIcon: Icon(Icons.discount, color: primary),
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: _isCouponApplied ? null : _applyCoupon,
              child: Text(
                _isCouponApplied ? 'Coupon Applied' : 'Apply Coupon',
                style: TextStyle(fontSize: 16, color: white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCouponApplied ? Colors.grey : primary,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            if (_isCouponApplied)
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Coupon applied!',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
        if (!_isCouponApplied && _couponErrorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Please enter a valid coupon code.',
              style: TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
          ),
      ],
    );
  }

  /// Method to apply the coupon
  void _applyCoupon() {
    final couponCode = _couponController.text.trim();
    final checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);

    // Simple example: Assume a coupon code "SAVE20" gives a 20% discount
    if (couponCode == 'SAVE20') {
      setState(() {
        _isCouponApplied = true;
        _couponErrorMessage = null;
      });

      checkoutProvider.applyDiscount(0.20); // Applying 20% discount
    } else {
      setState(() {
        _isCouponApplied = false;
        _couponErrorMessage = 'Invalid coupon code. Please try again.';
      });
    }
  }
}
