
import 'package:flutter/material.dart';
import 'package:myapp/models/equipment.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final Equipment equipment;

  const BookingScreen({super.key, required this.equipment});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;

  String _duration = 'N/A';
  String _totalCost = 'N/A';

  void _calculateSummary() {
    if (_startDate != null && _startTime != null && _endDate != null && _endTime != null) {
      final startDateTime = DateTime(_startDate!.year, _startDate!.month, _startDate!.day, _startTime!.hour, _startTime!.minute);
      final endDateTime = DateTime(_endDate!.year, _endDate!.month, _endDate!.day, _endTime!.hour, _endTime!.minute);

      if (endDateTime.isBefore(startDateTime)) {
        setState(() {
          _duration = 'Invalid range';
          _totalCost = 'N/A';
        });
        return;
      }

      final difference = endDateTime.difference(startDateTime);
      final days = difference.inDays;
      final hours = difference.inHours % 24;

      setState(() {
        _duration = '$days days, $hours hours';
        double cost = 0;
        if (widget.equipment.price.containsKey('day')) {
          cost += days * (widget.equipment.price['day'] ?? 0);
          // Use hourly rate for remaining hours if available
          if (widget.equipment.price.containsKey('hour')) {
            cost += hours * (widget.equipment.price['hour'] ?? 0);
          } else {
            // Or prorate the daily rate
             cost += (hours / 24) * (widget.equipment.price['day'] ?? 0);
          }
        } else if (widget.equipment.price.containsKey('hour')) {
          cost = difference.inHours * (widget.equipment.price['hour'] ?? 0);
        }
        _totalCost = '৳${cost.toStringAsFixed(2)}';
      });
    }
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: (isStart ? _startDate : _endDate) ?? now,
      firstDate: now,
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
        _calculateSummary();
      });
    }
  }

  Future<void> _pickTime(BuildContext context, bool isStart) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: (isStart ? _startTime : _endTime) ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStart) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
        _calculateSummary();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.equipment.name}'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            Text('Select Dates & Times', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildDateTimePickerCard(),
            const SizedBox(height: 24),
            Text('Booking Summary', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildSummaryCard(),
            const SizedBox(height: 32),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            widget.equipment.imageUrls.first,
            height: 180,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.equipment.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimePickerCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDateTimeRow(
              icon: Icons.calendar_today,
              label: 'Start Date',
              value: _startDate != null ? DateFormat.yMMMd().format(_startDate!) : 'Not set',
              onTap: () => _pickDate(context, true),
            ),
            const Divider(height: 20),
            _buildDateTimeRow(
              icon: Icons.access_time,
              label: 'Start Time',
              value: _startTime != null ? _startTime!.format(context) : 'Not set',
              onTap: () => _pickTime(context, true),
            ),
            const Divider(height: 20),
            _buildDateTimeRow(
              icon: Icons.calendar_today,
              label: 'End Date',
              value: _endDate != null ? DateFormat.yMMMd().format(_endDate!) : 'Not set',
              onTap: () => _pickDate(context, false),
            ),
            const Divider(height: 20),
            _buildDateTimeRow(
              icon: Icons.access_time,
              label: 'End Time',
              value: _endTime != null ? _endTime!.format(context) : 'Not set',
              onTap: () => _pickTime(context, false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeRow({required IconData icon, required String label, required String value, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 16),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Spacer(),
            Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSummaryRow(label: 'Total Duration', value: _duration),
            const Divider(height: 20),
            _buildSummaryRow(label: 'Estimated Cost', value: _totalCost, isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow({required String label, required String value, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Theme.of(context).primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: (_startDate != null && _startTime != null && _endDate != null && _endTime != null)
            ? () {
                // TODO: Implement booking confirmation logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Booking Confirmed! (Not really)')),
                );
              }
            : null,
        child: const Text('Confirm Booking', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

