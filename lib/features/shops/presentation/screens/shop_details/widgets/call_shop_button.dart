import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';

class CallShopButton extends StatelessWidget {
  final List<String> contactInfo;

  const CallShopButton({super.key, required this.contactInfo});

  Future<void> _call() async {
    final phone = contactInfo.first.trim();
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    if (contactInfo.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryVariant]),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: _call,
          icon: const Icon(Icons.phone_rounded, size: 20),
          label: Text(context.tr('call_now')),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: AppColors.onPrimary,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}