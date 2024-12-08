import 'package:flutter/material.dart';
import 'package:school_management_system/Login.dart';
import 'package:school_management_system/main.dart';
import 'package:school_management_system/utils/Clip.dart';
import 'package:school_management_system/utils/theme.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController = new TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blue Background with Rounded Bottom
          ClipPath(
            clipper: BlueBackgroundClipper(),
            child: Container(
              height: 300, // Adjust height as needed
              color: ColorTheme().PRIMARY_COLOR,
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.only(top: 8.pt),
            child: ListView(
              children: [
                // Title Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Darshan University",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Login to your account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Login Form
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TabBar(
                          controller: _tabController,
                          dividerHeight: 0,
                          labelColor: Colors.white,
                          indicatorColor: Colors.red,
                          indicator: BoxDecoration(
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorTheme().PRIMARY_COLOR,
                                  spreadRadius: 3,
                                  blurRadius: 8,
                                  blurStyle: BlurStyle.inner,
                                ),
                              ]),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(
                              text: "Login",
                            ),
                            Tab(
                              text: "Login With OTP",
                            ),
                          ]),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Container(
                        height: 27.h,
                        child: TabBarView(
                          controller: _tabController,
                          children: [Login(), Login()],
                        ),
                      ),
                      // Remember Me and Login Button
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}