import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/screens/membership/components/detaillevel_membership.dart';

class LabelTextLevel extends StatefulWidget {
  @override
  _LabelTextLevelState createState() => _LabelTextLevelState();
}

class _LabelTextLevelState extends State<LabelTextLevel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            indicator: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            tabs: [
              Tab(
                child: Text(
                  'Level 1',
                  style: GoogleFonts.ebGaramond(fontSize: 22),
                ),
              ),
              Tab(
                child: Text(
                  'Level 2',
                  style: GoogleFonts.ebGaramond(fontSize: 22),
                ),
              ),
              Tab(
                child: Text(
                  'Level 3',
                  style: GoogleFonts.ebGaramond(fontSize: 22),
                ),
              ),
            ],
          ),
          const SizedBox(height: 1),
          Container(
            width: 400,
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                const Center(child: DetailLevelMembership()),
                const Center(child: DetailLevelMembership()),
                const Center(child: DetailLevelMembership()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
