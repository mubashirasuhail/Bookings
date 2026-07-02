import 'package:bookings_app/header.dart';
import 'package:flutter/material.dart';


// ---------------------------------------------------------------------------
// Design tokens
// ---------------------------------------------------------------------------

class AppColors {
  static const purple = Color(0xFF8B5CF6);
  static const purpleDark = Color(0xFF6D28D9);
  static const purpleDeep = Color(0xFF5B21B6);
  static const pink = Color(0xFFC026D3);
  static const orange = Color(0xFFF97316);
  static const orangeBg = Color(0xFFFEF1E6);
  static const green = Color(0xFF16A34A);
  static const greenBg = Color(0xFFE9F8EE);
  static const red = Color(0xFFD1483F);
  static const redBg = Color(0xFFFCEAE8);
  static const awaitingBg = Color(0xFFF3EBFF);
  static const ink = Color(0xFF1A1A2E);
  static const sub = Color(0xFF8B8B9C);
  static const line = Color(0xFFEFEFF4);
  static const cardBg = Colors.white;
  static const pageBg = Color(0xFFF7F7FA);
  static const chipBg = Color(0xFFEFEFF4);
}

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

class Order {
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

  const Order({
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

final List<Order> kOrders = [
  Order(
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
    footerFg: const Color(0xFF6B6B7B),
  ),
  Order(
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
  Order(
    id: 'GP-20175',
    status: OrderStatus.declined,
      imagepath: 'assets/images/summit.jpg',
    title: 'Birthday Bash Decor',
    vendor: 'Sparkle Studio Dubai',
    rating: 4.6,
    total: 'AED 2,300',
    orderDate: '15 Jun 2025',
    eventDate: '22 Jun 2025',
    guests: '40 people',
    addon: 'Balloon Arch',
    footer: 'Vendor Unavailable for This Date',
    footerBg: AppColors.redBg,
    footerFg: AppColors.red,
  ),
  Order(
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
  Order(
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
 
  Order(
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

// ---------------------------------------------------------------------------
// Tabs
// ---------------------------------------------------------------------------

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
// Page
// ---------------------------------------------------------------------------

class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({super.key});

  @override
  State<AllOrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<AllOrdersPage> {
    int _selectedBottomIndex = 3;
  int _activeTab = 1; // starts on "Pending", matching the reference screen
  final Set<String> _collapsed = {};
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  int _countFor(OrderStatus? status) {
    if (status == null) return kOrders.length;
    return kOrders.where((o) => o.status == status).length;
  }

  List<Order> get _filteredOrders {
    final status = kTabs[_activeTab].status;
    return kOrders.where((o) {
      final matchesTab = status == null || o.status == status;
      final matchesQuery = _query.isEmpty ||
          o.title.toLowerCase().contains(_query) ||
          o.vendor.toLowerCase().contains(_query) ||
          o.id.toLowerCase().contains(_query);
      return matchesTab && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = _filteredOrders;

    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
               Header(),
                _buildSearch(),
                _buildTabs(),
                Expanded(
                  child: orders.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                          itemCount: orders.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) =>
                              _OrderCard(
                            order: orders[index],
                            expanded: !_collapsed.contains(orders[index].id),
                            onToggle: () {
                              setState(() {
                                final id = orders[index].id;
                                if (_collapsed.contains(id)) {
                                  _collapsed.remove(id);
                                } else {
                                  _collapsed.add(id);
                                }
                              });
                            },
                          ),
                        ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Orders Detail',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${kOrders.length} orders in total',
            style: const TextStyle(fontSize: 13, color: AppColors.sub),
          ),
        ],
      ),
    );
  }

  
  Widget _buildSearch() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8E8EE), width: 1),
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
          decoration: InputDecoration(
            hintText: 'Search package, vendor or Order ID..',
            hintStyle: TextStyle(
              fontSize: 13,
              color: Colors.grey[400],
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.grey[400],
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        itemCount: kTabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tab = kTabs[index];
          final active = index == _activeTab;
          return GestureDetector(
            onTap: () => setState(() => _activeTab = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              decoration: BoxDecoration(
                color: active ? AppColors.purple : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: active ? AppColors.purple : AppColors.line,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tab.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: active ? Colors.white : const Color(0xFF6B6B7B),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: active
                          ? Colors.white.withOpacity(0.25)
                          : Colors.black.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_countFor(tab.status)}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: active ? Colors.white : const Color(0xFF6B6B7B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.folder_open_rounded, size: 40, color: AppColors.sub),
          SizedBox(height: 10),
          Text(
            'No orders in this category yet.',
            style: TextStyle(fontSize: 13, color: AppColors.sub),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Bottombar();
  }

  BottomAppBar Bottombar() {
    return BottomAppBar(
    shape: const CircularNotchedRectangle(),
    notchMargin: 0,
    elevation: 12,
    shadowColor: Colors.black26,
    color: const Color(0xFF7C3AED),
    child: SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, 'Home', 0),
          _buildNavItem(Icons.celebration, 'Parties', 1),
          const SizedBox(width: 52), // Space for FAB
          _buildNavItem(Icons.calendar_month_outlined, 'Bookings', 3),
          _buildNavItem(Icons.settings, 'Settings', 4),
        ],
      ),
    ),
  );
  }
    Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedBottomIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBottomIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected
                  ? const Color.fromARGB(255, 252, 252, 252)
                  : const Color(0xFFAAAAAA),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : const Color(0xFFAAAAAA),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

// ---------------------------------------------------------------------------
// Order card
// ---------------------------------------------------------------------------

class _OrderCard extends StatelessWidget {
  final Order order;
  final bool expanded;
  final VoidCallback onToggle;

  const _OrderCard({
    required this.order,
    required this.expanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final info = kStatusInfo[order.status]!;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border(top: BorderSide(color: info.cardAccent, width: 3)),
        boxShadow: const [
          BoxShadow(color: Color(0x0D141432), blurRadius: 6, offset: Offset(0, 1)),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [AppColors.purple, AppColors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Image.asset(
    order. imagepath,
    width: 80,
    height: 80,
    fit: BoxFit.cover,
  ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.id,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.sub,
                          ),
                        ),
                        _StatusBadge(info: info),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_rounded,
                            size: 13, color: AppColors.green),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            order.vendor,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.purpleDark,
                            ),
                          ),
                        ),
                        const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                        const SizedBox(width: 2),
                        Text(
                          order.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.sub,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.line),
          const SizedBox(height: 12),
          Row(
            children: [
              _Stat(label: 'Total Paid', value: order.total, accent: true),
              _Stat(label: 'Order Date', value: order.orderDate),
              _Stat(label: 'Event Date', value: order.eventDate),
            ],
          ),
          GestureDetector(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    expanded ? 'Hide details' : 'Show details',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.purpleDark,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 150),
                    child: const Icon(Icons.keyboard_arrow_down_rounded,
                        size: 16, color: AppColors.purpleDark),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 150),
            child: expanded
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        _DetailRow(label: 'Guests', value: order.guests),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Add-ons',
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.sub)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.awaitingBg,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                order.addon,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.purpleDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: order.footerBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              order.footer,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: order.footerFg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatusInfo info;
  const _StatusBadge({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: info.badgeBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(info.icon, size: 11, color: info.badgeFg),
          const SizedBox(width: 4),
          Text(
            info.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: info.badgeFg,
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final bool accent;

  const _Stat({required this.label, required this.value, this.accent = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppColors.sub,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: accent ? 14 : 13,
              fontWeight: FontWeight.w700,
              color: accent ? AppColors.purpleDark : AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.sub)),
          Text(value,
              style: const TextStyle(
                  fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.ink)),
        ],
      ),
    );
  }
}