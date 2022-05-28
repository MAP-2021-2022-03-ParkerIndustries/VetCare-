import 'package:flutter/material.dart';
import 'package:vetclinic/ui/screen/customer_home/customer_home_view.dart';
import 'package:vetclinic/ui/screen/history/history_view.dart';
import 'package:vetclinic/utils/app_theme.dart';

class CustomerNavView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const CustomerNavView());
  const CustomerNavView({Key? key}) : super(key: key);

  @override
  State<CustomerNavView> createState() => _CustomerNavViewState();
}

class _CustomerNavViewState extends State<CustomerNavView> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const CustomerHomeView(),
    const HistoryView(),
  ];

  void _onItemTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: bottomNav,
    );
  }

  Widget get bottomNav {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppTheme.primary,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
              backgroundColor: AppTheme.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: "History",
              backgroundColor: AppTheme.primary,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedFontSize: 13.0,
          unselectedFontSize: 13.0,
        ),
      ),
    );
  }
}
