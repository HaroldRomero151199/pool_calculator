import 'package:flutter/material.dart';

class InputSection extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final ValueChanged<String> onPriceChanged;
  final VoidCallback onSelectStartTime;
  final VoidCallback onSelectEndTime;
  final VoidCallback onSetEndTimeToNow;

  const InputSection({
    super.key,
    required this.priceController,
    required this.startTimeController,
    required this.endTimeController,
    required this.onPriceChanged,
    required this.onSelectStartTime,
    required this.onSelectEndTime,
    required this.onSetEndTimeToNow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            onChanged: onPriceChanged,
            decoration: const InputDecoration(
              labelText: "Precio por hora (Bs)",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: startTimeController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: "Hora de inicio",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.access_time),
            ),
            onTap: onSelectStartTime,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: endTimeController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Hora final",
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.access_time),
              suffixIcon: IconButton(
                icon: const Icon(Icons.update),
                tooltip: "Poner hora actual",
                onPressed: onSetEndTimeToNow,
              ),
            ),
            onTap: onSelectEndTime,
          ),
        ],
      ),
    );
  }
}
