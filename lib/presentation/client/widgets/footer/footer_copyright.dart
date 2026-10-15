import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/footer_texts.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';

class FooterCopyright extends StatelessWidget {
  const FooterCopyright({super.key});

  Future<void> _openWmSols() async {
    final uri = Uri.parse(FooterTexts.wmSolsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mutedStyle = AppTextStyles.bodyText(
      context,
    ).copyWith(color: AppColors.white.withValues(alpha: 0.8), fontSize: 12);

    return Container(
      width: double.infinity,
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(
            color: AppColors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          runSpacing: 4,
          children: [
            Text(
              context.l10n.footerCopyright(DateTime.now().year),
              style: mutedStyle,
              textAlign: TextAlign.center,
            ),
            Text('·', style: mutedStyle),
            Text(context.l10n.footerPoweredBy, style: mutedStyle),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _openWmSols,
                child: Text(
                  FooterTexts.wmSolsName,
                  style: mutedStyle.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
