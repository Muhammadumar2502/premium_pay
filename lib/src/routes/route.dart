import 'package:premium_pay_new/export_files.dart';

class FullRoutes {
  static Route ongenerateRoute(RouteSettings settings) {
    String? routeName = settings.name;
    dynamic args = settings.arguments;
    print("routeName:"+(routeName ?? ""));

    switch (routeName) {
     
      case RouteNames.splashView:
        return customPageRoute(SplashView());
      case RouteNames.login:
        return customPageRoute(RegisterView());
      case RouteNames.applicationView:
        return customPageRoute(ApplicationView());
      case RouteNames.infoView:
        return customPageRoute(InfoView());
      case RouteNames.new_application:
        return customPageRoute(NewApplicationView());

      case RouteNames.searchView:
        return customPageRoute(SearchView(
          apps: args["apps"],
        ));

      case RouteNames.progressAppView:
        return customPageRoute(ProgressAppView(
          app: args["app"],
        ));

      case RouteNames.finishedAppView:
        return customPageRoute(FinishedAppView(
          app: args["app"],
        ));

      case RouteNames.canceledAppView:
        return customPageRoute(CanceledAppView(
          app: args["app"],
        ));



      case RouteNames.identificationView:
        return customPageRoute(IdentificationView(
          appModel: args["appModel"],
          isAvailable: args["isAvailable"],

        ));
      case RouteNames.customerDataView:
        return customPageRoute(
          CustomerDataView(
          myidInfo: args["myidInfo"],
          birthDate: args["birthDate"],
          appModel: args["appModel"],
          isAvailable: args["isAvailable"],
        ));
      case RouteNames.scoringView:
        return customPageRoute(ScoringView(
          appModel: args["appModel"],
          isAvailable: args["isAvailable"],
        ));
      case RouteNames.SelfieWithCheckView:
        return customPageRoute(SelfieWithCheckView(
          appModel: args["appModel"],
          isAvailable: args["isAvailable"],
        ));
         case RouteNames.SelfieWithPassportView:
        return customPageRoute(SelfieWithPassportView(
          appModel: args["appModel"],
          isAvailable: args["isAvailable"],
        ));
      case RouteNames.productsView:
        return customPageRoute(ProductsView(
          appModel: args["appModel"],
          isAvailable: args["isAvailable"],
        ));
      case RouteNames.contractView:
        return customPageRoute(ContractView(
          appModel: args["appModel"],
          isAvailable: args["isAvailable"],
        ));
      case RouteNames.DecorView:
        return customPageRoute(DecorView(
          appModel: args["appModel"],
          isAvailable: args["isAvailable"],
          total:args["total"]
        ));
      case RouteNames.SelfieWithCheckView:
        return customPageRoute(SelfieWithCheckView(
          appModel: args["appModel"],
        ));
  case RouteNames.GraphicView:
        return customPageRoute(GraphicView(
          appModel: args["appModel"],
        ));
        

      default:
        return customPageRoute(const NotFoundView());
    }
  }

  static customPageRoute(Widget child) {
    return MaterialPageRoute(
      builder: (context) => child,
    );
  }
}
