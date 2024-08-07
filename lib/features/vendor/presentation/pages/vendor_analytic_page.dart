import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class VendorAnalyticsPage extends StatelessWidget {
  const VendorAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sales Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildSalesLineChart(),
              const SizedBox(height: 20),
              _buildRevenuePieChart(),
              const SizedBox(height: 20),
              const Text(
                'Sales Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('Number of Sales: 120', style: TextStyle(fontSize: 16)),
              const Text('Total Revenue: \$12,000', style: TextStyle(fontSize: 16)),
              const Text('Total Products: 30', style: TextStyle(fontSize: 16)),
              const Text('Total Orders: 100', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalesLineChart() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: true),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: const Color(0xff37434d),
              width: 1,
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 2),
                FlSpot(1, 5),
                FlSpot(2, 3),
                FlSpot(3, 7),
                FlSpot(4, 4),
                FlSpot(5, 6),
              ],
              isCurved: true,
              color: Colors.deepOrange,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          minX: 0,
          maxX: 5,
          minY: 0,
          maxY: 10,
        ),
      ),
    );
  }

  Widget _buildRevenuePieChart() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: 40,
              color: Colors.deepOrange,
              title: 'Electronics',
              radius: 80,
              titleStyle: const TextStyle(color: Colors.white),
            ),
            PieChartSectionData(
              value: 30,
              color: Colors.blue,
              title: 'Jewelry',
              radius: 80,
              titleStyle: const TextStyle(color: Colors.white),
            ),
            PieChartSectionData(
              value: 20,
              color: Colors.green,
              title: 'Clothing',
              radius: 80,
              titleStyle: const TextStyle(color: Colors.white),
            ),
            PieChartSectionData(
              value: 10,
              color: Colors.red,
              title: 'Accessories',
              radius: 80,
              titleStyle: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
