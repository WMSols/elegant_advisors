import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/app_fade_in_on_scroll.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_unparalleled_expertise_content.dart';

class HomeUnparalleledExpertiseSection extends StatelessWidget {
  const HomeUnparalleledExpertiseSection({super.key});

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
                ? const HomeUnparalleledExpertiseContentMobile()
                : const HomeUnparalleledExpertiseContentDesktop(),
          ),
        );
      },
    );
  }
}
