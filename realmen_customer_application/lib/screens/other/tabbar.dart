import 'package:flutter/material.dart';

class BottomTapBar extends StatelessWidget implements PreferredSizeWidget {
  const BottomTapBar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      dividerColor: Colors.transparent,
      labelColor: Colors.white,
      isScrollable: true,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2),
      ),
      tabs: [
        Tab(
          text: 'Phổ biến',
        ),
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.card_giftcard, size: 18),
              // const SizedBox(width: 8),
              Text('Policies'),
            ],
          ),
        ),
        Tab(
          text: 'Phổ biến',
        ),
        Tab(
          text: 'Phổ biến',
        ),
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.card_giftcard, size: 18),
              // const SizedBox(width: 8),
              Text('Policies'),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.card_giftcard, size: 18),
              // const SizedBox(width: 8),
              Text('Policies'),
            ],
          ),
        ),
      ],
    );
  }
}
