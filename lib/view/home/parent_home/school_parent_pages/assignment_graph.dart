import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AssignmetsGraph extends StatelessWidget {
  const AssignmetsGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Assignmet")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 150,
              width: 150,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      startDegreeOffset: 150,
                      sectionsSpace: 0,
                      centerSpaceRadius: 70,
                      sections: [
                        PieChartSectionData(
                          value: 45,
                          color: Colors.greenAccent,
                          radius: 25,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 35,
                          color: Colors.blue.shade900,
                          radius: 25,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 20,
                          color: const Color.fromARGB(255, 208, 23, 23),
                          radius: 20,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 110,
                          width: 110,
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
                              "10/10",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
