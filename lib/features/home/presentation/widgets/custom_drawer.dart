import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';

class DevDrawer extends StatelessWidget {
  const DevDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Drawer(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  bottom: BorderSide(color: theme.dividerColor, width: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'AUREA',
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Developer & Navigation',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            _buildTile(
              context,
              icon: Icons.dashboard_outlined,
              title: s.adminPanel,
              route: AppRoutes.adminManagement,
            ),
            _buildTile(
              context,
              icon: Icons.inventory_2_outlined,
              title: s.allProducts,
              route: AppRoutes.productListing,
            ),
            _buildTile(
              context,
              icon: Icons.info_outline,
              title: s.aboutUs,
              route: AppRoutes.aboutUs,
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                "QUICK LINKS",
                style: theme.textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.2,
                  color: Colors.grey,
                ),
              ),
            ),
            _buildTile(
              context,
              icon: Icons.security_outlined,
              title: s.privacyPolicy,
              route: AppRoutes.privacyPolicy,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context,
      {required IconData icon, required String title, required String route}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 22.sp),
      title: Text(
        title,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer
        Navigator.pushNamed(context, route);
      },
    );
  }
}
