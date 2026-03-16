import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';

class OtpInputRow extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  const OtpInputRow({super.key, required this.onCompleted});
  @override State<OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  static const int _len = 6;
  final _controllers = List.generate(_len, (_) => TextEditingController());
  final _nodes = List.generate(_len, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    for (final n in _nodes) { n.dispose(); }
    super.dispose();
  }

  void _onChange(int i, String val) {
    if (val.isNotEmpty && i < _len - 1) { _nodes[i + 1].requestFocus(); }
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length == _len) widget.onCompleted(otp);
  }

  void _onBackspace(int i) {
    if (i > 0 && _controllers[i].text.isEmpty) {
      _nodes[i - 1].requestFocus();
      _controllers[i - 1].clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_len, (i) => _OtpBox(
        controller: _controllers[i],
        focusNode: _nodes[i],
        isDark: isDark,
        onChanged: (v) => _onChange(i, v),
        onBackspace: () => _onBackspace(i),
      )),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isDark;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;

  const _OtpBox({
    required this.controller, required this.focusNode, required this.isDark,
    required this.onChanged, required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight, width: 1.5),
    );
    return SizedBox(
      width: 46, height: 56,
      child: Focus(
        onKeyEvent: (_, e) {
          if (e is KeyDownEvent && e.logicalKey == LogicalKeyboardKey.backspace && controller.text.isEmpty) {
            onBackspace();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700,
            color: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            border: border, enabledBorder: border,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
