
import 'package:flutter/material.dart';
import 'package:myapp/utils/routes.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Dashboard'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildDashboardCard(context, 'Total Equipment', '12', Icons.agriculture),
          _buildDashboardCard(context, 'Pending Bookings', '3', Icons.hourglass_top),
          _buildDashboardCard(context, 'Active Rentals', '5', Icons.construction),
          _buildDashboardCard(context, 'Total Earnings', '\$1,250', Icons.attach_money),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEquipment);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, String value, IconData icon) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          // Navigate to respective screen
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 48.0, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8.0),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4.0),
            Text(value, style: const TextStyle(fontSize: 24.0)),
          ],
        ),
      ),
    );
  }
}
