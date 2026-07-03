import 'package:bookings_app/all_order_provider.dart';
import 'package:bookings_app/color.dart';
import 'package:bookings_app/fab.dart';
import 'package:bookings_app/header.dart';

import 'package:bookings_app/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllOrdersPage2 extends StatefulWidget {
  const AllOrdersPage2({super.key});

  @override
  State<AllOrdersPage2> createState() => _AllOrdersPage2State();
}

class _AllOrdersPage2State extends State<AllOrdersPage2> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    context.read<OrderProvider2>().updateQuery(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            OrderSearchBar(searchController: _searchController),
            const _TabsBar(),
            const Expanded(child: _OrdersList()),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomBar(),
      floatingActionButton: Fab(
        //onTap: () {}
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// ---------------------------------------------------------------------------
// Tabs
// ---------------------------------------------------------------------------

class _TabsBar extends StatelessWidget {
  const _TabsBar();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider2>();

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        itemCount: kTabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tab = kTabs[index];
          final active = index == provider.activeTab;
          return GestureDetector(
            onTap: () => context.read<OrderProvider2>().selectTab(index),
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
                      '${provider.countFor(tab.status)}',
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
}

// ---------------------------------------------------------------------------
// List + empty state
// ---------------------------------------------------------------------------

class _OrdersList extends StatelessWidget {
  const _OrdersList();

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider2>().filteredOrders;

    if (orders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_open_rounded, size: 40, color: AppColors.sub),
            SizedBox(height: 10),
            Text('No orders in this category yet.',
                style: TextStyle(fontSize: 13, color: AppColors.sub)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) => _OrderCard(order: orders[index]),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom nav
// ---------------------------------------------------------------------------

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider2>();

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
            _NavItem(icon: Icons.home_outlined, label: 'Home', index: 0, provider: provider),
            _NavItem(icon: Icons.celebration, label: 'Parties', index: 1, provider: provider),
            const SizedBox(width: 52),
            _NavItem(icon: Icons.calendar_month_outlined, label: 'Bookings', index: 3, provider: provider),
            _NavItem(icon: Icons.settings, label: 'Settings', index: 4, provider: provider),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final OrderProvider2 provider;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.selectedBottomIndex == index;
    return GestureDetector(
      onTap: () => context.read<OrderProvider2>().selectBottomIndex(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: isSelected ? Colors.white : const Color(0xFFAAAAAA)),
            const SizedBox(height: 3),
            Text(label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFFAAAAAA),
                )),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Order card — layout + footer change per status, matching each screenshot
// ---------------------------------------------------------------------------

class _OrderCard extends StatelessWidget {
  final Order1 order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final info = kStatusInfo[order.status]!;
    final expanded = context.select<OrderProvider2, bool>(
      (p) => p.isExpanded(order.id),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: info.showAccentBorder
            ? Border(top: BorderSide(color: info.cardAccent, width: 3))
            : null,
        boxShadow: const [
          BoxShadow(color: Color(0x0D141432), blurRadius: 6, offset: Offset(0, 1)),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(order: order, info: info),
          if (expanded) ...[
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
          ],
          _ToggleRow(orderId: order.id, expanded: expanded),
          if (expanded) ...[
            AnimatedSize(
              duration: const Duration(milliseconds: 150),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    _DetailRow(label: 'Guests', value: order.guests),
                    if (order.addon != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Add-ons',
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.sub)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.awaitingBg,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                order.addon!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.purpleDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _CardFooter(order: order),
          ],
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final Order1 order;
  final OrderStatusInfo info;
  const _CardHeader({required this.order, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(order.imagepath, width: 56, height: 56, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.id,
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.sub)),
                  _StatusBadge(info: info),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                order.title,
                style: const TextStyle(
                    fontSize: 14.5, fontWeight: FontWeight.w700, color: AppColors.ink, height: 1.3),
              ),
              const SizedBox(height: 4),
             Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        const Icon(Icons.check_circle_outline_outlined, size: 13, color: AppColors.purpleDark),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            order.vendor,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.purpleDark),
          ),
        ),
      ],
    ),
    const SizedBox(height: 4),
    Row(
      children: [
        const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
        const SizedBox(width: 2),
        Text(
          order.rating.toStringAsFixed(1),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.sub),
        ),
      ],
    ),
  ],
),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatusInfo info;
  const _StatusBadge({required this.info});

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(info.icon, size: 12, color: info.badgeFg),
        const SizedBox(width: 4),
        Text(info.label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: info.badgeFg)),
      ],
    );

    if (!info.showBadgeBackground) return content;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(color: info.badgeBg, borderRadius: BorderRadius.circular(20)),
      child: content,
    );
  }
}

// ---------------------------------------------------------------------------
// Toggle row — "Hide details" (down) vs "View details" (right), per screenshots
// ---------------------------------------------------------------------------

class _ToggleRow extends StatelessWidget {
  final String orderId;
  final bool expanded;
  const _ToggleRow({required this.orderId, required this.expanded});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<OrderProvider2>().toggleExpanded(orderId),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              expanded ? 'Hide details' : 'View details',
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.purpleDark),
            ),
            const SizedBox(width: 4),
            AnimatedRotation(
              turns: expanded ? 0 : -0.25,
              duration: const Duration(milliseconds: 150),
              child: const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.purpleDark),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer — different per status, matching each screenshot exactly
// ---------------------------------------------------------------------------

class _CardFooter extends StatelessWidget {
  final Order1 order;
  const _CardFooter({required this.order});

  @override
  Widget build(BuildContext context) {
    switch (order.status) {
      case OrderStatus.pending:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.chipBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Waiting Vendor Confirmation',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.purpleDark),
          ),
        );

      case OrderStatus.awaiting:
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: _PrimaryButton(
                label: 'Pay Now',
                onTap: () => context.read<OrderProvider2>().payNow(order.id),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SecondaryButton(
                label: 'My Party Plan',
                onTap: () {},
              ),
            ),
          ],
        );

      case OrderStatus.delivered:
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: _PrimaryButton(
                label: 'Leave Review',
                onTap: () => context.read<OrderProvider2>().leaveReview(order.id),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SecondaryButton(
                label: 'My Party Plan',
                onTap: () {},
              ),
            ),
          ],
        );

      case OrderStatus.cancelled:
        return Row(
          children: [
            Expanded(
              child: _OutlineIconButton(
                label: 'Rebook',
                icon: Icons.refresh_rounded,
                onTap: () => context.read<OrderProvider2>().rebook(order.id),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SecondaryButton(
                label: 'My Party Plan',
                onTap: () {},
              ),
            ),
          ],
        );

      case OrderStatus.confirmed:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.greenBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Vendor Confirmed - All Set',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.green),
          ),
        );
    }
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          height: 42,
       decoration: BoxDecoration(
  color: const Color(0xFF2563EB), // blue
  borderRadius: BorderRadius.circular(12),
),
          child: Center(
            child: Text(label,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SecondaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.chipBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(label,
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.sub)),
        ),
      ),
    );
  }
}

class _OutlineIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _OutlineIconButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.awaitingBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15, color: AppColors.purpleDark),
              const SizedBox(width: 6),
              Text(label,
                  style: const TextStyle(
                      fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.purpleDark)),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small shared widgets
// ---------------------------------------------------------------------------

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
          Text(label.toUpperCase(),
              style: const TextStyle(
                  fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.sub, letterSpacing: 0.3)),
          const SizedBox(height: 2),
          Text(value,
              style: TextStyle(
                  fontSize: accent ? 14 : 13,
                  fontWeight: FontWeight.w700,
                  color: accent ? AppColors.purpleDark : AppColors.ink)),
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
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.sub)),
          Text(value,
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.ink)),
        ],
      ),
    );
  }
}