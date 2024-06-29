import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/app_provider.dart';

class NavMenu extends StatelessWidget {
  final AppProvider appProvider;

  const NavMenu({super.key, required this.appProvider});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 8,
          left: 8,
          bottom: 8,
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.pinkAccent
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tasks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              thickness: 1,
              color: Colors.pinkAccent,
            ),
            menuItem(
              context,
              'All Tasks',
              Icons.list_alt_rounded,
              Colors.grey,
            ),
            menuItem(
              context,
              'Pending Tasks',
              Icons.assignment_late_rounded,
              Colors.red,
            ),
            menuItem(
              context,
              'Done Tasks',
              Icons.done,
              Colors.green,
            ),
            menuItem(
              context,
              'Due Today',
              Icons.sunny,
              Colors.yellow,
            ),
            menuItem(
              context,
              'Due This Month',
              Icons.calendar_month,
              Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}

Widget menuItem(
    BuildContext context, String title, IconData icon, Color iconColor) {
  return Consumer<AppProvider>(
    builder: (context, appProvider, child) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          print(title);
          appProvider.shownPage = title;
          appProvider.notifyListeners();
          Navigator.pop(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 20,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
