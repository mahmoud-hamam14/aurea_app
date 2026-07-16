import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_ecommerce_team4/core/network/dio_helper.dart';
import 'package:nti_ecommerce_team4/core/theme/theme_provider.dart';
import 'package:nti_ecommerce_team4/core/theme/app_theme.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'package:nti_ecommerce_team4/core/routes/app_router.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const AureaApp(),
    ),
  );
}

class AureaApp extends StatelessWidget {
  const AureaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return ScreenUtilInit(
      designSize: kIsWeb ? const Size(1440, 1024) : const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeProvider.themeMode,
          locale: themeProvider.locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRoutes.splash,
        );
      },
    );
  }
}
