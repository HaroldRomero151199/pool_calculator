import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../core/app_constants.dart';

class AppDrawer extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeModeChanged;

  const AppDrawer({
    super.key,
    required this.isDarkMode,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: isDarkTheme
                        ? AppColors.darkCard
                        : colorScheme.primary.withValues(alpha: 0.08),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/app_icon.png',
                          width: 64,
                          height: 64,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppConstants.appTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDarkTheme
                              ? AppColors.darkText
                              : colorScheme.primary,
                          fontFamily: AppConstants.titleFontFamily,
                          fontFamilyFallback: AppConstants.titleFontFamilyFallback,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: AppConstants.titleLetterSpacing,
                        ),
                      ),
                    ],
                  ),
                ),
                SwitchListTile(
                  key: const Key('darkModeSwitch'),
                  secondary: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  ),
                  title: const Text(AppConstants.darkModeLabel),
                  value: isDarkMode,
                  onChanged: onThemeModeChanged,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppConstants.developedByLabel,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkTheme
                        ? Colors.grey.shade500
                        : Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppConstants.versionLabel,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDarkTheme
                        ? Colors.grey.shade600
                        : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
