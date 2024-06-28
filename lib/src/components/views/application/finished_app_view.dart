import 'package:intl/intl.dart';
import 'package:premium_pay_new/export_files.dart';
import 'package:premium_pay_new/src/models/app_model.dart';
import 'package:path/path.dart' as path;

// ignore: must_be_immutable
class FinishedAppView extends StatefulWidget {
  var app;
  FinishedAppView({Key? key, required this.app}) : super(key: key);

  @override
  State<FinishedAppView> createState() => _FinishedAppViewState();
}

class _FinishedAppViewState extends State<FinishedAppView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  AppModel? appModel;
  @override
  void initState() {
    // appModel = AppModel.fromJson(app);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            "ID: " + widget.app["id"].toString(),
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
                padding: EdgeInsets.all(18.w),
                child: SvgPicture.asset(
                  'assets/icons/back.svg',
                ),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, RouteNames.GraphicView,
                    arguments: {
                      "appModel": widget.app,
                    });
              },
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: SvgPicture.asset(
                  'assets/icons/calendar.svg',
                  width: 28.w,
                ),
              ),
            ),
            // SizedBox(width: 16.w),
            SizedBox(width: 8.w),
          ],
        ),
        body: Stack(
          children: [
            SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Имя",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.app["fullname"].toString().split(" ")[0],
                                style: TextStyle(
                                  color: Color(0xff242424),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Фамилия",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.app["fullname"].toString().split(" ")[1],
                                style: TextStyle(
                                  color: Color(0xff242424),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Номер телефона",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 150.w,
                                child: Text(
                                 heshPhoneNumber(widget.app["phoneNumber"]) +"\n"+  heshPhoneNumber(widget.app["phoneNumber2"]),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Color(0xff242424),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Дата",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.app["created_time"]
                                    .toString()
                                    .split("T")[0]
                                    .split("-")
                                    .reversed
                                    .join("/"),
                                style: TextStyle(
                                  color: Color(0xff242424),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Срок",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.app["expired_month"].toString() +
                                    " месяцев",
                                style: TextStyle(
                                  color: Color(0xff242424),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Цена",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                toMoney(widget.app["payment_amount"])
                                        .toString() +
                                    " сум",
                                style: TextStyle(
                                  color: Color(0xff242424),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Продукты",
                                style: TextStyle(
                                  color: Color(0XFF151522),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 240.w,
                                child: Text(
                                  widget.app["products"] == null
                                      ? " - - -"
                                      : (widget.app["products"] as List)
                                          .map((e) => e["name"])
                                          .toList()
                                          .join(","),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Color(0xff242424),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
      
                              // Text(
      
                              //   "iphone 13, airpods",
                              //   style: TextStyle(
                              //     color: Color(0xff242424),
                              //     fontSize: 13.sp,
                              //     fontWeight: FontWeight.w300,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Color(0XFF151522).withOpacity(0.1),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        // if (widget.app["canceled_reason"] != null)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Статус",
                                    style: TextStyle(
                                      color: const Color(0XFF151522),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    // widget.app["canceled_reason"],
                                    "Успешно",
                                    style: TextStyle(
                                      color: const Color(0xff242424),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Divider(
                              thickness: 1.h,
                              color: Color(0XFF151522).withOpacity(0.1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                "assets/images/success_bg.png",
                width: 1.sw,
                fit: BoxFit.fitWidth,
                // height: 400.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> generatePdf(
    Map appModel,
    MerchantSuccessState state,
  ) async {
    List items = (appModel["products"] as List)
        .map((value) => {
              'name': value["name"],
              'quantity': 1,
              'packaging': 'Bor',
              'cost': toMoney(value["price"]),
            })
        .toList();
    final date = DateTime.now();
    final dueDate = DateTime(
        date.year, date.month + (appModel["expired_month"] as int), date.day);

    final invoice = Invoice(
      supplier: Supplier(
        // za
        name: state.data["name"],
        address: "Oqoltin MFY, Zarbdor ko'chasi, uy:8 xonadon:47",
        fromWhichStore: 'Artel',
      ),
      customer: Customer(
        name: appModel["fullname"].toString(),
        address: appModel["address"].toString(),
        givenByWhom: appModel["passport_by"].toString(),
        passportSeria: appModel["passport"].toString().substring(0, 2),
        passportNumber: appModel["passport"].toString().substring(2),
        givenWhen: appModel["passport_date"].toString(),
        storeName: state.data["name"],
        phoneNumber: appModel["phoneNumber"].toString(),
        phoneNumber2: appModel["phoneNumber2"].toString(),
        shartnomaDate: DateFormat('dd-MM-yyyy hh:mm')
            .format(DateTime.parse(appModel["created_time"].toString())),
      ),
      info: InvoiceInfo(
        date: DateTime.parse(appModel["created_time"].toString()),
        dueDate: dueDate,
        description: 'First Order Invoice',
        number: appModel["id"].toString(),
        tableNumber: appModel["id"].toString(),
      ),
      items: List.generate(
        items.length,
        (index) => InvoiceItem(
          name: items[index]['name'],
          quantity: items[index]['quantity'],
          packaging: items[index]['packaging'],
          cost: items[index]['cost']
                  .toString()
                  .substring(0, items[index]['cost'].toString().length - 1) ,
        ),
      ),
      total: List.generate(
        1,
        (index) => InvoiceTotal(
          cost: toMoney(appModel["amount"]),
          totalCost: toMoney(
              appModel["amount"]),
        ),
      ),
      invoiceGraph: List.generate(
        appModel["expired_month"],
        (index) => InvoiceGraph(
          // date: DateTime.now().day >= 2
          //     ? DateTime(date.year, (date.month + index) + 1, 2)
          //     : DateTime(date.year, date.month + index, 2),
          date: DateTime(date.year, (date.month + index) + 1, 2),
          price: double.parse(appModel["payment_amount"].toString()),
          period: appModel["expired_month"],
          percent: 41,
          number: index + 1,
        ),
      ),
      invoiceGraphHeader: List.generate(
        1,
        (index) => InvoiceGraphHeader(
          // date: DateTime.now().day >= 2
          //     ? DateTime(date.year, (date.month + index) + 1, 2)
          //     : DateTime(date.year, date.month + index, 2),
          date: DateTime.parse(appModel["created_time"].toString()),
          price: double.parse(appModel["payment_amount"].toString()),
          period: appModel["expired_month"],
          percent: 41,
          number: index,
        ),
      ),
    );

    final pdfFile = await PdfInvoicePdfHelper.generate(invoice);

    // await PdfHelper.openFile(pdfFile);
    print("generated");
    String? mergedPdfPath = await PdfManipulator().mergePDFs(
      params: PDFMergerParams(pdfsPaths: [
        pdfFile.path,
        await getFilePath("screenshots.pdf"),
        await getFilePath("oferta.pdf")
      ]),
    );
    print(mergedPdfPath);

    await shareit(File(
        await renameFile(File(mergedPdfPath!), appModel["id"].toString())));
  }

  renameFile(File f, String id) async {
    print('Original path: ${f.path}');
    String dir = path.dirname(f.path);
    String newPath = path.join(dir, 'Grafik$id.pdf');
    print('NewPath: ${newPath}');
    f.renameSync(newPath);
    return newPath;
  }

  getFilePath(String assetPath) async {
    final loadFile =
        (await rootBundle.load('assets/docs/$assetPath')).buffer.asByteData();

    final bytes = await loadFile.buffer.asUint8List();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$assetPath');
    if (await file.exists()) {
      return file.path;
    }

    await file.writeAsBytes(bytes);

    return file.path;
  }

  shareit(File f) async {
    // ignore: deprecated_member_use
    Share.shareFiles(
      [f.path],
    );
    // final permissionStatus = await Permission.storage.status;
    // if (permissionStatus.isDenied) {
    //   // Here just ask for the permission for the first time
    //   await Permission.storage.request();

    //   // I noticed that sometimes popup won't show after user press deny
    //   // so I do the check once again but now go straight to appSettings
    //   if (permissionStatus.isDenied) {
    //     await openAppSettings();
    //   }
    // } else if (permissionStatus.isPermanentlyDenied) {
    //   // Here open app settings for user to manually enable permission in case
    //   // where permission was permanently denied
    //   await openAppSettings();
    // } else {
    //   // var response = await Dio()
    //   //     .get(filePath, options: Options(responseType: ResponseType.bytes));
    //   // final directory = await getApplicationDocumentsDirectory();
    //   // String savedPath = directory.path +
    //   //     "/premium-pay/" +
    //   //     DateTime.now().millisecondsSinceEpoch.toString() +
    //   //     ".pdf";
    //   // File file = await File(savedPath).create(recursive: true);
    //   // await file.writeAsBytes(response.data);
    //   Share.shareFiles(
    //     [f.path],
    //   );
    //   // Do stuff that require permission here
    // }
  }
}

String heshPhoneNumber(String? phone){
  if(phone ==null && phone ==""){
    return "";
  }else{
    String res =phone!.substring(0,4) +"("+ phone.substring(4,6) +") " +phone.substring(6,9)+"-XX-XX";
    return res;
  }
  
}

String heshPassport(String? passport){
  if(passport ==null && passport ==""){
    return "";
  }else{
    String res =passport!.substring(0,3) +"XXXX";
    return res;
  }
  
}

