import 'package:flutter/material.dart';
import 'package:school_management_system/utils/theme.dart';
import 'package:sizer/sizer.dart';

import 'Dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, p2) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              cardTheme: CardTheme(
                color: Colors.white,
                elevation: 5,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              scaffoldBackgroundColor: Colors.grey.shade200,
              appBarTheme: AppBarTheme(
                  color: ColorTheme().PRIMARY_COLOR,
                  titleTextStyle:
                      TextStyle(color: Colors.white, fontSize: 19.sp),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  )),
              useMaterial3: true,
            ),
            // home: Home(),
            home: DashboardScreen());
      },
    );
  }
}
