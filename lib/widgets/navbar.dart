import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const Navbar({Key? key, required this.selectedIndex, required this.onItemTapped})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade400,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 35),
            activeIcon: Icon(Icons.home_outlined, size: 35),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined, size: 35),
            activeIcon: Icon(Icons.calendar_today_outlined, size: 35),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined, size: 35),
            activeIcon: Icon(Icons.notifications_outlined, size: 35),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 35),
            activeIcon: Icon(Icons.settings_outlined, size: 35),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}
