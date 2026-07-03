import 'package:flutter/material.dart';
import 'package:bookings_app/views/theme/color.dart';

// ---------------------------------------------------------------------------
// Model
// ---------------------------------------------------------------------------

enum OrderStatus { pending, awaiting, confirmed, delivered, cancelled }

class OrderStatusInfo {
  final String label;
  final Color badgeBg;
  final Color badgeFg;
  final Color cardAccent;
  final IconData icon;
  final bool showAccentBorder;
  final bool showBadgeBackground;

  const OrderStatusInfo({
    required this.label,
    required this.badgeBg,
    required this.badgeFg,
    required this.cardAccent,
    required this.icon,
    this.showAccentBorder = true,
    this.showBadgeBackground = true,
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
    badgeFg: Color.fromARGB(255, 40, 137, 217),
    cardAccent: Color.fromARGB(255, 92, 110, 246),
    icon: Icons.credit_card_rounded,
  ),
  OrderStatus.confirmed: OrderStatusInfo(
    label: 'Confirmed',
    badgeBg: AppColors.greenBg,
    badgeFg: AppColors.green,
    cardAccent: AppColors.green,
    icon: Icons.check_circle_outline_rounded,
  ),
  OrderStatus.delivered: OrderStatusInfo(
    label: 'Delivered',
    badgeBg: Colors.transparent,
    badgeFg: AppColors.purpleDark,
    cardAccent: Colors.transparent,
    icon: Icons.local_shipping_rounded,
    showAccentBorder: false,
    showBadgeBackground: false,
  ),
  OrderStatus.cancelled: OrderStatusInfo(
    label: 'Cancelled',
    badgeBg: AppColors.redBg,
    badgeFg: AppColors.red,
    cardAccent: AppColors.red,
    icon: Icons.cancel_rounded,
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
  final String? addon;

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
    this.addon,
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
  OrderTab('Delivered', OrderStatus.delivered),
  OrderTab('Cancelled', OrderStatus.cancelled),
];

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

class OrderProvider2 extends ChangeNotifier {
  OrderProvider2() {
    _orders = _mockOrders;
    // DJ Night Experience starts collapsed, matching the reference design.
    _collapsed.add('GP-20074');
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
  int _activeTab = 0;
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

  // -- actions --
  void payNow(String orderId) {
    // TODO: hook up to payment flow
  }

  void rebook(String orderId) {
    // TODO: hook up to rebooking flow
  }

  void leaveReview(String orderId) {
    // TODO: hook up to review flow
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
    ),
    Order1(
      id: 'GP-20365',
      status: OrderStatus.awaiting,
      imagepath: 'assets/images/royal.jpg',
      title: 'Royal Wedding Hall Package',
      vendor: 'Bloom & Petal Events',
      rating: 4.8,
      total: 'AED 6,500',
      orderDate: '8 Jul 2025',
      eventDate: '22 Aug 2025',
      guests: '120 people',
      addon: 'Photo Booth',
    ),
    Order1(
      id: 'GP-20290',
      status: OrderStatus.delivered,
      imagepath: 'assets/images/summit.jpg',
      title: 'Kids Fun Zone Package',
      vendor: 'WonderKids UAE',
      rating: 4.7,
      total: 'AED 1,550',
      orderDate: '2 Jul 2025',
      eventDate: '10 Jul 2025',
      guests: '25 people',
    ),
    Order1(
      id: 'GP-20074',
      status: OrderStatus.delivered,
      imagepath: 'assets/images/summit.jpg',
      title: 'DJ Night Experience',
      vendor: 'EliteSoundDJ',
      rating: 4.9,
      total: 'AED 2,150',
      orderDate: '19 Jun 2025',
      eventDate: '25 Jun 2025',
      guests: '—',
    ),
    Order1(
      id: 'GP-19941',
      status: OrderStatus.cancelled,
      imagepath: 'assets/images/summit.jpg',
      title: 'Grand Feast Catering',
      vendor: 'Grand Feast Co.',
      rating: 4.8,
      total: 'AED 2,900',
      orderDate: '10 Jun 2025',
      eventDate: '18 Jun 2025',
      guests: '45 people',
    ),
   
  ];
}