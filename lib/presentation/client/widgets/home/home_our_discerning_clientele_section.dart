import 'package:flutter/material.dart';
import '../../../../core/utils/app_spacing/app_spacing.dart';
import '../common/app_fade_in_on_scroll.dart';
import 'home_our_discerning_clientele_content.dart';

class HomeOurDiscerningClienteleSection extends StatelessWidget {
  const HomeOurDiscerningClienteleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 768;

        return Container(
          width: double.infinity,
          color: Color(0XFFebece9),
          padding: AppSpacing.symmetric(context, h: 0.1, v: 0.08),
          child: AppFadeInOnScroll(
            child: isSmallScreen
                ? const HomeOurDiscerningClienteleContentMobile()
                : const HomeOurDiscerningClienteleContentDesktop(),
          ),
        );
      },
    );
  }
}

