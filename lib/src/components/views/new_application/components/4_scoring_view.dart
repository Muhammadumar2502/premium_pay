import 'package:premium_pay_new/export_files.dart';

// ignore: must_be_immutable
class ScoringView extends StatefulWidget {
  Map appModel;
  bool? isAvailable;
  ScoringView({Key? key, required this.appModel, this.isAvailable})
      : super(key: key);

  @override
  State<ScoringView> createState() => _ScoringViewState();
}

class _ScoringViewState extends State<ScoringView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController productController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<String> months = [
    '3 месяца',
    '6 месяца',
    '9 месяца',
    '12 месяца',
  ];
  List<String> rejections = [
    'Передумал',
    'Высокий процент',
    'Не доверяет сервису',
    'Хочет посмотреть другие сервисы',
  ];

  List<String> costs = [
    '3,000,000 сум',
    '6,000,000 сум',
    '9,000,000 сум',
    '9,000,000 сум'
  ];
  int radioListValue = 0;
  // AppModel? appModel;
  @override
  void initState() {
    // appModel = AppModel.fromJson(widget.appModel);
    // appModel?.step =3;
    // appModel?.finished_time= DateTime.now().toIso8601String();
    super.initState();
  }

  Widget build(BuildContext context) {
    Future.delayed(
        Duration(
          seconds: 6,
        ), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Color(0xFFE4E4E4).withOpacity(0.6),
              height: 1.0,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Скоринг",
            style: TextStyle(
              color: Color(0XFF242424),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Builder(
            builder: (context) => GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: SvgPicture.asset(
                  'assets/icons/back.svg',
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 1.3,
                child: CircularProgressIndicator(
                  color: const Color(0xffBE52F2),
                  strokeWidth: 4.w,
                  strokeAlign: 2,
                  strokeCap: StrokeCap.round,
                  backgroundColor: const Color(0xffBE52F2).withOpacity(0.2),
                ),
              ),
              SizedBox(
                height: 48.h,
              ),
              SizedBox(
                width: 365.w,
                child: Text(
                  "Мы почти закончили!\n Ваша информация обрабатывается...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AbsorbPointer(
  //   absorbing: !(widget.isAvailable?? true),
  //     child: Scaffold(
  //       appBar: customAppBar(context, "Скоринг",),
  //       body: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 16.w),
  //         child: Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [

  //               Transform.scale(
  //                 scale: 2,
  //                 child: Lottie.asset("assets/animations/scoring.json",height: 600.h,))
  //               // SizedBox(height: 16.h),
  //               // Container(
  //               //   width: MediaQuery.of(context).size.width,
  //               //   decoration: BoxDecoration(
  //               //     color: Colors.white,
  //               //     borderRadius: BorderRadius.circular(6.r),
  //               //     border: Border.all(
  //               //       width: 1.sp,
  //               //       color: const Color(0xffE8E8E8),
  //               //     ),
  //               //   ),
  //               //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  //               //   child: Text(
  //               //     'Ваша заявка отправлена в скоринг \n ожидайте',
  //               //     style: TextStyle(
  //               //       color: const Color(0xFF666666),
  //               //       fontSize: 16.sp,
  //               //       fontWeight: FontWeight.w400,
  //               //       height: 1.5,
  //               //     ),
  //               //     textAlign: TextAlign.center,
  //               //   ),
  //               // ),
  //               // SizedBox(height: 8.h),
  //               // Container(
  //               //   width: MediaQuery.of(context).size.width,
  //               //   decoration: BoxDecoration(
  //               //     color: Colors.white,
  //               //     borderRadius: BorderRadius.circular(6.r),
  //               //     border: Border.all(
  //               //       width: 1.sp,
  //               //       color: const Color(0xffE8E8E8),
  //               //     ),
  //               //   ),
  //               //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  //               //   child: RichText(
  //               //     textAlign: TextAlign.center,
  //               //     text: TextSpan(
  //               //       text:
  //               //           'Поздравляем! Вам был одобрен лимит с максимальной суммой покупки до\n',
  //               //       style: TextStyle(
  //               //         color: const Color(0xFF666666),
  //               //         fontSize: 16.sp,
  //               //         fontWeight: FontWeight.w400,
  //               //         height: 1.5,
  //               //       ),
  //               //       children: <TextSpan>[
  //               //         TextSpan(
  //               //           text: '12.000.000 сум',
  //               //           style: TextStyle(
  //               //             color: Colors.black,
  //               //             fontSize: 16.sp,
  //               //             fontWeight: FontWeight.w600,
  //               //             height: 1.5,
  //               //           ),
  //               //         ),
  //               //       ],
  //               //     ),
  //               //   ),
  //               // ),
  //               // SizedBox(height: 8.h),
  //               // Column(
  //               //   children: List.generate(
  //               //     4,
  //               //     (index) {
  //               //       return Container(
  //               //         width: MediaQuery.of(context).size.width,
  //               //         margin: EdgeInsets.symmetric(vertical: 4.h),
  //               //         decoration: BoxDecoration(
  //               //           color: Colors.white,
  //               //           borderRadius: BorderRadius.circular(6.r),
  //               //           border: Border.all(
  //               //             width: 1.sp,
  //               //             color: const Color(0xffE8E8E8),
  //               //           ),
  //               //         ),
  //               //         padding:
  //               //             EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  //               //         child: RichText(
  //               //           textAlign: TextAlign.center,
  //               //           text: TextSpan(
  //               //             text: '${months[index]}\n',
  //               //             style: TextStyle(
  //               //               color: const Color(0xFF666666),
  //               //               fontSize: 14.sp,
  //               //               fontWeight: FontWeight.w400,
  //               //               height: 1.5,
  //               //             ),
  //               //             children: <TextSpan>[
  //               //               TextSpan(
  //               //                 text: costs[index],
  //               //                 style: TextStyle(
  //               //                   color: Colors.black,
  //               //                   fontSize: 16.sp,
  //               //                   fontWeight: FontWeight.w600,
  //               //                   height: 1.5,
  //               //                 ),
  //               //               ),
  //               //             ],
  //               //           ),
  //               //         ),
  //               //       );
  //               //     },
  //               //   ),
  //               // ),
  //               // const Spacer(),
  //               // customButton(context, 'Продолжить', () {
  //               //   Navigator.pushReplacementNamed(
  //               //     context,
  //               //     RouteNames.purchaseView,
  //               //     arguments: {
  //               //       "appModel": appModel?.toJson(),
  //               //     },
  //               //   );
  //               // }, Colors.deepPurple),
  //               // SizedBox(height: 8.h),
  //               // customButton(context, 'Отказ клиента', () {
  //               //   customBottomSheet(context, scoringWidget());
  //               // }, Colors.grey.shade400),
  //               // SizedBox(height: 16.h),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  scoringWidget<Widget>() {
    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: 350.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Container(
                  width: 60.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                Column(
                  children: List.generate(
                    4,
                    (index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: index == 5
                              ? const Border()
                              : Border(
                                  bottom: BorderSide(
                                    width: 0.1.sp,
                                  ),
                                ),
                        ),
                        child: RadioListTile(
                          title: Text(
                            rejections[index],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: index,
                          onChanged: (value) {
                            setState(() {
                              radioListValue = value!;
                            });
                          },
                          groupValue: radioListValue,
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                customButton(
                  context,
                  'Применить',
                  () {
                    Navigator.of(context).pop();
                  },
                  Colors.deepPurple,
                ),
                SizedBox(height: 16.sp),
              ],
            ),
          ),
        );
      },
    );
  }
}
