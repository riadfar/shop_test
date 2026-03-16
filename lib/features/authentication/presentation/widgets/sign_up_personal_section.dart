import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/atomic/custom_text_field.dart';
import 'sign_up_section_label.dart';

class PersonalInfoSection extends StatelessWidget {
  final TextEditingController firstNameCtrl, lastNameCtrl, phoneCtrl;
  const PersonalInfoSection({
    super.key,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.phoneCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SignUpSectionLabel(
          label: context.tr('personal_info'),
          icon: Icons.person_outline_rounded,
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextField(
                controller: firstNameCtrl,
                labelText: context.tr('first_name'),
                hintText: context.tr('first_name_hint'),
                isRequired: true,
                prefixIcon: const Icon(Icons.badge_outlined),
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomTextField(
                controller: lastNameCtrl,
                labelText: context.tr('last_name'),
                hintText: context.tr('last_name_hint'),
                isRequired: true,
                prefixIcon: const Icon(Icons.badge_outlined),
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: phoneCtrl,
          labelText: context.tr('phone_number'),
          hintText: context.tr('phone_hint'),
          type: TextFieldType.phone,
          isRequired: true,
          prefixIcon: const Icon(Icons.phone_outlined),
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
