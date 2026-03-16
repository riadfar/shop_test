import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/atomic/custom_app_bar.dart';
import '../../../../core/widgets/atomic/custom_button.dart';
import '../widgets/otp_input_row.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final void Function(String email)? onVerified;
  const OtpScreen({super.key, required this.email, this.onVerified});
  @override State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otp = '';
  bool _isLoading = false;
  int _secondsLeft = 60;
  Timer _timer = Timer(Duration.zero, () {});

  @override
  void initState() { super.initState(); _startTimer(); }

  @override
  void dispose() { _timer.cancel(); super.dispose(); }

  void _startTimer() {
    _timer.cancel();
    setState(() => _secondsLeft = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) { t.cancel(); } else { setState(() => _secondsLeft--); }
    });
  }

  Future<void> _handleVerify() async {
    if (_otp.length < 6) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    widget.onVerified?.call(widget.email);
  }

  String _mask(String email) {
    final p = email.split('@');
    if (p.length != 2) return email;
    final n = p[0];
    final m = n.length <= 2 ? n : '${n[0]}${'*' * (n.length - 2)}${n[n.length - 1]}';
    return '$m@${p[1]}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: CustomAppBar(title: context.tr('otp_title')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 88, height: 88,
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.10), shape: BoxShape.circle),
              child: const Icon(Icons.mark_email_read_outlined, color: AppColors.primary, size: 42))),
            const SizedBox(height: 32),
            Text(context.tr('otp_title'), style: AppTextStyles.textTheme.headlineSmall?.copyWith(
              color: onSurface, fontWeight: FontWeight.w800, letterSpacing: -0.4)),
            const SizedBox(height: 8),
            Text('${context.tr('otp_subtitle')} ${_mask(widget.email)}',
              style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                color: onSurface.withValues(alpha: 0.58), height: 1.55)),
            const SizedBox(height: 40),
            OtpInputRow(onCompleted: (otp) => setState(() => _otp = otp)),
            const SizedBox(height: 16),
            Center(
              child: _secondsLeft > 0
                ? Text('${context.tr('resend_in')} ${_secondsLeft}s',
                    style: TextStyle(color: onSurface.withValues(alpha: 0.50), fontSize: 13))
                : TextButton(
                    onPressed: _startTimer,
                    child: Text(context.tr('resend_code'),
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600))),
            ),
            const Spacer(),
            CustomButton(
              text: context.tr('verify'),
              onPressed: _otp.length == 6 ? _handleVerify : null,
              isLoading: _isLoading,
              icon: Icons.verified_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
