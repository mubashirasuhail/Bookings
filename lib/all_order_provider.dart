import 'package:flutter/material.dart';
import 'package:bookings_app/color.dart';

// ---------------------------------------------------------------------------
// Model
// ---------------------------------------------------------------------------

enum OrderStatus { pending, awaiting, confirmed, declined }

class OrderStatusInfo {
  final String label;
  final Color badgeBg;
  final Color badgeFg;
  final Color cardAccent;
  final IconData icon;

  const OrderStatusInfo({
    required this.label,
    required this.badgeBg,
    required this.badgeFg,
    required this.cardAccent,
    required this.icon,
  });
}

const Map<OrderStatus, OrderStatusInfo> kStatusInfo = {
  OrderStatus.pending: OrderStatusInfo(
    label: 'Pending',
    badgeBg: AppColors.orangeBg,
    badgeFg: AppColors.orange,
    cardAccent: AppColors.orange,
    icon: Icons.access_time_rounded,
  ),
  OrderStatus.awaiting: OrderStatusInfo(
    label: 'Awaiting Payment',
    badgeBg: AppColors.awaitingBg,
    badgeFg: AppColors.purpleDark,
    cardAccent: AppColors.purple,
    icon: Icons.account_balance_wallet_outlined,
  ),
  OrderStatus.confirmed: OrderStatusInfo(
    label: 'Confirmed',
    badgeBg: AppColors.greenBg,
    badgeFg: AppColors.green,
    cardAccent: AppColors.green,
    icon: Icons.check_circle_outline_rounded,
  ),
  OrderStatus.declined: OrderStatusInfo(
    label: 'Declined',
    badgeBg: AppColors.redBg,
    badgeFg: AppColors.red,
    cardAccent: AppColors.red,
    icon: Icons.cancel_outlined,
  ),
};

class Order1 {
  final String id;
  final OrderStatus status;
  final String imagepath;
  final String title;
  final String vendor;
  final double rating;
  final String total;
  final String orderDate;
  final String eventDate;
  final String guests;
  final String addon;
  final String footer;
  final Color footerBg;
  final Color footerFg;

  const Order1({
    required this.id,
    required this.status,
    required this.imagepath,
    required this.title,
    required this.vendor,
    required this.rating,
    required this.total,
    required this.orderDate,
    required this.eventDate,
    required this.guests,
    required this.addon,
    required this.footer,
    required this.footerBg,
    required this.footerFg,
  });
}

class OrderTab {
  final String label;
  final OrderStatus? status; // null = "All"

  const OrderTab(this.label, this.status);
}

const List<OrderTab> kTabs = [
  OrderTab('All', null),
  OrderTab('Pending', OrderStatus.pending),
  OrderTab('Awaiting Payment', OrderStatus.awaiting),
  OrderTab('Declined', OrderStatus.declined),
];

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

class OrderProvider2 extends ChangeNotifier {
  OrderProvider2() {
    _orders = _mockOrders;
  }

  late final List<Order1> _orders;

  // -- bottom nav --
  int _selectedBottomIndex = 3;
  int get selectedBottomIndex => _selectedBottomIndex;

  void selectBottomIndex(int index) {
    if (_selectedBottomIndex == index) return;
    _selectedBottomIndex = index;
    notifyListeners();
  }

  // -- tabs --
  int _activeTab = 1; // starts on "Pending"
  int get activeTab => _activeTab;

  void selectTab(int index) {
    if (_activeTab == index) return;
    _activeTab = index;
    notifyListeners();
  }

  // -- search --
  String _query = '';
  String get query => _query;

  void updateQuery(String value) {
    _query = value.toLowerCase();
    notifyListeners();
  }

  // -- collapsed / expanded card state --
  final Set<String> _collapsed = {};

  bool isExpanded(String orderId) => !_collapsed.contains(orderId);

  void toggleExpanded(String orderId) {
    if (_collapsed.contains(orderId)) {
      _collapsed.remove(orderId);
    } else {
      _collapsed.add(orderId);
    }
    notifyListeners();
  }

  // -- derived data --
  List<Order1> get allOrders => _orders;

  int countFor(OrderStatus? status) {
    if (status == null) return _orders.length;
    return _orders.where((o) => o.status == status).length;
  }

  List<Order1> get filteredOrders {
    final status = kTabs[_activeTab].status;
    return _orders.where((o) {
      final matchesTab = status == null || o.status == status;
      final matchesQuery = _query.isEmpty ||
          o.title.toLowerCase().contains(_query) ||
          o.vendor.toLowerCase().contains(_query) ||
          o.id.toLowerCase().contains(_query);
      return matchesTab && matchesQuery;
    }).toList();
  }

  static final List<Order1> _mockOrders = [
    Order1(
      id: 'GP-20188',
      status: OrderStatus.pending,
      imagepath: 'assets/images/summit.jpg',
      title: 'Corporate Summit Package',
      vendor: 'EliteVenues Dubai',
      rating: 4.9,
      total: 'AED 4,200',
      orderDate: '28 Jun 2025',
      eventDate: '5 Jul 2025',
      guests: '80 people',
      addon: 'Candy Station',
      footer: 'Waiting Vendor Confirmation',
      footerBg: AppColors.chipBg,
      footerFg: const Color.fromARGB(255, 163, 163, 241),
    ),
    Order1(
      id: 'GP-20192',
      status: OrderStatus.awaiting,
      imagepath: 'assets/images/royal.jpg',
      title: 'Royal Wedding Hall Package',
      vendor: 'Bloom & Petal Events',
      rating: 4.9,
      total: 'AED 6,500',
      orderDate: '8 July 2025',
      eventDate: '22 Aug 2025',
      guests: '120 people',
      addon: 'Photo Booth',
      footer: 'Complete Payment to Confirm',
      footerBg: AppColors.awaitingBg,
      footerFg: AppColors.purpleDark,
    ),
    Order1(
      id: 'GP-20175',
      status: OrderStatus.declined,
      imagepath: 'assets/images/summit.jpg',
      title: 'Grand Feast Catering',
      vendor: 'Grand Feast Co.',
      rating: 4.8,
      total: 'AED 2,900',
      orderDate: '10 Jun 2025',
      eventDate: '18 Jun 2025',
      guests: '45 people',
      addon: 'Balloon Arch',
      footer: 'Vendor Unavailable for This Date',
      footerBg: AppColors.redBg,
      footerFg: AppColors.red,
    ),
    Order1(
      id: 'GP-20201',
      status: OrderStatus.confirmed,
      imagepath: 'assets/images/summit.jpg',
      title: 'Product Launch Experience',
      vendor: 'Skyline Productions',
      rating: 4.9,
      total: 'AED 8,900',
      orderDate: '25 Jun 2025',
      eventDate: '10 Jul 2025',
      guests: '200 people',
      addon: 'LED Wall',
      footer: 'Vendor Confirmed - All Set',
      footerBg: AppColors.greenBg,
      footerFg: AppColors.green,
    ),
    Order1(
      id: 'GP-20166',
      status: OrderStatus.confirmed,
      imagepath: 'assets/images/summit.jpg',
      title: 'Live Music Night Package',
      vendor: 'Downtown Rooftop Co.',
      rating: 4.7,
      total: 'AED 6,750',
      orderDate: '12 Jun 2025',
      eventDate: '29 Jun 2025',
      guests: '120 people',
      addon: 'DJ Booth',
      footer: 'Vendor Confirmed - All Set',
      footerBg: AppColors.greenBg,
      footerFg: AppColors.green,
    ),
    Order1(
      id: 'GP-20140',
      status: OrderStatus.confirmed,
      imagepath: 'assets/images/summit.jpg',
      title: 'Garden Engagement Party',
      vendor: 'Green Terrace Events',
      rating: 4.8,
      total: 'AED 5,400',
      orderDate: '2 Jun 2025',
      eventDate: '14 Jun 2025',
      guests: '60 people',
      addon: 'Floral Arch',
      footer: 'Vendor Confirmed - All Set',
      footerBg: AppColors.greenBg,
      footerFg: AppColors.green,
    ),
  ];
}