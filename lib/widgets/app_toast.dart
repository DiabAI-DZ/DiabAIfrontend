import 'package:flutter/material.dart';

enum AppToastType { success, error, info }

class AppToast {
  const AppToast._();

  static void show(
    BuildContext context,
    String message, {
    AppToastType type = AppToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colors = _toastColors(type);

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            colors.icon,
            color: colors.iconColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: colors.textColor,
                fontWeight: FontWeight.w600,
                fontFamily: 'ClashDisplay',
              ),
            ),
          ),
        ],
      ),
      backgroundColor: colors.background,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      duration: duration,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.border, width: 1.2),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static _ToastColors _toastColors(AppToastType type) {
    switch (type) {
      case AppToastType.success:
        return const _ToastColors(
          background: Color(0xFFF5DEDE),
          border: Color(0xFF9A1115),
          textColor: Color(0xFF622E2E),
          iconColor: Color(0xFF9A1115),
          icon: Icons.check_circle_rounded,
        );
      case AppToastType.error:
        return const _ToastColors(
          background: Color(0xFFFFE8E8),
          border: Color(0xFFD7181D),
          textColor: Color(0xFF9A1115),
          iconColor: Color(0xFFD7181D),
          icon: Icons.error_rounded,
        );
      case AppToastType.info:
        return const _ToastColors(
          background: Color(0xFFF5DEDE),
          border: Color(0xFFEAC5C5),
          textColor: Color(0xFF854444),
          iconColor: Color(0xFF854444),
          icon: Icons.info_rounded,
        );
    }
  }
}

class _ToastColors {
  const _ToastColors({
    required this.background,
    required this.border,
    required this.textColor,
    required this.iconColor,
    required this.icon,
  });

  final Color background;
  final Color border;
  final Color textColor;
  final Color iconColor;
  final IconData icon;
}
