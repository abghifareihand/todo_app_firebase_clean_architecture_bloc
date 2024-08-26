import 'package:flutter/material.dart';
import 'package:todo_app/core/extension/nav_ext.dart';
import 'package:todo_app/features/todo/presentation/pages/add_todo_page.dart';
import 'package:todo_app/features/todo/presentation/pages/home_page.dart';
import 'package:todo_app/features/todo/presentation/pages/profile_page.dart';
import 'package:todo_app/features/todo/presentation/pages/schedule_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SchedulePage(),
    const Center(
      child: Text('History Page'),
    ),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              title: 'Home',
              icon: Icons.home,
              onTap: () => _onItemTapped(0),
              isSelected: _selectedIndex == 0,
            ),
            BottomNavItem(
              title: 'Scedule',
              icon: Icons.calendar_month_rounded,
              onTap: () => _onItemTapped(1),
              isSelected: _selectedIndex == 1,
            ),
            const SizedBox(
              width: 40.0,
            ),
            BottomNavItem(
              title: 'Setting',
              icon: Icons.settings,
              onTap: () => _onItemTapped(2),
              isSelected: _selectedIndex == 2,
            ),
            BottomNavItem(
              title: 'Profile',
              icon: Icons.person,
              onTap: () => _onItemTapped(3),
              isSelected: _selectedIndex == 3,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              context.push(const AddTodoPage());
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const BottomNavItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 2,
            width: 34,
            color: isSelected ? Colors.blue : Colors.transparent,
          ),
          const SizedBox(
            height: 6.0,
          ),
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(
            height: 2.0,
          ),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
