import 'package:flutter/material.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class EditProfileSheet extends StatefulWidget {
  final String initialName, initialEmail, initialPhone;
  final void Function(String name, String email, String phone) onSave;
  const EditProfileSheet({super.key, required this.initialName, required this.initialEmail, required this.initialPhone, required this.onSave});
  @override State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  late final TextEditingController _nameCtrl, _emailCtrl, _phoneCtrl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameCtrl  = TextEditingController(text: widget.initialName);
    _emailCtrl = TextEditingController(text: widget.initialEmail);
    _phoneCtrl = TextEditingController(text: widget.initialPhone);
  }

  @override
  void dispose() {
    for (final c in [_nameCtrl, _emailCtrl, _phoneCtrl]) { c.dispose(); }
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(_nameCtrl.text.trim(), _emailCtrl.text.trim(), _phoneCtrl.text.trim());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4,
            decoration: BoxDecoration(color: AppColors.borderLight, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 16),
          Text(context.tr('edit_profile'), style: AppTextStyles.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          _Field(ctrl: _nameCtrl, label: context.tr('full_name'), icon: Icons.person_outline_rounded),
          const SizedBox(height: 12),
          _Field(ctrl: _emailCtrl, label: context.tr('email_address'), icon: Icons.email_outlined, keyboard: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _Field(ctrl: _phoneCtrl, label: context.tr('phone_number'), icon: Icons.phone_outlined, keyboard: TextInputType.phone),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity,
            child: ElevatedButton(onPressed: _save,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
              child: Text(context.tr('save_changes')))),
        ]),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final IconData icon;
  final TextInputType? keyboard;
  const _Field({required this.ctrl, required this.label, required this.icon, this.keyboard});
  @override
  Widget build(BuildContext context) => TextFormField(
    controller: ctrl, keyboardType: keyboard,
    decoration: InputDecoration(labelText: label,
      prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
    validator: (v) => v == null || v.trim().isEmpty ? context.tr('field_required') : null,
  );
}
