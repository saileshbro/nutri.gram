import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';

import 'package:nutrigram_app/ui/views/auth/login/login_view.dart';
import 'package:nutrigram_app/ui/views/auth/register/register_view.dart';
import 'package:nutrigram_app/ui/views/auth/verification/verification_view.dart';
import 'package:nutrigram_app/ui/views/dashboard/dashbord_view.dart';
import 'package:nutrigram_app/ui/views/nutrient_info_display/nutrient_info_display_view.dart';
import 'package:nutrigram_app/ui/views/onboarding/onboarding_view.dart';
import 'package:nutrigram_app/ui/views/profile/change_image/change_image_view.dart';
import 'package:nutrigram_app/ui/views/scan/scan_preview/scan_preview_view.dart';
import 'package:nutrigram_app/ui/views/startup/startup_view.dart';
import 'package:nutrigram_app/ui/views/view_more_graph/view_more_graph_view.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: VerificationView),
    MaterialRoute(page: ChangeImageView),
    MaterialRoute(page: NutrientInfoDisplayView),
    MaterialRoute(page: ViewMoreGraphView),
    CustomRoute<bool>(
        page: ScanPreviewView, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute<bool>(
        page: DashboardView, transitionsBuilder: TransitionsBuilders.fadeIn),
  ],
  preferRelativeImports: false,
)
class $Router {}
