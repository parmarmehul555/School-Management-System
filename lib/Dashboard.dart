import 'package:flutter/material.dart';
import 'CustomWidget/DashboardTile.dart';

class DashboardScreen extends StatelessWidget {
  Color get PRIMARY_COLOR => Colors.blue.shade700;
  Color get SECONDARY_COLOR => Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[10],
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 280,
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
              ),
            ),
          ),
          // Content
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 115.0, left: 16, right: 16),
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
              SizedBox(height: 40), // Adjusted for spacing
              // Dashboard Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: [
                      DashboardTile(
                        icon: Icons.calendar_today,
                        label: "Academic Calendar",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.schedule,
                        label: "Timetable",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.check_circle_outline,
                        label: "Attendance",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.book,
                        label: "LMS",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.directions_bus,
                        label: "Transport",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.assignment,
                        label: "Exam Schedule",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.grade,
                        label: "Results",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.money,
                        label: "Fees",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.feedback,
                        label: "Feedback",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.analytics,
                        label: "LMS Test Result",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.people,
                        label: "Mentoring",
                        primaryColor: PRIMARY_COLOR,
                      ),
                      DashboardTile(
                        icon: Icons.gavel,
                        label: "Punishment",
                        primaryColor: PRIMARY_COLOR,
                      ),
                    ],
                  ),
                ),
              ),
              // Footer
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "App Version: 1.0",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

