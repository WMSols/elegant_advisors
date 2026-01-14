import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/presentation/admin/widgets/layout/backgrounds/admin_background.dart';
import 'package:elegant_advisors/presentation/admin/widgets/navigation/panels/admin_navigation_panel.dart';
import 'package:elegant_advisors/presentation/admin/widgets/layout/headers/admin_header.dart';
import 'package:elegant_advisors/data/services/auth_service.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';

/// Shared admin layout with fixed navigation panel for all admin screens
class AdminLayout extends StatefulWidget {
  final String title;
  final Widget child;
  final bool showHeader;

  const AdminLayout({
    super.key,
    required this.title,
    required this.child,
    this.showHeader = true,
  });

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout>
    with AutomaticKeepAliveClientMixin {
  final AuthService _authService = AuthService();
  final adminName = 'Admin'.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Cache admin name to prevent reloading on every navigation
  static String? _cachedAdminName;
  static bool _isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadAdminName();
  }

  Future<void> _loadAdminName() async {
    // Use cached name immediately if available
    if (_cachedAdminName != null) {
      adminName.value = _cachedAdminName!;
      return;
    }

    // Prevent multiple simultaneous loads
    if (_isLoading) return;
    _isLoading = true;

    try {
      final adminUser = await _authService.getAdminUserData();
      String name;
      if (adminUser != null) {
        name = adminUser.name.isNotEmpty
            ? adminUser.name
            : (adminUser.email.split('@').first);
      } else {
        final user = _authService.currentUser;
        if (user != null) {
          name = user.email?.split('@').first ?? 'Admin';
        } else {
          name = 'Admin';
        }
      }

      // Cache the name and update the observable
      _cachedAdminName = name;
      adminName.value = name;
    } catch (e) {
      // Fallback to email if name loading fails
      final user = _authService.currentUser;
      String name;
      if (user != null) {
        name = user.email?.split('@').first ?? 'Admin';
      } else {
        name = 'Admin';
      }

      // Cache the fallback name
      _cachedAdminName = name;
      adminName.value = name;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _logout() async {
    // Clear cached admin name on logout
    _cachedAdminName = null;
    _isLoading = false;
    await _authService.signOut();
    Get.offAllNamed(AdminConstants.routeAdminLogin);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final isMobile = AppResponsive.isMobile(context);

    return Scaffold(
      key: scaffoldKey,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Make padding responsive to available space
          final availableHeight = constraints.maxHeight;
          final availableWidth = constraints.maxWidth;
          final isVerySmall = availableHeight < 200 || availableWidth < 400;

          final spacing = isVerySmall
              ? AppResponsive.scaleSize(context, 4, min: 2, max: 8)
              : AppResponsive.scaleSize(context, 16, min: 12, max: 20);

          return Stack(
            children: [
              const AdminBackground(),
              Padding(
                padding: EdgeInsets.all(spacing),
                child: Row(
                  children: [
                    // Navigation Panel (Desktop) - Fixed and Reactive
                    if (!isMobile)
                      Obx(
                        () => AdminNavigationPanel(
                          currentRoute: Get.currentRoute,
                          adminName: adminName.value,
                          onLogout: _logout,
                        ),
                      ),
                    // Main Content - No white background, background image shows through
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          // Check if we have enough space for header
                          // Hide header if less than 60px available to prevent overflow
                          final availableHeight = constraints.maxHeight;
                          final hasEnoughSpaceForHeader = availableHeight > 60;

                          // If space is extremely limited, just show content
                          if (availableHeight < 30) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: availableHeight,
                              ),
                              child: widget.child,
                            );
                          }

                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: availableHeight,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Header - Only show if we have enough space, make it shrinkable
                                if (widget.showHeader &&
                                    hasEnoughSpaceForHeader)
                                  Flexible(
                                    flex: 0,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: availableHeight < 200
                                            ? availableHeight * 0.2
                                            : 80.0,
                                      ),
                                      child: isMobile
                                          ? AppBar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                              toolbarHeight:
                                                  availableHeight < 200
                                                  ? availableHeight * 0.2
                                                  : null,
                                              leading: AppIconButton(
                                                icon: Iconsax.menu_1,
                                                color: AppColors.white,
                                                iconSize: AppResponsive.scaleSize(
                                                  context,
                                                  24,
                                                  min: 16,
                                                  max: 28,
                                                ),
                                                onPressed: () {
                                                  scaffoldKey.currentState
                                                      ?.openDrawer();
                                                },
                                                tooltip: 'Menu',
                                              ),
                                              title: Text(
                                                widget.title,
                                                style:
                                                    AppTextStyles.headline(
                                                      context,
                                                    ).copyWith(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          availableHeight < 200
                                                          ? AppResponsive.scaleSize(
                                                              context,
                                                              14,
                                                              min: 12,
                                                              max: 18,
                                                            )
                                                          : null,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            )
                                          : ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxHeight: availableHeight < 200
                                                    ? availableHeight * 0.2
                                                    : 60.0,
                                              ),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        availableHeight < 200
                                                        ? 4.0
                                                        : 8.0,
                                                  ),
                                                  child: AdminHeader(
                                                    title: widget.title,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                // Content - Flexible to take remaining space (can shrink)
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: hasEnoughSpaceForHeader
                                          ? availableHeight -
                                                (availableHeight < 200
                                                    ? availableHeight * 0.2
                                                    : 80)
                                          : availableHeight,
                                    ),
                                    child: widget.child,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      // Mobile Drawer - Fixed and Reactive
      drawer: isMobile
          ? Obx(
              () => AdminNavigationPanel(
                currentRoute: Get.currentRoute,
                adminName: adminName.value,
                onLogout: _logout,
              ),
            )
          : null,
    );
  }
}
