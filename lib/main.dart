import 'package:flutter/material.dart';

void main() {
  runApp(const BilliardCostApp());
}

class BilliardCostApp extends StatelessWidget {
  const BilliardCostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BilliardCostScreen(),
    );
  }
}

class BilliardCostScreen extends StatefulWidget {
  const BilliardCostScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BilliardCostScreenState createState() => _BilliardCostScreenState();
}

class _BilliardCostScreenState extends State<BilliardCostScreen> {
  final TextEditingController _priceController =
      TextEditingController(text: "15");
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  TimeOfDay? startTime;
  TimeOfDay? endTime;
  double? totalCost;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    TimeOfDay initialTime = isStartTime
        ? (startTime ?? TimeOfDay.now())
        : (endTime ?? TimeOfDay.now());
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = pickedTime;
          _startTimeController.text = pickedTime.format(context);
        } else {
          endTime = pickedTime;
          _endTimeController.text = pickedTime.format(context);
        }
      });
    }
  }

  void _calculateCost() {
    if (startTime != null &&
        endTime != null &&
        _priceController.text.isNotEmpty) {
      double pricePerHour = double.tryParse(_priceController.text) ?? 0.0;

      DateTime now = DateTime.now();
      DateTime startDateTime = DateTime(
          now.year, now.month, now.day, startTime!.hour, startTime!.minute);
      DateTime endDateTime = DateTime(
          now.year, now.month, now.day, endTime!.hour, endTime!.minute);

      if (endDateTime.isBefore(startDateTime)) {
        endDateTime = endDateTime.add(
          const Duration(days: 1),
        );
      }

      Duration difference = endDateTime.difference(startDateTime);
      double hours = difference.inMinutes / 60.0;
      double cost = hours * pricePerHour;

      setState(() {
        totalCost = cost;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora La Central Del norte"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Precio por hora (Bs)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _startTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Hora de inicio",
                border: OutlineInputBorder(),
              ),
              onTap: () => _selectTime(context, true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _endTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Hora final",
                border: OutlineInputBorder(),
              ),
              onTap: () => _selectTime(context, false),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateCost,
              child: const Text("Calcular costo"),
            ),
            const SizedBox(height: 20),
            if (totalCost != null)
              Text(
                "Costo total: ${totalCost!.toStringAsFixed(2)} Bs",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
