import 'package:intl/intl.dart';
import 'package:premium_pay_new/export_files.dart';

// ignore: must_be_immutable
class ContractView extends StatefulWidget {
  Map appModel;
  bool? isAvailable;
  ContractView({Key? key, required this.appModel, this.isAvailable = true})
      : super(key: key);

  @override
  State<ContractView> createState() => _ContractViewState();
}

class _ContractViewState extends State<ContractView> {
  final formKey = GlobalKey<FormState>();
  TextEditingController productController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<String> types = [
    '1.1',
    '2.2',
    '2.3',
    '2.4',
    '2.5',
    '2.6',
    '2.7',
  ];
  // List<String> costs = [
  //   'Настоящее Соглашение заключено между пользователем («Пользователь»), и ООО «Интернет Решения» (ОГРН 1027739244741, ИНН 7704217370),123112, г. Москва, Пресненская наб., д. 10, эт.41, Пом. I, комн. 6, являющимся правообладателем исключительных прав на Программу («Правообладатель»). Соглашение устанавливает условия использования Пользователем Программы.',
  //   'Копируя Программу и устанавливая её на свое мобильное устройство, Пользователь выражает своё полное и безоговорочное согласие со всеми условиями Соглашения.',
  //   'Использование Программы разрешается только на условиях Соглашения. Если Пользователь не принимает условия Соглашения в полном объёме, Пользователь не имеет права использовать Программу в каких-либо целях. Использование Программы с нарушением (невыполнением) какого-либо из условий Соглашения запрещено.',
  //   'Использование Программы на условиях Соглашения в личных некоммерческих целях осуществляется безвозмездно. Использование Программы на условиях и способами, не предусмотренными настоящей Лицензией, возможно только на основании отдельного соглашения с Правообладателем по цене, устанавливаемой Правообладателем.',
  //   'Использование программы Пользователем предполагает его согласие на использование технической информации об устройстве, системе и прикладном программном обеспечении, и периферийных устройствах Пользователя. Правообладатель вправе собирать и использовать технические данные и связанную информацию для улучшения Программы или для предоставления услуг или технологий Пользователю. Правообладатель вправе использовать информацию до тех пор, пока такая информация находится в форме, не позволяющей идентифицировать Пользователя персонально.',
  //   'Пользователь использует Программу в рамках настоящего Соглашения на безвозмездной основе.',
  //   'Пользователь подтверждает, что он является дееспособным и достиг возраста, необходимого в соответствии с законодательством Российской Федерации для заключения настоящего Соглашения и использования Программы в соответствии с её функциональным назначением.',
  // ];
  TextEditingController addressController = TextEditingController();
  // ignore: unused_field
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  bool check = false;

  bool isReady = false;
  bool isloaded = false;
  String? filePath;
  // Future<String> loadFile() async {
  //   final ByteData bytes = await rootBundle.load('assets/docs/oferta.pdf');
  //   final Uint8List list = bytes.buffer.asUint8List();
  //   String? directory = (await getExternalStorageDirectory())?.path;
  //   File imgFile = File('$directory/oferta.pdf');
  //   imgFile.writeAsBytesSync(list);
  //   return imgFile.path;
  // }

  // AppModel? appModel;
  @override
  void initState() {
    // appModel = AppModel.fromJson(widget.appModel);
    // appModel?.step = 6;
    // appModel?.created_time = DateTime.now().toIso8601String();
    // loadFile().then((v) {
    //   filePath = v;
    //   isloaded = true;
    //   setState(() {});
    // });
    super.initState();
  }

  // shareit() async {
  //   Share.share(
  //     Endpoints.domen + "static/docs/oferta.pdf",
  //     subject: 'Публичная оферта Банка',
  //   );
  //   // final permissionStatus = await Permission.storage.status;
  //   // if (permissionStatus.isDenied) {
  //   //   // Here just ask for the permission for the first time
  //   //   await Permission.storage.request();

  //   //   // I noticed that sometimes popup won't show after user press deny
  //   //   // so I do the check once again but now go straight to appSettings
  //   //   if (permissionStatus.isDenied) {
  //   //     await openAppSettings();
  //   //   }
  //   // } else if (permissionStatus.isPermanentlyDenied) {
  //   //   // Here open app settings for user to manually enable permission in case
  //   //   // where permission was permanently denied
  //   //   await openAppSettings();
  //   // } else {
  //   //   var response = await Dio()
  //   //       .get(filePath, options: Options(responseType: ResponseType.bytes));
  //   //   final directory = await getApplicationDocumentsDirectory();
  //   //   String savedPath = directory.path +
  //   //       "/premium-pay/" +
  //   //       DateTime.now().millisecondsSinceEpoch.toString() +
  //   //       ".pdf";
  //   //   File file = await File(savedPath).create(recursive: true);
  //   //   await file.writeAsBytes(response.data);

  //   //   // Do stuff that require permission here
  //   // }
  // }

  LoadingService loadingService = LoadingService();
  showQrCode() async {
    await customBottomSheet(
      context,
      Container(
        height: 420.h,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Публичная оферта PremiumPay',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                height: 1.5,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            QrImageView(
              data: Endpoints.domen + "static/docs/oferta.pdf",
              version: QrVersions.auto,
              size: 250.w,
              errorStateBuilder: (cxt, err) {
                return Container(
                  child: Center(
                    child: Text(
                      'Uh oh! Something went wrong...',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ScrollController controller = ScrollController();

  bool isSelected = false;
  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    print(
        ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i]);
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0.h),
            child: Container(
              color: Color(0xFFE4E4E4).withOpacity(0.6),
              height: 1.0.h,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Договор",
            style: TextStyle(
              color: Color(0XFF242424),
              fontSize: 18.sp,
           fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                controller.animateTo(
                  controller.position.maxScrollExtent,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: SvgPicture.asset(
                  'assets/icons/scroll-btn.svg',
                  width: 16.w,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            )
          ],
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: controller,
          padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocListener<UpdateAppFinishBloc, UpdateAppFinishState>(
                      child: SizedBox(),
                      listener: (context, state) async {
                        if (state is UpdateAppFinishWaitingState) {
                          loadingService.showLoading(context);
                        } else if (state is UpdateAppFinishErrorState) {
                          loadingService.closeLoading(context);
                          if (state.statusCode == 401) {
                            Future.wait([
                              CacheService.remove(
                                CacheService.token,
                              ),
                              CacheService.remove(
                                CacheService.user,
                              )
                            ]);
      
                            Flushbar(
                              backgroundColor: Colors.red.shade700,
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              isDismissible: true,
                              message: "Пожалуйста, войдите снова",
                              messageColor: Colors.white,
                              messageSize: 18.sp,
                              icon: Icon(
                                Icons.error,
                                size: 28.0,
                                color: Colors.white,
                              ),
                              duration: Duration(minutes:1),
                              leftBarIndicatorColor: Colors.red.shade700,
                            ).show(context);
      
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.login,
                              (route) => false,
                            );
                          } else {
                            Flushbar(
                              backgroundColor: Colors.red.shade700,
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              isDismissible: true,
                              message: state.message,
                              messageColor: Colors.white,
                              messageSize: 18.sp,
                              icon: Icon(
                                Icons.error,
                                size: 28.0,
                                color: Colors.white,
                              ),
                              duration: Duration(minutes:1),
                              leftBarIndicatorColor: Colors.red.shade700,
                            ).show(context);
                          }
                        } else if (state is UpdateAppFinishSuccessState) {
                          loadingService.closeLoading(context);
      
                          widget.appModel = state.data;
                          AppController.updateFinish(context,
                              id: widget.appModel["id"].toString(),
                              app: widget.appModel);
                          Navigator.pushReplacementNamed(
                            context,
                            RouteNames.GraphicView,
                            arguments: {
                              "appModel": widget.appModel,
                            },
                          );
                        }
                      }),
                  SizedBox(height: 16.h),
                  SizedBox(height: 0.2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
            SizedBox(
              width: 60.w,
              child: Text(
                DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse( widget.appModel["created_time"].toString())),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 7.0.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
                      SizedBox(
                        width: 194.w,
                        child: Text(
                         "N: PPD-" +  widget.appModel["id"].toString()+   " ONLAYN ELEKTRON OFERTA",
                         
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 9.0.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 70.w,
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  buildCustomerContract(Customer(
                      name: widget.appModel["fullname"].toString().replaceAll("ʻ", "'").replaceAll("‘", "'"),
                      address: (widget.appModel["address"]["home"] ?? "").replaceAll("ʻ", "'").replaceAll("‘", "'"),
                      givenByWhom: widget.appModel["passport_by"].toString(),
                      passportSeria: widget.appModel["passport"]
                          .toString()
                          .substring(0, 2),
                      passportNumber:
                          widget.appModel["passport"].toString().substring(2),
                      givenWhen: widget.appModel["passport_date"].toString(),
                      storeName: 'state.data["name"]',
                      phoneNumber: widget.appModel["phoneNumber"].toString(),
                      phoneNumber2: widget.appModel["phoneNumber2"].toString(),
                        shartnomaDate: DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse( widget.appModel["created_time"].toString())),
      
                      // name: "Shopulotov Shoxrux Asliddin o'g'li",
                      // address: "Mevazor MFY, Farobiy ko'chasi, uy:4 xonadon:47",
                      // givenByWhom: "Samarqand shahar IIBB",
                      // passportSeria: "AD",
                      // passportNumber: "2196960",
                      // givenWhen: "14.05.2017", storeName: '',
                      )),
                  SizedBox(height: 5.h),
                  buildConditions(),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              SizedBox(
                width: 327.w,
                child: GestureDetector(
                  onTap: () => setState(() {
                    isSelected = !isSelected;
                  }),
                  child: Row(
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                            border: isSelected
                                ? null
                                : Border.all(
                                    width: 1.w,
                                    color: Color(0xff242424).withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(6.r),
                            color:
                                !isSelected ? Colors.white : Color(0xffBE52F2),
                            boxShadow: !isSelected
                                ? null
                                : [
                                    BoxShadow(
                                        color:
                                            Color(0xff242424).withOpacity(0.2),
                                        blurRadius: 3.r,
                                        offset: Offset(1.w, 1.h))
                                  ]),
                        child: isSelected
                            ? SvgPicture.asset(
                                "assets/icons/check.svg",
                                // ignore: deprecated_member_use
                                color: Colors.white,
                              )
                            : null,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        width: 292.w,
                        child: Text(
                          "Я ознакомился с публичной офертой и согласен со всем",
                          style: TextStyle(
                              color: Color(0xff242424),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                              height: 1.h),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (isSelected) {
                        final invoice = Invoice(
                          customer: Customer(
                              name: widget.appModel["fullname"].toString().replaceAll("ʻ", "'").replaceAll("‘", "'"),
                              address:
                                  (widget.appModel["address"]["home"] ?? "")
                                      .replaceAll("ʻ", "'").replaceAll("‘", "'"),
                              givenByWhom: widget.appModel["passport_by"]
                                  .toString()
                                  .toString()
                                  .replaceAll("ʻ", "'"),
                              passportSeria: widget.appModel["passport"]
                                  .toString()
                                  .substring(0, 2),
                              passportNumber: widget.appModel["passport"]
                                  .toString()
                                  .substring(2),
                              givenWhen: widget.appModel["passport_date"]
                                  .toString()
                                  .replaceAll("ʻ", "'"),
                              storeName: 'state.data["name"]',
                              phoneNumber:
                                  widget.appModel["phoneNumber"].toString(),
                              phoneNumber2:
                                  widget.appModel["phoneNumber2"].toString(),
                                  
                                  shartnomaDate: DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse( widget.appModel["created_time"].toString())),
                                  ),
                        );
                        PdfOfertaInvoicePdfHelper.generate(invoice,
                                fileName: 'Oferta' +
                                    DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString() +
                                    ".pdf",
                                    appModel: widget.appModel,
                                    )
                            .then((file) async {
                          for (var i = 0; i < 60; i++) {
                            print(">>>>>>>>>>>>>>>>");
                          }
                          await getFileSize(file.path, 1);
                          print(Base64Service()
                              .filetoBase64(file.path)
                              .substring(0, 80));
                          print(Base64Service().filetoBase64(file.path).length);
                          print(file.path);
      
                          // await PdfHelper.openFile(file);
                          await ZayavkaController.updateFinish(context,
                              id: "${widget.appModel["id"]}",
                              contractPdf:
                                  Base64Service().filetoBase64(file.path));
                        });
                      }
                    },
                    child: Container(
                      width: 327.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xffBE52F2)
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xff323247)
                                        .withOpacity(0.3),
                                    offset: Offset(0, 4.h),
                                    blurRadius: 4.r,
                                    // blurStyle: BlurStyle.outer
                                  ),
                                ]
                              : null),
                      child: Text(
                        "Подтвердить оферта договор",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildCustomerContract(Customer customer) => RichText(
        text: TextSpan(
          text: '       MCHJ "BREND TO`LOV"ga tegishli "PREMIUM PAY" tizimi - ',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text:
                  "loyihasi asosida Tijorat banklari tomonidan muomalaga chiqarilgan bank kartasining egasi bo'lgan hamda quyida taklif qilinayotgan shartlarni to'laligicha va sozsiz qabul qilishini elektron shaklda akseptlash (rozilik bildirish) orqali bildirgan jismoniy shaxs ",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            TextSpan(text: "${customer.name}, ".replaceAll("ʻ", "'")),
            TextSpan(
              text: '(pasport: ',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            TextSpan(text: "${customer.passportSeria} "),
            TextSpan(
              text: 'No ',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            TextSpan(text: "${customer.passportNumber} "),
            TextSpan(
              text: '${customer.givenWhen} da ',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            TextSpan(text: customer.givenByWhom),
            TextSpan(
              text: ' tomonidan berilgan), ',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            TextSpan(text: "${customer.address.replaceAll("ʻ", "'")}"),
            TextSpan(
              text:
                  " da yashovchi,mijozning telefon raqami: ",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: "${customer.phoneNumber}, ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(text: "${customer.phoneNumber2} "),
            TextSpan(
              text:
                  "(keyingi o'rinlarda - Qarzdor/mijoz), ikkinchi tomondan,shu bo'yicha Onlayn Elektron ofertani tuzdik.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );

  static Widget buildConditions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "1-§. Elektron oferta predmeti",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2.h),
        RichText(
          text: TextSpan(
              text: '       1. ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Mazkur Elektron ofertada quyidagi tushunchalar ishlatiladi:",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       "BREND TOLOV" ma'suliyati cheklangan jamiyati """,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "(keying o'rinlarda - hamkor tashkilot) - o'zining va/yoki hamkorining savdo shoxobchalaridan tovarni ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: 'onlayn-qarz',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text:
                      "ga sotish yuzasidan Bank bilan hamkorlik qilayotgan yuridik shaxs;",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       PREMIUM PAY tizimi """,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "- Hamkor tashkilotning Bank axborot resurslariga integratsiyalangan maxsus dasturiy mahsuloti bo'lib, u Qarzdor/mijoz tomonidan hamkor tashkilot va/yoki uning hamkorlarining savdo shoxobchalaridan tovarni ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: 'onlayn-qarz',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text: "ga sotib olishga xizmat qiladi;",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       onlayn-qarz - PREMIUM PAY """,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "tizimi orqali hamkor tashkilot va/yoki uning hamkorining savdo shoxobchalaridan xarid qilingan tovar uchun bo'lib to'lash sharti bilan muddatlilik, qaytarishlilik va ta'minlanganlik asosida Bank tomonidan Qarzdorga/mijozga, qarz berilganligi uchun ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: 'foiz va penya ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text: "undirilmagan holda, ajratilgan pul mablag'i;",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       Qarzdor/mijoz - onlayn-qarzga """,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "hamkor tashkilot va/yoki uning hamkori savdo shoxobchasidan tovar sotib oluvchi, O'zbekiston Respublikasi qonun hujjatlarida belgilangan tartibda raqamli identifikatsiyadan (raqamli autentifikatsiyadan) o'tgan, tijorat banklarining biri tomonidan ish haqi loyihasi asosida muomalaga chiqarilgan bank kartasiga egalik qiluvchi O'zbekiston Respublikasi rezidenti bo'lgan jismoniy shaxs; ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: 'foiz va penya ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text: "undirilmagan holda, ajratilgan pul mablag'i;",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "SHARTLAR VA TA'RIFLAR:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10.0.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       Tovar""",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      " - O'zbekiston Respublikasi qonun hujjatlariga muvofiq chakana savdoga chiqarilishi taqiqlanmagan mahalliy yoki import mahsulot;",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       elektron oferta - PREMIUM PAY""",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      " tizimi orqali onlayn-qarz ajratish to'g'risida Bank va Qarzdor/mijoz o'rtasida tuziladigan elektron bitim;",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       qarz beruvchilar""",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      " - tijorat banklari faoliyatini amalga oshiruvchi to'lov tashkiloti;",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       o'rtacha oylik daromad miqdori """,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Qarzdorning/mijozning ish haqi loyihasi asosida muomalaga chiqarilgan bank kartasi orqali [",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: 'elektron oferta ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text:
                      "akseptlangan sanaga nisbatan so'nggi 12 oy (agar 12 oydan kam ishlagan bo'lsa, 6 oydan kam bo'lmagan haqiqatda ishlagan davri) davomida] olgan daromadining o'rtacha arifmetik qiymati. Bunda Qarzdor/mijoz so'nggi 2 oy davomida daromadga ega bo'lishi lozim;",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       Skoring""",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      " - Bank tomonidan elektron axborot resurslari bazalaridan O'zbekiston Respublikasi qonun hujjatlarida belgilangan tartibda olingan ma'lumotlarga asoslangan holda Qazdorning/mijozning tolovga layoqatliligini aniqlash dasturi;",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "Qarzdorning/mijozning tolovga layoqatliligini aniqlash dasturi;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10.0.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       shaxsni tasdiqlovchi hujjat""",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      " - O'zbekiston Respublikasi fuqarosining pasporti yoki ID-kartasi.",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: '       2. ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Elektron ofertaga asosan Bank tomonidan o'tkazilgan pul mablag'i Qarzdorga/mijozga onlayn-qarz sifatida rasmiylashtiriladi.",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.2.h),
        Center(
          child: Text(
            "2-§. Onlayn-qarz ofertasi shartlari",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2.h),
        RichText(
          text: TextSpan(
              text: '       3. ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Onlayn-qarz, Qarzdor/mijoz xohishidan va/yoki to'lov qobilyatidan kelib chiqqan holda, 3 (uch), 6 (olti), 9 (to`qqiz) va 12 (o`ng ikki) oylari muddatlarida ajratiladi.",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: '       4. ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Onlayn-qarz limitining maksimal miqdori 35 000 000 (o`ttiz besh million) so'mdan oshmaydi, minimal miqdori 500 000 (besh yuz ming) so'mni tashkil etadi.",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: '       5. ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Onlayn-qarz ta'minoti sifatida onlayn-qarzning qaytarilmaslik tavakkalchiligi bo'yicha elektron sug'urta polisi rasmiylashtiriladi. Sugurtani rasmiylashtirish xarajati tijorat banklari tizimi hisobidan amalga oshiriladi.",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: '       6. ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Onlayn-qarz Qarzdorga/mijozga skoring tizimi orqali ajratiladi.",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: '       7. Skoringni ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "- amalga oshirish jarayonida quyidagi holatlardan biri mavjud bo'lganda Qarzdorga/mijozga onlayn-qarz ajratilmaydi:",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       a) ilgari olingan kredit va boshqa majburiyatlari bo'yicha muddati o'tgan qarzdorlik mavjud bo'lganda;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10.0.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       b) ilgari olingan kredit va boshqa majburiyatlari bo'yicha onlayn-qarz olish uchun ariza berilgan sanadan boshlab oxirgi 1 (bir) yil davomida 3 va undan ko'p marta 30 kundan ortiq to'lovning kechikish holatlari mavjud bo'lsa;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10.0.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       d) ilgari olingan kredit va boshqa majburiyatlari bo'yicha onlayn-qarz olish uchun ariza berilgan sanadan boshlab oxirgi 1 (bir) yil davomida 1 va undan ko'p marta 90 kundan ortiq to'lovning kechikish holatlari mavjud bo'lsa;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10.0.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          """       e) "Soliq-servis" davlat unitar korxonasi bazasidagi Qarzdor/mijoz daromadi 6 oydan kam bo'lganda;""",
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 10.0.sp,
              color: Colors.black),
        ),
        SizedBox(height: 0.05.h),
        Text(
          """       f) "Soliq-servis" davlat unitar korxonasi bazasida onlayn-qarz so'rab murojaat qilingan oydan oldingi 2 oyda Qarzdorning/mijozning daromadiga oid ma'lumot mavjud bo'lmasa;""",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10.0.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       g) Qarzdor/mijoz yoshi 21 dan 55 gacha bo'lgan yosh diapazoniga tushmaganda;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10.0.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       h) olinayotgan onlayn-qarz qiymatini ham qo'shib hisoblaganda qarz yuki ko'rsatkichi 50 foizdan oshgan taqdirda.",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10.0.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       8. """,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: "Qarzdor/mijoz onlayn-qarzning ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: 'Tasdiqlangan limiti, ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text:
                      "uning qancha qismini ishlatishidan qa`tiy nazar, bir marta foydalanilgandan so'ng o'z kuchini yo'qotgan deb hisoblanadi;",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       9. """,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: "Foydalanilgan ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                TextSpan(
                  text: 'onlayn-qarz ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text:
                      "uchun Qarzdordan/mijozdan foiz yoki foizsiz shaklida to'lov undirilmaydi.",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: """       10. """,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Onlayn-qarz Qarzdor/mijoz tomonidan onlayn-qarzni qaytarish jadvaliga muvofiq qaytariladi. ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ]),
        ),
        SizedBox(height: 0.2.h),
        Center(
          child: Text(
            "3-§. Tomonlarning huquq va majburiyatlari",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2.h),
        RichText(
          text: TextSpan(
            text: """       11. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "Bankning huquqlari:",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.underline,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       a) onlayn-qarz bo'yicha to'lov muddati kelganda, qarzdorlikni Qarzdorning/mijozning bank kartasi hisobvarag'idan akseptsiz undirish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text:
                  """       b) onlayn-qarz belgilangan muddatda qaytarilmaganda, qarzdorlikni Qarzdorning/mijozning Bankdagi va boshqa rezident banklaridagi hisobvaraqlaridan yani """,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 10.0.sp,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: """ "Uzcard va Humo va boshqa turdagi kartalaridan" """,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "akseptsiz undiriladi;",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       d) onlayn-qarzni to'lash muddati buzilganda nizoni hal qilish yuzasidan talabnomani Qarzdorga/mijozga ma'lum qilish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10.0.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text:
                  """       e) onlayn-qarzning uni qaytarish jadvali bo'yicha o'z muddatida to'lanmasligi tufayli""",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 10.0.sp,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: """ "SUG'URTA" """,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      "odisasi sodir bo'lganda, onlayn-qarzni undirish huquqini",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: """ "SUG'URTA" """,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "tashkilotiga o'tkazish.",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ]),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
            text: """       12. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "Bankning majburiyatlari:",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       a) onlayn-qarzni ushbu Elektron ofertada belgilangan shartlarda berish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       b) onlayn-qarzni muddatidan oldin undirish sabablari haqida Qarzdorni/mijozni xabardor etish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       d) Qarzdordan/mijozdan onlayn-qarzning joriy to'lovi uchun onlayn-qarzni qaytarish jadvalida belgilanganga nisbatan ko'p mablag' kelib tushsa, u holda kelib tushgan mablag'ning ortiqcha qismini keyingi oy bo'yicha qarzdorlikni so'ndirishga yo'naltirish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       e) onlayn-qarz bo'yicha muddati o'tkazib yuborilgan qarzdorlik yuzaga kelganda Qarzdor/mijoz zimmasidagi qarz yuki yanada oshib ketishining oldini olish maqsadida ushbu qarzdorlik yuzaga kelgan sanadan boshlab 7 kalendar kuni davomida har qanday aloqa bog'lash usulidan, shu jumladan elektron aloqa vositasidan foydalanib, Qarzdorga/mijozga muddati o'tkazib yuborilgan qarzdorlik yuzaga kelganligi haqida onlayn-qarzni qaytarish jadvalini ilova qilgan holda xabar berish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       f) Qarzdorni/mijozni ushbu Elektron oferta bo'yicha muddati o'tkazib yuborilgan qarzdorlikni qaytarish majburiyati bajarilmaganligi holati, muddati, qiymati, tarkibi va oqibatlari haqida xabardor qilish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       g) Qarzdordan/mijozdan muddati o'tkazib yuborilgan qarzdorlik yuzaga kelishi sabablari haqida so'rash;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       h) Qarzdor/mijoz tomonidan ushbu Elektron oferta bo'yicha onlayn-qarzni qaytarish muddati buzilganda nizoni hal qilish yuzasidan o'z talabnomasini Qarzdorga/mijozga yetkazish (ushbu talabnomada u tuzilgan sanadagi Qarzdorning/mijozning joriy qarzi miqdori va tarkibi, qarzni to'lash usullari, talabnomada ko'rsatilgan muddatgacha Qarzdor/mijoz o'z majburiyatlarini bajarmasligi oqibatlari va nizoni hal qilish usullari qayd etiladi);",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "       i) Qarzdor/mijoz tomonidan onlayn-qarz bo'yicha qarzdorlik to'liq to'langanidan so'ng, qarzdorning/mijozning shaxsiy kabinetida onlayn-qarz bo'yicha qarzdorlik to'liq so'ndirilganligi to'g'risida ma'lumotni avtomat tarzda shakllantirish.",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
            text: """       13. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "Qarzdorning/mijozning huquqlari:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "      a) ushbu Elektron ofertani akseptlash bo'yicha mustaqil qaror qabul qilish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "      b) onlayn-qarzning o'z vaqtida ajratilishini talab qilish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "      d) onlayn-qarzni istalgan vaqtda muddatidan oldin to'liq to'lagan holda ushbu Elektron ofertani muddatidan oldin bekor qilish.",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
            text: """       14. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "Qarzdorning/mijozning majburiyatlari:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "      a) onlayn-qarzni o'z vaqtida qaytarish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        Text(
          "      b) ish haqi loyihasi asosida bank kartasi berilgan korxonadan (tashkilotdan, muassasadan) ishdan bo'shayotganda onlayn-qarzni muddatidan oldin qaytarish.",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 10.0.sp,
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
              text: '       15. Bank - ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0.sp,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Qarzdor/mijoz tomonidan onlayn-qarz hisobiga xarid qilingan tovarlar miqdori, sifati, yetkazib berish tartibi va shakli, ularni butligi yuzasidan javobgar bo'lmaydi.",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ]),
        ),
        SizedBox(height: 0.2.h),
        Center(
          child: Text(
            "4-§. Tomonlarning javobgarligi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 10.0.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2.h),
        RichText(
          text: TextSpan(
            text: """       16. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Tomonlar ushbu Elektron oferta majburiyatlarini bajarmagan yoki lozim darajada bajarmagan taqdirda, ularga nisbatan O'zbekiston Respublikasining qonun hujjatlarida belgilangan tartibda javobgarlik choralari qo'llaniladi.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.2.h),
        Center(
          child: Text(
            "5-§. Fors-major holatlar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 10.0.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2.h),
        RichText(
          text: TextSpan(
            text: """       17. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    """ Tomonlar fors-major holatlar amal qilgan davrda Elektron oferta bo'yicha o'z majburiyatlarining qisman yoki to'liq bajarilmaganligi uchun javob bermaydilar.
        Fors-major holatlarga quyidagilar kiradi: tabiiy hodisalar (zilzila, ko'chki, dovul, qurg'oqchilik va boshqa tabiiy ofat hodisalar) yoki ijtimoiy-iqtisodiy vaziyatlar (iqtisodiy sanksiyalar, harbiy harakatlar, ish tashlashlar, qamallar, davlat tashkilotlarining hamda davlat tashkilotlari o'rtasidagi cheklovchi va taqiqlovchi choralar, Hukumat qarorlari va boshqalar) oqibatida kelib chiqqan favqulodda, joriy sharoitda bartaraf etib bo'lmaydigan va oldindan kutilmagan vaziyatlar, agar ushbu vaziyatlar Elektron ofertani bajarishga bevosita ta'sir ko'rsatgan bo'lsa.
        Fors-major holatlar yuzaga kelganda va to'xtaganda tomonlar bir-birini darhol xabardor qiladilar. Xabarnoma tomonlarda mavjud bo'lgan barcha aloqa vositalari orqali yuboriladi.
        Fors-major holatlar yuzaga kelgan taqdirda majburiyatlarni bajarish muddatini tomonlar fors-major holatlar amal qilgan davrga mutanosib tarzda kechiktiradi. """,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.2.h),
        Center(
          child: Text(
            "6-§. Nizolarni hal qilish",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 10.0.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2.h),
        RichText(
          text: TextSpan(
            text: """       18. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Bank va Qarzdor/mijoz, taraflarning o'zaro roziligiga ko'ra, qonun hujjatlarida belgilangan nizoni hal qilish usullarini qo'llashga, shu jumladan muzokara o'tkazish orqali hal qilishga haqli hisoblanadi.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
            text: """       19. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    """Qarzdor/mijoz nizoni hal qilish yuzasidan ushbu Elektron oferta 14-bandining "h" kichik bandida qayd etilgan talabnomada ko'rsatilgan talablar bajarilmaganligi oqibatida qarzdorlik""",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: """ "SUG'URTA" """,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'tashkiloti tomonidan qoplab berilganda onlayn-qarzni undirish huquqini',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: """ "SUG'URTA" """,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: "tashkilotiga o'tkazadi.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.2.h),
        Center(
          child: Text(
            "7-§. Elektron ofertaning boshqa shartlari",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 10.0.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2.h),
        RichText(
          text: TextSpan(
            text: """       20. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Qarzdor/mijoz Elektron ofertani akseptlash bilan o'z shaxsiga doir ma'lumotlarga ishlov berish rozilik bildirgan hisoblanadi.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
            text: """       21. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Bank Qarzdor/mijoz uchun ushbu Elektron oferta bo'yicha onlayn-qarzni to'lashning masofadan turib amalga oshirish imkoniyatini yaratadi.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
            text: """       22. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Bank onlayn-qarz shartlarini, shu jumladan mazkur Elektron ofertaning amal qilish muddatini bir tomonlama o'zgartirishga haqli emas.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
            text: """       23. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Qarzdor/mijoz vafot etganda uning huquq va majburiyatlari O'zbekiston Respublikasi qonun hujjatlariga muvofiq hal etiladi.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
            text: """       24. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Mazkur Elektron oferta u online tasdiqlangan kundan boshlab to Qarzdor/mijoz tomonidan ushbu Elektron oferta majburiyatlari to'liq bajarilgunga qadar amal qiladi.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
            text: """       25. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Ushbu Elektron ofertaning bekor qilinishi tomonlarni u bekor qilingunga qadar bildirilgan o'zaro da'vosini (talabini) qondirish majburiyatidan ozod qilmaydi.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05.h),
        RichText(
          text: TextSpan(
            text: """       26. """,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0.sp,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Mazkur Elektron ofertada ko'zda tutilmagan holatlar yuzasidan O'zbekiston Respublikasi qonun hujjatlari qo'llaniladi.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AbsorbPointer(
  //     absorbing: !(widget.isAvailable ?? true),
  //     child: Scaffold(
  //       appBar: customAppBar(
  //         context,
  //         "Договор",
  //         action: [
  //           GestureDetector(
  //             onTap: showQrCode,
  //             child: Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 10.w),
  //               child: Icon(CupertinoIcons.qrcode, color: Colors.black),
  //             ),
  //           ),
  //           SizedBox(width: 20.w),
  //         ],
  //       ),
  //       body:

  //      !isloaded   ? Center(
  //       child: CupertinoActivityIndicator(radius: 34.r,color: AppConstant.primaryColor,),
  //      ):   Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 16.w),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(height: 16.h),
  //                   Container(
  //                     width: 360.w,
  //                     height: 470.h,

  //                     margin: EdgeInsets.symmetric(vertical: 4.h),
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(6.r),
  //                       border: Border.all(
  //                         width: 1.sp,
  //                         color: const Color(0xffE8E8E8),
  //                       ),
  //                     ),
  //                     padding: EdgeInsets.symmetric(
  //                         horizontal: 16.w, vertical: 8.h),
  //                     child:
  //                      Column(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [

  //                         // SizedBox(height: 8.h),

  //                     SizedBox(
  //                       height: 450.h,
  //                       child:  PDFView(
  //               filePath: filePath,
  //               fitEachPage: false,
  //               // enableSwipe: true,
  //               // swipeHorizontal: true,

  //               autoSpacing: false,
  //               pageFling: false,
  //               onRender: (_pages) {
  //                 setState(() {
  //                   // pages = _pages;
  //                   isReady = true;
  //                 });
  //               },
  //               onError: (error) {
  //                 print(error.toString());
  //               },
  //               onPageError: (page, error) {
  //                 print('$page: ${error.toString()}');
  //               },
  //               onViewCreated: (PDFViewController pdfViewController) {
  //                 _controller.complete(pdfViewController);
  //               },
  //               onPageChanged: (int? page, int? total) {
  //                 print('page change: $page/$total');
  //               },
  //               ),

  //                     ),
  //                         // Column(
  //                         //   crossAxisAlignment: CrossAxisAlignment.start,
  //                         //   children: List.generate(
  //                         //     types.length,
  //                         //     (index) {
  //                         //       return Padding(
  //                         //         padding: EdgeInsets.only(bottom: 8.h),
  //                         //         child: RichText(
  //                         //           textAlign: TextAlign.left,
  //                         //           text: TextSpan(
  //                         //             text: '${types[index]} ',
  //                         //             style: TextStyle(
  //                         //               color: Colors.black,
  //                         //               fontSize: 14.sp,
  //                         //               fontWeight: FontWeight.w600,
  //                         //               height: 1.5,
  //                         //             ),
  //                         //             children: <TextSpan>[
  //                         //               TextSpan(
  //                         //                 text: costs[index],
  //                         //                 style: TextStyle(
  //                         //                   color: const Color(0xFF666666),
  //                         //                   fontSize: 14.sp,
  //                         //                   fontWeight: FontWeight.w400,
  //                         //                   height: 1.5,
  //                         //                 ),
  //                         //               ),
  //                         //             ],
  //                         //           ),
  //                         //         ),
  //                         //       );
  //                         //     },
  //                         //   ),
  //                         // ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height: 40.h),
  //                     Container(
  //                     width: MediaQuery.of(context).size.width,
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(6.r),
  //                       border: Border.all(
  //                         width: 1.sp,
  //                         color: const Color(0xffE8E8E8),
  //                       ),
  //                     ),
  //                     padding: EdgeInsets.symmetric(
  //                         horizontal: 8.w, vertical: 8.h),
  //                     child: CheckboxListTile(
  //                       controlAffinity: ListTileControlAffinity.leading,
  //                       title: Text(
  //                         'Я прочитал(а) и принимаю условия Пользовательского соглашения и Политики конфиденциальности персональных данных ',
  //                         style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 12.sp,
  //                           fontWeight: FontWeight.w500,
  //                           height: 1.5,
  //                         ),
  //                         textAlign: TextAlign.left,
  //                       ),
  //                       value: check,
  //                       onChanged: (value) {
  //                         setState(
  //                           () {
  //                             if (check == false) {
  //                               check = true;
  //                               value = check;
  //                             } else if (check == true) {
  //                               check = false;
  //                               value = check;
  //                             }
  //                           },
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                   SizedBox(height: 24.h),
  //                   customButton(
  //                     context,
  //                     'Оформить ',
  //                     () async {
  //                       if (check) {
  //                         await ZayavkaController.update7(context,
  //                             id: "${widget.appModel["id"]}");
  //                       }
  //                     },
  //                     Colors.deepPurple.withOpacity(check ? 1 : 0.3),
  //                   ),
  //                   BlocListener<UpdateAppFinishBloc, UpdateAppFinishState>(
  //                       child: SizedBox(),
  //                       listener: (context, state) async {
  //                         if (state is UpdateAppFinishWaitingState) {
  //                           loadingService.showLoading(context);
  //                         } else if (state is UpdateAppFinishErrorState) {
  //                           loadingService.closeLoading(context);
  //                           if (state.statusCode == 401) {
  //                             Future.wait([
  //                               CacheService.remove(
  //                                 CacheService.token,
  //                               ),
  //                               CacheService.remove(
  //                                 CacheService.user,
  //                               )
  //                             ]);

  //                             Flushbar(
  //                               backgroundColor: Colors.red.shade700,
  //                               dismissDirection:
  //                                   FlushbarDismissDirection.HORIZONTAL,
  //                               flushbarPosition: FlushbarPosition.TOP,
  //                               flushbarStyle: FlushbarStyle.GROUNDED,
  //                               isDismissible: true,
  //                               message: "Пожалуйста, войдите снова",
  //                               messageColor: Colors.white,
  //                               messageSize: 18.sp,
  //                               icon: Icon(
  //                                 Icons.error,
  //                                 size: 28.0,
  //                                 color: Colors.white,
  //                               ),
  //                               duration: Duration(minutes:1),
  //                               leftBarIndicatorColor: Colors.red.shade700,
  //                             ).show(context);

  //                             Navigator.pushNamedAndRemoveUntil(
  //                               context,
  //                               RouteNames.login,
  //                               (route) => false,
  //                             );
  //                           } else {
  //                             Flushbar(
  //                               backgroundColor: Colors.red.shade700,
  //                               dismissDirection:
  //                                   FlushbarDismissDirection.HORIZONTAL,
  //                               flushbarPosition: FlushbarPosition.TOP,
  //                               flushbarStyle: FlushbarStyle.GROUNDED,
  //                               isDismissible: true,
  //                               message: state.message,
  //                               messageColor: Colors.white,
  //                               messageSize: 18.sp,
  //                               icon: Icon(
  //                                 Icons.error,
  //                                 size: 28.0,
  //                                 color: Colors.white,
  //                               ),
  //                               duration: Duration(minutes:1),
  //                               leftBarIndicatorColor: Colors.red.shade700,
  //                             ).show(context);
  //                           }
  //                         } else if (state is UpdateAppFinishSuccessState) {
  //                           loadingService.closeLoading(context);

  //                           widget.appModel = state.data;
  //                              AppController.update7(context,
  //                               id: widget.appModel["id"].toString(),app: widget.appModel);
  //                           Navigator.pushReplacementNamed(
  //                             context,
  //                             RouteNames.SelfieWithCheckView,
  //                             arguments: {
  //                               "appModel": widget.appModel,
  //                             },
  //                           );
  //                         }
  //                       }),
  //                   SizedBox(height: 16.h),

  //                 ],
  //               ),
  //             ),
  //     ),
  //   );
  // }
}
