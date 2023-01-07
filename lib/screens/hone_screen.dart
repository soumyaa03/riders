import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders/screens/approved_riders_screen.dart';
import 'package:riders/screens/unapproved_riders_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<Tab> topTabs = <Tab>[
    const Tab(text: 'UNAPPROVED RIDERS'),
    const Tab(text: 'APROVED RIDERS')
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, initialIndex: 1, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Riders',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.left,
          ),
          elevation: 0,
          backgroundColor: Colors.grey,
          bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.blue,
              tabs: topTabs),
        ),
        body: TabBarView(controller: _tabController, children: const [
          UnapprovedRiderScreen(),
          ApprovedRiderScreen(),
        ]));
  }
}
