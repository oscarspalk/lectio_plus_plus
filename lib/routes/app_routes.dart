import 'package:auto_route/auto_route.dart';
import 'package:lectio_plus_plus/routes/app_routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          children: [
            AutoRoute(
              page: BaseRoute.page,
              children: [
                AutoRoute(
                  page: SchemaRoute.page,
                ),
                AutoRoute(page: HomeworkRoute.page),
                AutoRoute(
                  page: MoreRoute.page,
                ),
              ],
            ),
            AutoRoute(page: SchemaEventRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
        AutoRoute(page: AppStartingRoute.page, initial: true),
        AutoRoute(
          page: AuthWrapperRoute.page,
          children: [
            AutoRoute(page: SelectGymRoute.page),
            AutoRoute(page: LoginRoute.page),
            AutoRoute(page: UniloginRoute.page),
          ],
        ),
      ];
}
