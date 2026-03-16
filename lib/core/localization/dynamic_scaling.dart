import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DynamicTextScaling extends StatefulWidget {
  final Widget child;
  final double minScale;
  final double maxScale;

  const DynamicTextScaling({
    super.key,
    required this.child,
    this.minScale = 0.8,
    this.maxScale = 1.5,
  });

  @override
  State<DynamicTextScaling> createState() => _DynamicTextScalingState();

  static double of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<_DynamicTextScalingInherited>();
    return inherited?.scaleFactor ?? 1.0;
  }

  static void updateScale(BuildContext context, double scale) {
    final state = context.findAncestorStateOfType<_DynamicTextScalingState>();
    state?.updateScale(scale);
  }
}

class _DynamicTextScalingState extends State<DynamicTextScaling> {
  double _scaleFactor = 1.0;

  void updateScale(double scale) {
    setState(() {
      _scaleFactor = scale.clamp(widget.minScale, widget.maxScale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _DynamicTextScalingInherited(
      scaleFactor: _scaleFactor,
      child: Builder(
        builder: (context) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(_scaleFactor),
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _DynamicTextScalingInherited extends InheritedWidget {
  final double scaleFactor;

  const _DynamicTextScalingInherited({
    required this.scaleFactor,
    required super.child,
  });

  @override
  bool updateShouldNotify(_DynamicTextScalingInherited oldWidget) {
    return scaleFactor != oldWidget.scaleFactor;
  }
}

class TextScaleSettings extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;

  const TextScaleSettings({
    super.key,
    this.title = 'Text Size',
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final currentScale = DynamicTextScaling.of(context);
    
    return ListTile(
      leading: Icon(icon ?? Icons.text_fields),
      title: Text(title),
      subtitle: Text(subtitle ?? 'Current: ${(currentScale * 100).toStringAsFixed(0)}%'),
      trailing: PopupMenuButton<double>(
        icon: const Icon(Icons.arrow_drop_down),
        initialValue: currentScale,
        onSelected: (scale) {
          DynamicTextScaling.updateScale(context, scale);
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 0.8,
            child: Text('Small (80%)'),
          ),
          const PopupMenuItem(
            value: 1.0,
            child: Text('Normal (100%)'),
          ),
          const PopupMenuItem(
            value: 1.2,
            child: Text('Large (120%)'),
          ),
          const PopupMenuItem(
            value: 1.5,
            child: Text('Extra Large (150%)'),
          ),
        ],
      ),
    );
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool responsive;

  const ResponsiveText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.responsive = true,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? effectiveStyle = style;
    
    if (responsive) {
      final scaleFactor = DynamicTextScaling.of(context);
      effectiveStyle = style?.copyWith(
        fontSize: (style?.fontSize ?? 14) * scaleFactor,
      );
    }

    return Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}