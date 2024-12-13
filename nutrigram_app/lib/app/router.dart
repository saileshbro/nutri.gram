import 'package:auto_route/auto_route.dart';
import 'package:nutrigram_app/ui/views/auth/login/login_view.dart';
import 'package:nutrigram_app/ui/views/auth/register/register_view.dart';
import 'package:nutrigram_app/ui/views/auth/verification/verification_view.dart';
import 'package:nutrigram_app/ui/views/dashboard/dashboard_view.dart';
import 'package:nutrigram_app/ui/views/nutrient_info_display/nutrient_info_display_view.dart';
import 'package:nutrigram_app/ui/views/onboarding/onboarding_view.dart';
import 'package:nutrigram_app/ui/views/profile/change_image/change_image_view.dart';
import 'package:nutrigram_app/ui/views/scan/scan_preview/scan_preview_view.dart';
import 'package:nutrigram_app/ui/views/startup/startup_view.dart';
import 'package:nutrigram_app/ui/views/view_more_graph/view_more_graph_view.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartUpView, initial: true),
        AutoRoute(page: LoginView),
        AutoRoute(page: RegisterView),
        AutoRoute(page: OnboardingView),
        AutoRoute(page: VerificationView),
        AutoRoute(page: ChangeImageView),
        AutoRoute(page: NutrientInfoDisplayView),
        AutoRoute(page: ViewMoreGraphView),
        CustomRoute(
          page: ScanPreviewView,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 300,
        ),
        CustomRoute(
          page: DashboardView,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 300,
        ),
      ];
}
