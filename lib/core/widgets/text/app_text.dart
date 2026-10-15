import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';

/// Drop-in [Text] replacement that renders every `&` in Cinzel.
/// All other characters keep the provided [style] (Playfair Display).
class AppText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool softWrap;
  final StrutStyle? strutStyle;

  const AppText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
    this.strutStyle,
  });

  /// Builds inline spans with Cinzel applied only to `&`.
  static List<InlineSpan> spansWithCinzelAmpersand(
    String text, {
    TextStyle? style,
  }) {
    if (!text.contains('&')) {
      return [TextSpan(text: text, style: style)];
    }

    final ampersandStyle = (style ?? const TextStyle()).copyWith(
      fontFamily: AppFonts.ampersandFont,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
    );

    final spans = <InlineSpan>[];
    final parts = text.split('&');
    for (var i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        spans.add(TextSpan(text: parts[i], style: style));
      }
      if (i < parts.length - 1) {
        spans.add(TextSpan(text: '&', style: ampersandStyle));
      }
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    if (!data.contains('&')) {
      return Text(
        data,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        strutStyle: strutStyle,
      );
    }

    return Text.rich(
      TextSpan(children: spansWithCinzelAmpersand(data, style: style)),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      strutStyle: strutStyle,
    );
  }
}
