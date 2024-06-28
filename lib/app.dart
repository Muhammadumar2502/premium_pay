import 'package:premium_pay_new/src/blocs/6_card/check/check_bloc.dart';
import 'package:premium_pay_new/src/blocs/6_card/send/sendOtp_bloc.dart';
import 'package:premium_pay_new/src/blocs/6_card/verify/verify_bloc.dart';

import 'export_files.dart';

class PremiumPayMobile extends StatelessWidget {
  
  const PremiumPayMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: providers,
          child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RouteNames.splashView,
              onGenerateRoute: FullRoutes.ongenerateRoute,
              title: 'Premium Pay',
              theme: ThemeData(
                // primarySwatch: Colors.deepPurple,
                
                highlightColor: Colors.transparent,
                colorSchemeSeed: state.seedColor,
                brightness:
                    state.appBrightness ? Brightness.light : Brightness.dark,
                // splashColor: Colors.transparent,
                // textTheme:
                // Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              ),
              home: child,
              builder: MaterialAppCustomBuilder.builder,
            );
          }),
        );
      },
    );
  
  }

  

}

List<BlocProvider> providers = [
  BlocProvider<LoginBloc>(
    create: (BuildContext context) => LoginBloc(),
    lazy: false,
  ),
  BlocProvider<MyidBloc>(
    create: (BuildContext context) => MyidBloc(),
    lazy: false,
  ),
  BlocProvider<MyidCheckBloc>(
    create: (BuildContext context) => MyidCheckBloc(),
    lazy: false,
  ),
  BlocProvider<GetAppsBloc>(
    create: (BuildContext context) => GetAppsBloc(),
    lazy: false,
  ),
  BlocProvider<ThemeCubit>(
    create: (BuildContext context) => ThemeCubit(),
    lazy: false,
  ),
  BlocProvider<UpdateApp1Bloc>(
    create: (BuildContext context) => UpdateApp1Bloc(),
    lazy: false,
  ),
  BlocProvider<UpdateApp2Bloc>(
    create: (BuildContext context) => UpdateApp2Bloc(),
    lazy: false,
  ),
  BlocProvider<UpdateApp3Bloc>(
    create: (BuildContext context) => UpdateApp3Bloc(),
    lazy: false,
  ),
  BlocProvider<UpdateApp5Bloc>(
    create: (BuildContext context) => UpdateApp5Bloc(),
    lazy: false,
  ),
  BlocProvider<UpdateApp6Bloc>(
    create: (BuildContext context) => UpdateApp6Bloc(),
    lazy: false,
  ),
  BlocProvider<UpdateApp7Bloc>(
    create: (BuildContext context) => UpdateApp7Bloc(),
    lazy: false,
  ),
  BlocProvider<UpdateAppFinishBloc>(
    create: (BuildContext context) => UpdateAppFinishBloc(),
    lazy: false,
  ),
  BlocProvider<GetPercentsBloc>(
    create: (BuildContext context) => GetPercentsBloc(),
    lazy: false,
  ),
  BlocProvider<CancelByClientBloc>(
    create: (BuildContext context) => CancelByClientBloc(),
    lazy: false,
  ),
   BlocProvider<MerchantBloc>(
    create: (BuildContext context) => MerchantBloc(),
    lazy: false,
  ),


   BlocProvider<CardCheckBloc>(
    create: (BuildContext context) => CardCheckBloc(),
    lazy: false,
  ),
   BlocProvider<CardSendOtpBloc>(
    create: (BuildContext context) => CardSendOtpBloc(),
    lazy: false,
  ),
   BlocProvider<CardVerifyBloc>(
    create: (BuildContext context) => CardVerifyBloc(),
    lazy: false,
  ),
];
