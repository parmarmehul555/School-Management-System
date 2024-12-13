import 'package:flutter/material.dart';
import 'package:school_management_system/Home.dart';
import 'package:school_management_system/Pending_Remuneration.dart';
import 'package:school_management_system/RR_Distribution.dart';
import 'package:school_management_system/Remuneration.dart';
import 'package:school_management_system/Seminar_Conduct.dart';
import 'package:school_management_system/utils/Clip.dart';
import 'package:school_management_system/utils/theme.dart';
import 'package:sizer/sizer.dart';
import 'CustomWidget/DashboardTile.dart';

class DashboardScreen extends StatelessWidget {
  Color get PRIMARY_COLOR => Colors.blue.shade700;
  Color get SECONDARY_COLOR => Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: 280,
          //     decoration: BoxDecoration(
          //       color: PRIMARY_COLOR,
          //       borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(70),
          //         bottomRight: Radius.circular(70),
          //       ),
          //     ),
          //   ),
          // ),
          ClipPath(
            clipper: BlueBackgroundClipper(),
            child: Container(
              color: ColorTheme().PRIMARY_COLOR,
              height: 300,
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 16, right: 16),
                child: Center(
                  child: Text(
                    "School Management System",
                    style: TextStyle(
                      color: SECONDARY_COLOR,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.pt),
                child: Text("Naimish R. Vadodariya",style: TextStyle(fontSize: 20.sp,
                  color: Colors.white70),),
              ),
              SizedBox(height: 5.h), // Adjusted for spacing
              // Dashboard Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => RR_Distribution(),)),
                        child: DashboardTile(
                          icon: Icons.calendar_today,
                          label: "RR Distribution",
                          primaryColor: PRIMARY_COLOR,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Seminar_Conduct(),)),
                        child: DashboardTile(
                          icon: Icons.record_voice_over_rounded,
                          label: "Seminar Conduct",
                          primaryColor: PRIMARY_COLOR,
                        ),
                      ),
                      GestureDetector(
                        child: DashboardTile(
                          icon: Icons.school,
                          label: "School Visit",
                          primaryColor: PRIMARY_COLOR,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Remuneration(),)),
                        child: DashboardTile(
                          icon: Icons.monetization_on_outlined,
                          label: "Remuneration",
                          primaryColor: PRIMARY_COLOR,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pending_Remuneration(),)),
                        child: DashboardTile(
                          icon: Icons.pending_actions,
                          label: "Pending Remuneration",
                          primaryColor: PRIMARY_COLOR,
                        ),
                      ),
                      // DashboardTile(
                      //   icon: Icons.book,
                      //   label: "LMS",
                      //   primaryColor: PRIMARY_COLOR,
                      // ),
                      // DashboardTile(
                      //   icon: Icons.directions_bus,
                      //   label: "Transport",
                      //   primaryColor: PRIMARY_COLOR,
                      // ),
                      // DashboardTile(
                      //   icon: Icons.assignment,
                      //   label: "Exam Schedule",
                      //   primaryColor: PRIMARY_COLOR,
                      // ),
                      // DashboardTile(
                      //   icon: Icons.grade,
                      //   label: "Results",
                      //   primaryColor: PRIMARY_COLOR,
                      // ),
                      // DashboardTile(
                      //   icon: Icons.money,
                      //   label: "Fees",
                      //   primaryColor: PRIMARY_COLOR,
                      // ),
                      // DashboardTile(
                      //   icon: Icons.feedback,
                      //   label: "Feedback",
                      //   primaryColor: PRIMARY_COLOR,
                      // ),
                      // DashboardTile(
                      //   icon: Icons.analytics,
                      //   label: "LMS Test Result",
                      //   primaryColor: PRIMARY_COLOR,
                      // ),
                      // DashboardTile(
                      //   icon: Icons.people,
                      //   label: "Mentoring",
                      //   primaryColor: PRIMARY_COLOR,
                      // ),
                      // DashboardTile(
                      //   icon: Icons.gavel,
                      //   label: "Punishment",
                      //   primaryColor: PRIMARY_COLOR,
                      // ),
                    ],
                  ),
                ),
              ),
              // Footer
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "App Version: 1.0",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

