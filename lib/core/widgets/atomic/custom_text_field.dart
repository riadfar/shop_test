import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';

enum TextFieldType { text, password, email, phone, number }

/// A premium, theme-aware text field with animated focus border,
/// internal password-toggle, and proper focus-node ownership.
class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextFieldType type;
  final bool isRequired;
  final bool isEnabled;
  final bool isMultiline;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.type = TextFieldType.text,
    this.isRequired = false,
    this.isEnabled = true,
    this.isMultiline = false,
    this.maxLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.textInputAction,
    this.focusNode,
    this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _node;
  late bool _obscureText;
  bool _isFocused = false;
  bool _ownsNode = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.type == TextFieldType.password;
    if (widget.focusNode != null) {
      _node = widget.focusNode!;
    } else {
      _node = FocusNode();
      _ownsNode = true;
    }
    _node.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) setState(() => _isFocused = _node.hasFocus);
  }

  @override
  void dispose() {
    _node.removeListener(_onFocusChange);
    if (_ownsNode) _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final textColor = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    final hintColor = textColor.withOpacity(0.42);
    final iconColor = _isFocused
        ? AppColors.primary
        : (isDark ? AppColors.iconDark : AppColors.iconLight);
    final borderColor = _isFocused
        ? AppColors.primary
        : (isDark ? AppColors.borderDark : AppColors.borderLight);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.14),
                  blurRadius: 16,
                  spreadRadius: -2,
                  offset: const Offset(0, 5),
                ),
              ]
            : [
                BoxShadow(
                  color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _node,
        enabled: widget.isEnabled,
        maxLines: widget.isMultiline ? (widget.maxLines ?? 4) : 1,
        maxLength: widget.maxLength,
        validator: _buildValidator(),
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
        textInputAction: widget.textInputAction,
        obscureText: _obscureText,
        keyboardType: _resolveKeyboardType(),
        inputFormatters: widget.inputFormatters ?? _resolveFormatters(),
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: _isFocused ? AppColors.primary : hintColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          floatingLabelStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 14, right: 10),
                  child: IconTheme(
                    data: IconThemeData(color: iconColor, size: 20),
                    child: widget.prefixIcon!,
                  ),
                )
              : null,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 48, minHeight: 48),
          suffixIcon: _resolveSuffixIcon(iconColor),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 48, minHeight: 48),
          filled: true,
          fillColor: fillColor,
          border: _border(borderColor),
          enabledBorder: _border(borderColor),
          focusedBorder: _border(AppColors.primary, width: 1.8),
          errorBorder: _border(AppColors.error),
          focusedErrorBorder: _border(AppColors.error, width: 1.8),
          disabledBorder: _border(
            isDark ? AppColors.disabledDark : AppColors.disabledLight,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
          errorStyle: const TextStyle(
            color: AppColors.error,
            fontSize: 11.5,
            height: 1.4,
          ),
          counterText: '',
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  OutlineInputBorder _border(Color color, {double width = 1.2}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );

  Widget? _resolveSuffixIcon(Color iconColor) {
    if (widget.suffixIcon != null) return widget.suffixIcon;
    if (widget.type == TextFieldType.password) {
      return GestureDetector(
        onTap: () => setState(() => _obscureText = !_obscureText),
        child: Padding(
          padding: const EdgeInsets.only(right: 14),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              _obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              key: ValueKey(_obscureText),
              color: iconColor,
              size: 20,
            ),
          ),
        ),
      );
    }
    return null;
  }

  String? Function(String?)? _buildValidator() {
    if (widget.validator != null) return widget.validator;
    return (value) {
      if (widget.isRequired && (value == null || value.trim().isEmpty)) {
        return 'This field is required';
      }
      switch (widget.type) {
        case TextFieldType.email:
          if (value != null && value.isNotEmpty) {
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
          }
        case TextFieldType.phone:
          if (value != null && value.isNotEmpty) {
            if (!RegExp(r'^\+?[0-9]{10,}$')
                .hasMatch(value.replaceAll(RegExp(r'\s+'), ''))) {
              return 'Please enter a valid phone number';
            }
          }
        case TextFieldType.number:
          if (value != null && value.isNotEmpty) {
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
          }
        default:
          break;
      }
      return null;
    };
  }

  TextInputType _resolveKeyboardType() {
    if (widget.isMultiline) return TextInputType.multiline;
    switch (widget.type) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _resolveFormatters() {
    switch (widget.type) {
      case TextFieldType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      case TextFieldType.phone:
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9\s+]'))];
      default:
        return null;
    }
  }
}
