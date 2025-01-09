import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_urban_care/screens/common/colors.dart';
import 'package:my_urban_care/model/order.dart';
import 'package:timelines/timelines.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the ordered list of statuses
    final List<String> orderedStatuses = [
      'Order Placed',
      'Packed',
      'Picked',
      'Delivered',
    ];

    // Determine the current status index
    final currentStatus = order.status;
    int currentStatusIndex = orderedStatuses.indexOf(currentStatus);
    if (currentStatusIndex == -1)
      currentStatusIndex = 0; // Default to first status if not found

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order #${order.orderNumber} Details',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure full width
          children: [
            // Container for Order Summary
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Summary',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: secondary),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order Number:',
                            style: TextStyle(fontSize: 16)),
                        Text(order.orderNumber,
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Date of Pickup:',
                            style: TextStyle(fontSize: 16)),
                        Text(order.dateOfPickup,
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Time:', style: TextStyle(fontSize: 16)),
                        Text(order.statusTimeline['deliveryTime'] ?? 'N/A',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Price:',
                            style: const TextStyle(fontSize: 16)),
                        Text("\₹${order.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10), // Space between containers

            // Container for Order Details
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: secondary),
                    ),
                    const SizedBox(height: 10),
                    // Assuming the details contain product names and their respective quantities
                    _buildProductDetail('Product Name 1', 2, 10.00),
                    _buildProductDetail('Product Name 2', 1, 15.00),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price of All Products:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '\₹ ${order.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10), // Space between containers

            // Container for Delivery Address
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Address',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: secondary),
                    ),
                    const SizedBox(height: 10),
                    Text('Address Line 1: 123 Main St',
                        style: const TextStyle(fontSize: 16)),
                    Text('Address Line 2: Apt 4B',
                        style: const TextStyle(fontSize: 16)),
                    Text('City: Springfield',
                        style: const TextStyle(fontSize: 16)),
                    Text('State: IL', style: const TextStyle(fontSize: 16)),
                    Text('Zip Code: 62701',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10), // Space between containers

            // Order Status Timeline
            const Text(
              'Status Of Your Order',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: secondary),
            ),
            const SizedBox(height: 8),
            _buildStatusTimeline(
              orderedStatuses,
              order.statusTimeline,
              currentStatusIndex,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build product detail widget
  Widget _buildProductDetail(String productName, int quantity, double price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productName,
              style: const TextStyle(fontSize: 16),
            ),
            Text('$quantity', style: const TextStyle(fontSize: 14)),
            Text('Price: \₹ ${(quantity * price).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14)),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // Widget to build the status timeline using the timelines package
  // Widget to build the status timeline using the timelines package
  Widget _buildStatusTimeline(
      List<String> orderedStatuses,
      Map<String, String> statusTimeline,
      int currentStatusIndex,
      ) {
    return FixedTimeline.tileBuilder(
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: orderedStatuses.length,
        contentsAlign: ContentsAlign.basic, // Ensure text is left-aligned
        contentsBuilder: (context, index) {
          final status = orderedStatuses[index];
          final timestamp = statusTimeline[status] ?? 'N/A';
          bool isCompleted = index < currentStatusIndex;
          bool isCurrent = index == currentStatusIndex;

          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 24.0), // Left padding for text to align
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                          color: isCurrent ? _getStatusColor(status) : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        timestamp,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        connectorBuilder: (_, index, ___) => SolidLineConnector(
          color: index < currentStatusIndex ? Colors.green : Colors.grey,
          thickness: 5,
        ),
        indicatorBuilder: (_, index) {
          if (index < currentStatusIndex) {
            return const DotIndicator(
              color: Colors.green,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
            );
          } else if (index == currentStatusIndex) {
            return DotIndicator(
              color: _getStatusColor(orderedStatuses[index]),
              child: Icon(
                _getStatusIcon(orderedStatuses[index]),
                color: Colors.white,
                size: 20,
              ),
            );
          } else {
            return const OutlinedDotIndicator(
              color: Colors.grey,
              borderWidth: 2,
            );
          }
        },
        indicatorPositionBuilder: (_, __) => 0.1, // Adjust indicator position to shift left
      ),
    );
  }




  // Helper method to get the color based on status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Order Placed':
        return Colors.blue;
      case 'Packed':
        return Colors.orange;
      case 'Picked':
        return Colors.purple;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Helper method to get the icon based on status
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Order Placed':
        return MdiIcons.cartOutline;
      case 'Packed':
        return MdiIcons.packageVariantClosed;
      case 'Picked':
        return MdiIcons.truckDelivery;
      case 'Delivered':
        return MdiIcons.home;
      default:
        return MdiIcons.helpCircle;
    }
  }
}
