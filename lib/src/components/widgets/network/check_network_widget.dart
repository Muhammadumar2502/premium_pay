import 'package:flutter/cupertino.dart';
import 'package:premium_pay_new/export_files.dart';

enum NetworkResult { on, off }

// ignore: must_be_immutable
class CheckNetworkWidget extends StatefulWidget {
  Widget? child;
  CheckNetworkWidget({super.key, required this.child});

  @override
  State<CheckNetworkWidget> createState() => _CheckNetworkWidgetState();
}

class _CheckNetworkWidgetState extends State<CheckNetworkWidget> {
  NetworkResult result = NetworkResult.on;
  StreamSubscription<ConnectivityResult>? subscription;

  startListen() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult res) async {
      if (res != ConnectivityResult.none) {
        result = (await InternetConnectionChecker().hasConnection)
            ? NetworkResult.on
            : NetworkResult.off;
      } else {
        result = NetworkResult.off;
      }
               setState(() => {});
    });
  }

  cancelListen() {
    subscription!.cancel();
  }

  initChecker() async {
    result = (await InternetConnectionChecker().hasConnection)
        ? NetworkResult.on
        : NetworkResult.off;
                    if (mounted) {
                      setState(() => {});
                    }
                  
  }

  @override
  void initState() {
    initChecker();
    startListen();
    super.initState();
  }

  @override
  void dispose() {
    cancelListen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        result == NetworkResult.off
            ? AbsorbPointer(
                child: widget.child ?? const SizedBox(),
              )
            : widget.child!,
        AnimatedCrossFade(
          reverseDuration: const Duration(milliseconds: 1),
          duration: const Duration(milliseconds: 1),
          crossFadeState: result == NetworkResult.off
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: 
          Container(
            width: 1.sw,
            height: 1.sh,
            color: Colors.black12,
            child: Center(
              child: CupertinoAlertDialog(
                title: Text(
                  'Нет интернет',
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
                content: Text(
                  'Пожалуйста, проверьте интернет',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      result = (await InternetConnectionChecker().hasConnection)
                          ? NetworkResult.on
                          : NetworkResult.off;
                    if (mounted) {
                      setState(() => {});
                    }
                    },
                    child: Text(
                      'понятно',
                      style: TextStyle(
                        color: AppConstant.primaryColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
         
          secondChild: const SizedBox(),
        ),
      ],
    );
  }
}
