import 'package:flutter/material.dart';

class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSalesOverview(),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesOverview() {
    return const Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sales Overview', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text('Total Sales: \$5000'),
            Text('Total Revenue: \$4500'),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return const Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Activity', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ListTile(
              title: Text('Added New Product: Diamond Ring'),
              subtitle: Text('2 hours ago'),
            ),
            ListTile(
              title: Text('Updated Product: Gold Necklace'),
              subtitle: Text('1 day ago'),
            ),
          ],
        ),
      ),
    );
  }
}
