import 'package:premium_pay_new/export_files.dart';

class AppController {
  static Future<void> get(
    BuildContext context,
    //  {
    // required String loginName,
    // required String loginPassword,
    // }
  ) async {
    try {
      await BlocProvider.of<GetAppsBloc>(context).get();
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static Future<void> refresh(
    BuildContext context,
    //  {
    // required String loginName,
    // required String loginPassword,
    // }
  ) async {
    try {
      await BlocProvider.of<GetAppsBloc>(context).refresh();
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static void add(
    BuildContext context,
  ) async {
    try {
      await BlocProvider.of<GetAppsBloc>(context).add();
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static void update1(BuildContext context, {Map? app,}) async {
    try {
      BlocProvider.of<GetAppsBloc>(context)
          .update1(app: app,);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static void update2(BuildContext context, { String? id,Map? app}) async {
    try {
      BlocProvider.of<GetAppsBloc>(context).update2(id: id,app: app);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static void update3(BuildContext context, { String? id,Map? app}) async {
    try {
      BlocProvider.of<GetAppsBloc>(context).update3(id: id,app: app);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static void update5(BuildContext context, { String? id,double? total,Map? app}) async {
    try {
      BlocProvider.of<GetAppsBloc>(context).update5(id: id,total:total,app: app);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static void update6(BuildContext context, { String? id,Map? app}) async {
    try {
      BlocProvider.of<GetAppsBloc>(context).update6(id: id,app: app);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static void update7(BuildContext context, { String? id,Map? app}) async {
    try {
      BlocProvider.of<GetAppsBloc>(context).update7(id: id,app: app);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }

  static void updateFinish(BuildContext context,
      { String? id,Map? app}) async {
    try {
      BlocProvider.of<GetAppsBloc>(context).updateFinish(id: id,app: app);
    } catch (e, track) {
      print("Manager Error >>" + e.toString());
      print("Manager track >>" + track.toString());
    }
  }
}
