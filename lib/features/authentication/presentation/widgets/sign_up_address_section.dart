import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/atomic/custom_text_field.dart';
import 'location_picker_card.dart';
import 'sign_up_section_label.dart';

class DeliveryAddressSection extends StatelessWidget {
  final TextEditingController addressCtrl;
  const DeliveryAddressSection({super.key, required this.addressCtrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SignUpSectionLabel(
          label: context.tr('delivery_address'),
          icon: Icons.home_outlined,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: addressCtrl,
          labelText: context.tr('detailed_address'),
          hintText: context.tr('address_hint'),
          isRequired: true,
          isMultiline: true,
          maxLines: 3,
          prefixIcon: const Icon(Icons.home_outlined),
          textInputAction: TextInputAction.newline,
        ),
        const SizedBox(height: 16),
        LocationPickerCard(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr('map_coming_soon')),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}
