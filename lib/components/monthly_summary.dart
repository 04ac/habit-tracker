import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  const MonthlySummary({super.key, this.datasets});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: HeatMapCalendar(
        // defaultColor: Colors.white,
        flexible: true,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[400],
        textColor: Colors.white,
        showColorTip: false,
        datasets: datasets,
        colorsets: {
          1: Colors.green.shade100,
          2: Colors.green.shade200,
          3: Colors.green.shade300,
          4: Colors.green.shade400,
          5: Colors.green.shade500,
          6: Colors.green.shade600,
          7: Colors.green.shade700,
          8: Colors.green.shade800,
          9: Colors.green.shade900,
          10: const Color.fromARGB(255, 27, 94, 40),
        },
      ),
    );
  }
}
