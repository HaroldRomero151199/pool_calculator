import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../core/app_constants.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkTheme = theme.brightness == Brightness.dark;
    final summaryBackground = isDarkTheme
        ? AppColors.darkCard.withValues(alpha: 0.72)
        : AppColors.whiteCard;
    final totalBackground = isDarkTheme
        ? AppColors.darkStrong
        : AppColors.whiteStrong.withValues(alpha: 0.14);
    final totalTextColor =
        isDarkTheme ? AppColors.darkText : colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: summaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Text(
            AppConstants.summaryTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDarkTheme ? AppColors.darkText : colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            totalDurationStr,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkTheme ? AppColors.darkAccent : colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: totalBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${totalCost.toStringAsFixed(2)} ${AppConstants.currencySuffix}",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: totalTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
