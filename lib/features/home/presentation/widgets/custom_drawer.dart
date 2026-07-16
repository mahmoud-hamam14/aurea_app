import 'package:flutter/material.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';

class DevDrawer extends StatelessWidget {
  const DevDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Developer Screen ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),



          ListTile(
            title: const Text('Admin Product Management'),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.adminManagement);
            },
          ),
        ],
      ),
    );
  }
}
