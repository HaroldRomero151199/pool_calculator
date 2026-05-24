import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/input_section.dart';
import '../widgets/summary_section.dart';
import '../widgets/app_drawer.dart';
import '../controllers/calculator_controller.dart';
import '../core/app_constants.dart';

class BilliardCostScreen extends StatefulWidget {
  final bool isDarkMode;
  final String appVersionLabel;
  final ValueChanged<bool> onThemeModeChanged;

  const BilliardCostScreen({
    super.key,
    required this.isDarkMode,
    required this.appVersionLabel,
    required this.onThemeModeChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BilliardCostScreenState createState() => _BilliardCostScreenState();
}

class _BilliardCostScreenState extends State<BilliardCostScreen> {
  final TextEditingController _priceController =
      TextEditingController(text: AppConstants.defaultPricePerHour);
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  TimeOfDay? startTime;
  TimeOfDay? endTime;
  CalculatorResult? result;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    TimeOfDay initialTime = isStartTime
        ? (startTime ?? TimeOfDay.now())
        : (endTime ?? TimeOfDay.now());
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (!mounted) return;

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = pickedTime;
          _startTimeController.text = pickedTime.format(context);
        } else {
          endTime = pickedTime;
          _endTimeController.text = pickedTime.format(context);
        }
        _updateCost();
      });
    }
  }

  void _setEndTimeToNow() {
    setState(() {
      endTime = TimeOfDay.now();
      _endTimeController.text = endTime!.format(context);
      _updateCost();
    });
  }

  void _resetFields() {
    setState(() {
      _priceController.text = AppConstants.defaultPricePerHour;
      _startTimeController.clear();
      _endTimeController.clear();
      startTime = null;
      endTime = null;
      result = null;
    });
  }

  void _updateCost() {
    result = CalculatorController.calculate(
      startTime: startTime,
      endTime: endTime,
      priceText: _priceController.text,
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkTheme = theme.brightness == Brightness.dark;
    final borderColor = isDarkTheme
        ? colorScheme.outline.withValues(alpha: 0.5)
        : Colors.grey.shade300;

    return Scaffold(
      drawer: AppDrawer(
        isDarkMode: widget.isDarkMode,
        appVersionLabel: widget.appVersionLabel,
        onThemeModeChanged: widget.onThemeModeChanged,
      ),
      appBar: AppBar(
        title: const Text(
          AppConstants.appTitle,
          style: TextStyle(
            fontFamily: AppConstants.titleFontFamily,
            fontFamilyFallback: AppConstants.titleFontFamilyFallback,
            fontWeight: FontWeight.w700,
            fontSize: AppConstants.titleFontSize,
            letterSpacing: AppConstants.titleLetterSpacing,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: AppConstants.resetTooltip,
            onPressed: _resetFields,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: borderColor,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkTheme ? AppColors.darkSurface : AppColors.whiteSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputSection(
                priceController: _priceController,
                startTimeController: _startTimeController,
                endTimeController: _endTimeController,
                onPriceChanged: (value) {
                  setState(_updateCost);
                },
                onSelectStartTime: () => _selectTime(context, true),
                onSelectEndTime: () => _selectTime(context, false),
                onSetEndTimeToNow: _setEndTimeToNow,
              ),
              if (result != null) ...[
                Divider(height: 1, color: borderColor),
                SummarySection(
                  totalDurationStr: result!.durationStr,
                  totalCost: result!.cost,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
