import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/atomic/custom_text_field.dart';
import 'sign_up_section_label.dart';

class AccountDetailsSection extends StatelessWidget {
  final TextEditingController emailCtrl, passwordCtrl, confirmPasswordCtrl;
  final String? Function(String?)? passwordValidator;
  final String? Function(String?)? confirmPasswordValidator;

  const AccountDetailsSection({
    super.key,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.confirmPasswordCtrl,
    this.passwordValidator,
    this.confirmPasswordValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SignUpSectionLabel(
          label: context.tr('account_details'),
          icon: Icons.lock_outline_rounded,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: emailCtrl,
          labelText: context.tr('email'),
          hintText: context.tr('email_hint'),
          type: TextFieldType.email,
          isRequired: true,
          prefixIcon: const Icon(Icons.email_outlined),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: passwordCtrl,
          labelText: context.tr('password'),
          hintText: context.tr('password_hint'),
          type: TextFieldType.password,
          isRequired: true,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
          textInputAction: TextInputAction.next,
          validator: passwordValidator,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: confirmPasswordCtrl,
          labelText: context.tr('confirm_password'),
          hintText: context.tr('confirm_password_hint'),
          type: TextFieldType.password,
          isRequired: true,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
          textInputAction: TextInputAction.next,
          validator: confirmPasswordValidator,
        ),
      ],
    );
  }
}
