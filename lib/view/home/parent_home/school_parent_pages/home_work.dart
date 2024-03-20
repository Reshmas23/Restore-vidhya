import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeWorkGraph extends StatelessWidget {
  const HomeWorkGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    startDegreeOffset: 270,
                    sectionsSpace: 1,
                    centerSpaceRadius: 80,
                    sections: [
                      PieChartSectionData(
                        value: 5,
                        color: Colors.green,
                        radius: 20,
                        showTitle: true,
                      ),
                      PieChartSectionData(
                        value: 5,
                        color: Colors.redAccent,
                        radius: 20,
                        showTitle: true,
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 10.0,
                              spreadRadius: 10.0,
                              offset: const Offset(3.0, 3.0),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "05/10",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
