import 'package:flutter/material.dart';
import 'package:bookings_app/models/model_class.dart';

/// Holds all state that used to live inside [OrderListScreen]'s
/// State object: the list of orders and the selected bottom-nav tab.
class OrderProvider extends ChangeNotifier {
  int _selectedBottomIndex = 3;
  int get selectedBottomIndex => _selectedBottomIndex;

  void selectBottomIndex(int index) {
    if (_selectedBottomIndex == index) return;
    _selectedBottomIndex = index;
    notifyListeners();
  }

  final List<OrderModel> _orders = const [
    OrderModel(
      orderId: 'PartPop UAE',
      price: 850,
      status: 'Pending',
      statusColor: Color(0xFFEA8C00),
      statusBgColor: Color(0xFFFFF3DC),
      statusIcon: Icons.access_time_rounded,
      imagePath: 'assets/images/bday.jpg',
      title: 'Gold Birthday Bash Package',
      categories: ['Decor', 'Catering', 'Photography'],
    ),
    OrderModel(
      orderId: 'PartPop UAE',
      price: 850,
      status: 'Confirmed',
      statusColor: Color(0xFF16A34A),
      statusBgColor: Color(0xFFDCFCE7),
      statusIcon: Icons.check_circle_rounded,
      imagePath: 'assets/images/bday.jpg',
      title: 'Gold Birthday Bash Package',
      categories: ['Decor', 'Catering', 'Photography'],
    ),
    OrderModel(
      orderId: 'PartPop UAE',
      price: 850,
      status: 'Awaiting Payment',
      statusColor: Color(0xFF2563EB),
      statusBgColor: Color(0xFFDBEAFE),
      statusIcon: Icons.payments_rounded,
      imagePath: 'assets/images/bday.jpg',
      title: 'Gold Birthday Bash Package',
      categories: ['Decor', 'Catering', 'Photography'],
    ),
    OrderModel(
      orderId: 'PartPop UAE',
      price: 850,
      status: 'Delivered',
      statusColor: Color(0xFF6B7280),
      statusBgColor: Color(0xFFF3F4F6),
      statusIcon: Icons.local_shipping_rounded,
      imagePath: 'assets/images/bday.jpg',
      title: 'Gold Birthday Bash Package',
      categories: ['Decor', 'Catering', 'Photography'],
    ),
  ];
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<OrderModel> get orders {
    if (_searchQuery.trim().isEmpty) return _orders;
    final query = _searchQuery.toLowerCase();
    return _orders.where((order) {
      return order.title.toLowerCase().contains(query) ||
          order.orderId.toLowerCase().contains(query) ||
          order.status.toLowerCase().contains(query);
    }).toList();
  }

  int get orderCount => _orders.length; // total, unaffected by search
}