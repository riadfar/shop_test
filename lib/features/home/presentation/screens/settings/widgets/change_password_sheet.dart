import 'package:flutter/material.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class ChangePasswordSheet extends StatefulWidget {
  const ChangePasswordSheet({super.key});
  @override State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _curCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _conCtrl = TextEditingController();
  bool _hideCur = true, _hideNew = true, _hideCon = true;

  @override
  void dispose() {
    for (final c in [_curCtrl, _newCtrl, _conCtrl]) { c.dispose(); }
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(context.tr('password_reset_success')), backgroundColor: AppColors.primary));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Form(key: _formKey, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Container(width: 40, height: 4,
          decoration: BoxDecoration(color: AppColors.borderLight, borderRadius: BorderRadius.circular(2)))),
        const SizedBox(height: 16),
        Text(context.tr('change_password'), style: AppTextStyles.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 20),
        _PwField(ctrl: _curCtrl, label: context.tr('current_password'), hide: _hideCur,
          onToggle: () => setState(() => _hideCur = !_hideCur)),
        const SizedBox(height: 12),
        _PwField(ctrl: _newCtrl, label: context.tr('new_password'), hide: _hideNew,
          onToggle: () => setState(() => _hideNew = !_hideNew),
          validator: (v) => v != null && v.length < 8 ? context.tr('password_too_short') : null),
        const SizedBox(height: 12),
        _PwField(ctrl: _conCtrl, label: context.tr('confirm_password'), hide: _hideCon,
          onToggle: () => setState(() => _hideCon = !_hideCon),
          validator: (v) => v != _newCtrl.text ? context.tr('passwords_dont_match') : null),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity,
          child: ElevatedButton(onPressed: _save,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: AppColors.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
            child: Text(context.tr('save_changes')))),
      ])),
    );
  }
}

class _PwField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final bool hide;
  final VoidCallback onToggle;
  final String? Function(String?)? validator;
  const _PwField({required this.ctrl, required this.label, required this.hide, required this.onToggle, this.validator});
  @override
  Widget build(BuildContext context) => TextFormField(
    controller: ctrl, obscureText: hide,
    decoration: InputDecoration(labelText: label,
      prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 20),
      suffixIcon: IconButton(icon: Icon(hide ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 18, color: AppColors.iconLight), onPressed: onToggle),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
    validator: validator ?? (v) => v == null || v.trim().isEmpty ? context.tr('field_required') : null,
  );
}
