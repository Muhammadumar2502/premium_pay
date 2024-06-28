import 'package:premium_pay_new/export_files.dart';

class NotFoundView extends StatefulWidget {
  const NotFoundView({super.key});

  @override
  State<NotFoundView> createState() => _NotFoundViewState();
}

class _NotFoundViewState extends State<NotFoundView> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "PAGE NOT FOUND",
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
