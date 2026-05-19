import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SummarySection extends StatelessWidget {
  final String totalDurationStr;
  final double totalCost;

  const SummarySection({
    super.key,
    required this.totalDurationStr,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.azulTorneo.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Resumen de Cobro",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.maderaCaoba,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            totalDurationStr,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.azulTorneo,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: AppColors.verdeTradicional.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${totalCost.toStringAsFixed(2)} Bs.",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppColors.verdeTradicional,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
