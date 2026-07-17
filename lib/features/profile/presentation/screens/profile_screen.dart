import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nti_ecommerce_team4/core/theme/theme_provider.dart';
import 'package:nti_ecommerce_team4/features/profile/presentation/widgets/custom_widgets.dart';
import 'package:nti_ecommerce_team4/features/profile/presentation/widgets/dark_mode_toggle.dart';
import 'package:nti_ecommerce_team4/features/profile/presentation/widgets/logout_bottom.dart';
import 'package:nti_ecommerce_team4/features/profile/presentation/widgets/profile_header.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLanguageDialog(BuildContext context) {
    final s = S.of(context);
    final themeProvider = context.read<ThemeProvider>();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English"),
              trailing: themeProvider.locale.languageCode == 'en' ? Icon(Icons.check, color: Colors.orangeAccent) : null,
              onTap: () {
                themeProvider.setLocale('en');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("العربية"),
              trailing: themeProvider.locale.languageCode == 'ar' ? Icon(Icons.check, color: Colors.orangeAccent) : null,
              onTap: () {
                themeProvider.setLocale('ar');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          s.profile,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: [
          IconButton(icon: const Icon(Icons.shopping_bag), onPressed: () {}),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 700;
          
          return Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 650),
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 40 : 0,
                  vertical: isWide ? 40 : 0,
                ),
                child: Column(
                  children: [
                    const ProfileHeader(),
                    const Gap(20),
                    SectionCard(
                      title: s.accountSettings,
                      children: [
                        CustomListTile(icon: Icons.person, title: s.editProfile),
                        const Divider(
                          height: 1,
                          endIndent: 20,
                          indent: 20,
                          color: Colors.grey,
                        ),
                        CustomListTile(icon: Icons.lock, title: s.changePassword),
                        const Divider(
                          height: 1,
                          endIndent: 20,
                          indent: 20,
                          color: Colors.grey,
                        ),
                        const DarkModeToggle(),
                        const Divider(
                          height: 1,
                          endIndent: 20,
                          indent: 20,
                          color: Colors.grey,
                        ),
                        CustomListTile(
                          icon: Icons.language,
                          title: s.language,
                          subtitle: Localizations.localeOf(context).languageCode == 'en' ? "English" : "العربية",
                          onTap: () => _showLanguageDialog(context),
                        ),
                      ],
                    ),
                    const Gap(20),
                    SectionCard(
                      title: s.supportLegal,
                      children: [
                        CustomListTile(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.privacyPolicy);
                          },
                          icon: Icons.privacy_tip,
                          title: s.privacyPolicy,
                        ),
                        const Divider(
                          height: 1,
                          endIndent: 20,
                          indent: 20,
                          color: Colors.grey,
                        ),
                        CustomListTile(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.aboutUs);
                          },
                          icon: Icons.info,
                          title: s.aboutUs,
                        ),
                        const Divider(
                          height: 1,
                          endIndent: 20,
                          indent: 20,
                          color: Colors.grey,
                        ),
                        CustomListTile(
                          icon: Icons.contact_mail,
                          title: s.contactUs,
                        ),
                      ],
                    ),
                    const Gap(30),
                    LogoutButton(onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    }),
                    const Gap(50),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
