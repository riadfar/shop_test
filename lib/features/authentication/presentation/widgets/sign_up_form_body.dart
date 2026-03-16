import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/atomic/custom_button.dart';
import 'sign_up_account_section.dart';
import 'sign_up_address_section.dart';
import 'sign_up_header.dart';
import 'sign_up_login_cta.dart';
import 'sign_up_personal_section.dart';

class SignUpFormBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameCtrl, lastNameCtrl, phoneCtrl;
  final TextEditingController emailCtrl, passwordCtrl, confirmPasswordCtrl;
  final TextEditingController addressCtrl;
  final bool isLoading;
  final String? Function(String?)? passwordValidator;
  final String? Function(String?)? confirmPasswordValidator;
  final VoidCallback onSignUp;
  final VoidCallback? onLogin;

  const SignUpFormBody({
    super.key,
    required this.formKey,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.phoneCtrl,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.confirmPasswordCtrl,
    required this.addressCtrl,
    required this.isLoading,
    required this.passwordValidator,
    required this.confirmPasswordValidator,
    required this.onSignUp,
    this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 48),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SignUpHeader(isDark: isDark),
            const SizedBox(height: 32),
            PersonalInfoSection(
              firstNameCtrl: firstNameCtrl,
              lastNameCtrl: lastNameCtrl,
              phoneCtrl: phoneCtrl,
            ),
            const SizedBox(height: 28),
            AccountDetailsSection(
              emailCtrl: emailCtrl,
              passwordCtrl: passwordCtrl,
              confirmPasswordCtrl: confirmPasswordCtrl,
              passwordValidator: passwordValidator,
              confirmPasswordValidator: confirmPasswordValidator,
            ),
            const SizedBox(height: 28),
            DeliveryAddressSection(addressCtrl: addressCtrl),
            const SizedBox(height: 36),
            CustomButton(
              text: context.tr('sign_up_button'),
              isLoading: isLoading,
              onPressed: onSignUp,
              icon: Icons.person_add_alt_1_rounded,
            ),
            const SizedBox(height: 30),
            SignUpLoginCta(onLogin: onLogin),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
