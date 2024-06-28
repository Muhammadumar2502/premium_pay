import 'package:intl/intl.dart';
import 'package:pdf_merger/pdf_merger.dart';
import 'package:premium_pay_new/export_files.dart';
import 'package:path/path.dart' as path;
import '../../../../controllers/6_merchant_controller.dart';

// ignore: must_be_immutable
class GraphicView extends StatefulWidget {
  Map appModel;
  bool? isAvailable;
  int? total;
  GraphicView(
      {Key? key,
      required this.appModel,
      this.isAvailable = true,
      this.total = 0})
      : super(key: key);

  @override
  State<GraphicView> createState() => _GraphicViewState();
}

class _GraphicViewState extends State<GraphicView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController productController = TextEditingController();
  TextEditingController costController = TextEditingController();
  // List<String> types = [
  //   'Сумма покупки:',
  //   'Сумма с рассрочкой:',
  //   'Ежемесячный платеж:',
  // ];
  // List<String> customer_rejection = [
  //   'Слишком долго ждал',
  //   'Высокий процент',
  //   'Неподходящий срок'
  // ];
  // List<String> costs = [
  //   '3,000,000 сум',
  //   '7,000,000 сум',
  //   '583.333.00 сум',
  // ];
  TextEditingController fullPriceController = TextEditingController();
  // int radioListValue = 0;

  // List<String> rejections = [
  //   'Передумал',
  //   'Высокий процент',
  //   'Не доверяет сервису',
  // ];

  // int selectedIndex = 0;
  DateTime date = DateTime(2018, 1, 2);
  List items = [];

  @override
  void initState() {
    super.initState();
    MerchantController.post(context);
    DateTime finished_time = widget.appModel["created_time"] == null
        ? DateTime.now()
        : DateTime.parse(widget.appModel["created_time"]);
    // if (finished_time.day > 1) {
    //   date = DateTime(finished_time.year, finished_time.month + 1, 2);
    // } else {
    //   date = DateTime(finished_time.year, finished_time.month, 2);
    // }
    date = DateTime(finished_time.year, finished_time.month +1, 2);
    rowCount = int.parse(widget.appModel["expired_month"].toString());

    items = (widget.appModel["products"] as List)
        .map((value) => {
              'name': value["name"],
              'quantity': 1,
              'packaging': 'Bor',
              'cost': toMoney(double.tryParse(value["price"])),
            })
        .toList();
  }

  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  int rowCount = 0;
  Color tableColor = Color(0xffBE52F2);

  LoadingService loadingService = LoadingService();

  @override
  Widget build(BuildContext context) {
    //  var now = DateTime.now();
    // ignore: unused_local_variable
    // DateTime date = DateTime(now.year, now.month + 1, 2);
     print(widget.appModel);
    return AbsorbPointer(
        absorbing: !(widget.isAvailable ?? true),
        child: BlocBuilder<MerchantBloc, MerchantState>(
          builder: (context, state) {
            if (state is MerchantSuccessState) {
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
                      "График",
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
                    actions: [
                      GestureDetector(
                        onTap: () async {
                          await generatePdf(widget.appModel, state);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(6.w),
                          child: SvgPicture.asset(
                            'assets/icons/upload.svg',
                            width: 22.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      )
                    ],
                  ),
                  body: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Результаты расчета',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                         SizedBox(
                          height: 12.h,
                        ),
                    SizedBox(
                    height: 480.h,
                    width: 390.w,
                    child: TableView.builder(
                      columns: [
                        TableColumn(width: 33.w),
                        TableColumn(width: 92.w),
                        TableColumn(width: 113.w),
                        TableColumn(width: 113.w),
                      ],
                      rowCount: (widget.appModel["expired_month"] ?? 12)  +1,
                      rowHeight: 30.h,
                      rowBuilder: (context, row, contentBuilder) {
                        return InkWell(
                          onTap: () => print('Row $row clicked'),
                          child: contentBuilder(context, (context, column) {
                            if (row == 0) {
                              return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xffE9C5FB).withOpacity(0.3),
                                      border: Border.all(
                                        width: 1.w,
                                        color: Color(0xffD1CFD7),
                                      )),
                                  child: Text(
                                    [
                                      "№",
                                      "Дата",
                                      "Сумма (сум)",
                                      "Остаток (сум)"
                                    ][column],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff232326),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp,
                                    ),
                                  ));
                            } else if (column == 0) {
                              return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xffE9C5FB).withOpacity(0.3),
                                      border: Border.all(
                                        width: 1.w,
                                        color: Color(0xffD1CFD7),
                                      )),
                                  child: Text(
                                    '$row',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff232326),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ));
                            } else if (column == 1 || column == 4) {
                              DateTime dateTime =DateTime.parse( widget
                                                      .appModel["created_time"].toString());
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  width: 1.w,
                                  color: Color(0xffD1CFD7),
                                )),
                                child: Text(
                                  formatter.format(DateTime(
                                      dateTime.year, dateTime.month + row  , 2)),
                                  style: TextStyle(
                                    color: Color(0xff232326),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              );
                            }
                            else if(column ==2){
                                 return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                width: 1.w,
                                color: Color(0xffD1CFD7),
                              )),
                              child: Text(
                                 toMoney(((widget.appModel[
                                                          "payment_amount"] ??
                                                      0) /
                                                  widget
                                                      .appModel["expired_month"])
                                             ) ,
                                style: TextStyle(
                                  color: Color(0xff232326),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            );
                        
                            }
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                width: 1.w,
                                color: Color(0xffD1CFD7),
                              )),
                              child: Text(
                                 toMoney(((widget.appModel[
                                                          "payment_amount"] ??
                                                      0) /
                                                  widget
                                                      .appModel["expired_month"])
                                              *( widget
                                                      .appModel["expired_month"] - row)) +
                                          " сум",
                                style: TextStyle(
                                  color: Color(0xff232326),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                             
                        SizedBox(
                          height: 12.h,
                        ),
                        // SizedBox(
                        //   height: 600.h,
                        //   width: 350.w,
                        //   child: TableView.builder(
                        //     columns: [
                        //       TableColumn(width: 40.w),
                        //       TableColumn(width: 100.w),
                        //       TableColumn(width: 200.w),
                        //     ],
                        //     rowCount: rowCount + 1,
                        //     rowHeight: 40.h,
                        //     rowBuilder: (context, row, contentBuilder) {
                        //       return InkWell(
                        //         onTap: () => print('Row $row clicked'),
                        //         child: contentBuilder(context, (context, column) {
                        //           if (row == 0) {
                        //             return Container(
                        //                 alignment: Alignment.center,
                        //                 decoration: BoxDecoration(
                        //                     color: tableColor,
                        //                     border: Border.all(
                        //                       width: 1.w,
                        //                       color: Colors.white,
                        //                     )),
                        //                 child: Text(
                        //                   ["№", "Дата", "Сумма"][column],
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.bold),
                        //                 ));
                        //           } else if (column == 0) {
                        //             return Container(
                        //                 alignment: Alignment.center,
                        //                 decoration: BoxDecoration(
                        //                     color: tableColor,
                        //                     border: Border.all(
                        //                       width: 1.w,
                        //                       color: Colors.white,
                        //                     )),
                        //                 child: Text(
                        //                   '$row',
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.bold),
                        //                 ));
                        //           } else if (column == 1) {
                        //             return Container(
                        //               alignment: Alignment.center,
                        //               decoration: BoxDecoration(
                        //                   color: tableColor,
                        //                   border: Border.all(
                        //                     width: 1.w,
                        //                     color: Colors.white,
                        //                   )),
                        //               child: Text(
                        //                 formatter.format(DateTime(date.year,
                        //                     date.month + row - 1, date.day)),
                        //                 style: TextStyle(color: Colors.white),
                        //               ),
                        //             );
                        //           }
                        //           return Container(
                        //             alignment: Alignment.center,
                        //             decoration: BoxDecoration(
                        //                 color: tableColor,
                        //                 border: Border.all(
                        //                   width: 1.w,
                        //                   color: Colors.white,
                        //                 )),
                        //             child: Text(
                        //               toMoney(((widget.appModel[
                        //                                   "payment_amount"] ??
                        //                               0) /
                        //                           widget
                        //                               .appModel["expired_month"])
                        //                       .toInt()) +
                        //                   " сум",
                        //               style: TextStyle(color: Colors.white),
                        //             ),
                        //           );
                        //         }),
                        //       );
                        //     },
                        //   ),
                        // ),
                    
                        SizedBox(
                          height: 50.h,
                        ),
                        customButton(context, 'Назад на главный', () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteNames.applicationView, (route) => false);
                        }, Color(0xffBE52F2), buttonWidth: 325.w),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is MerchantWaitingState) {
              return SafeArea(
                child: Scaffold(
                  body: Center(
                      child: SizedBox(
                    width: 160.w,
                    height: 160.w,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: const Color(0xffBE52F2),
                        strokeWidth: 6.w,
                        strokeAlign: 2,
                        strokeCap: StrokeCap.round,
                        backgroundColor: const Color(0xffBE52F2).withOpacity(0.2),
                      ),
                    ),
                  )),
                ),
              );
            }
            return Container();
          },
        ));
  
   }

  Future<void> generatePdf(
    Map appModel,
    MerchantSuccessState state,
  ) async {
    // final date = DateTime.now();
    final dueDate = DateTime(
        date.year, date.month + (appModel["expired_month"] as int), date.day);
    
    print(DateTime.parse(widget.appModel["created_time"].toString()));
     print(dueDate);
    final invoice = Invoice(
      supplier: Supplier(
        name: state.data["name"],
        address: "Oqoltin MFY, Zarbdor ko'chasi, uy:8 xonadon:47",
        fromWhichStore: 'Artel',
      ),
      customer: Customer(
        name: "${appModel["fullname"]}".replaceAll("ʻ", "'").replaceAll("‘", "'"),
        address: appModel["address"]["home"].toString().replaceAll("ʻ", "'").replaceAll("‘", "'"),
        givenByWhom: appModel["passport_by"].toString(),
        passportSeria: appModel["passport"].toString().substring(0, 2),
        passportNumber: appModel["passport"].toString().substring(2),
        givenWhen: appModel["passport_date"].toString(),
        storeName: state.data["name"],
        phoneNumber:  appModel["phoneNumber"].toString(),
        phoneNumber2:  appModel["phoneNumber2"].toString(),
          shartnomaDate: DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse( appModel["created_time"].toString())),
      ),
      info: InvoiceInfo(
        date: DateTime.parse(widget.appModel["created_time"].toString()),
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
          cost: toMoney(
              (widget.appModel["amount"])),
          totalCost: toMoney(
              widget.appModel["payment_amount"]),
        ),
      ),
      invoiceGraph: List.generate(
        widget.appModel["expired_month"],
        (index) => InvoiceGraph(
          // date: DateTime.now().day >= 2
          //     ? DateTime(date.year, (date.month + index) + 1, 2)
          //     : DateTime(date.year, date.month + index, 2),
          date: date,
          price: double.parse(widget.appModel["payment_amount"].toString()),
          period: widget.appModel["expired_month"],
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
          date: DateTime.parse(widget.appModel["created_time"].toString()),
          price: double.parse(widget.appModel["payment_amount"].toString()),
          period: widget.appModel["expired_month"],
          percent: 41,
          number: index,
        ),
      ),
    );

    final pdfFile = await PdfInvoicePdfHelper.generate(invoice);
    // final pdfOferta = await PdfInvoicePdfHelper.generate(invoice);
     for (var i = 0; i < 20; i++) {
       print("${widget.appModel["fullname"]}".replaceAll("‘", "'"));
     }
   
     final invoiceOferta = Invoice(
                          customer: Customer(
                              name: "${widget.appModel["fullname"]}".replaceAll("ʻ", "'").replaceAll("‘", "'"),
                              address:
                                  (widget.appModel["address"]["home"] ?? "")
                                      .replaceAll("ʻ", "'").replaceAll("‘", "'"),
                              givenByWhom: widget.appModel["passport_by"]
                                  .toString()
                                  .toString()
                                  .replaceAll("ʻ", "'").replaceAll("‘", "'"),
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
                                    shartnomaDate: DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse( widget.appModel["created_time"].toString())),),
                                  
                        );
               final pdfOferta =  await PdfOfertaInvoicePdfHelper.generate(invoiceOferta,
                                fileName: 'Oferta' +
                                    DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString() +
                                    ".pdf",appModel: appModel,);

    print("generated");
    if (Platform.isAndroid) {
       String? mergedPdfPath = await PdfManipulator().mergePDFs(
        params: PDFMergerParams(pdfsPaths: [
          pdfFile.path,
          await getFilePath("screenshots.pdf"),
          pdfOferta.path
        ]),
      );
      print(mergedPdfPath);

      await shareit(File(
          await renameFile(File(mergedPdfPath!), appModel["id"].toString())));
    } else if(Platform.isIOS){
      var directory = await getApplicationSupportDirectory();
      String outputDirPath = directory.path +
          "/graph" +
          DateTime.now().millisecondsSinceEpoch.toString() +
          ".pdf";
          print(outputDirPath);

           final file = File(outputDirPath);

      // .create(recursive: true);
      if (!(await file.exists())) {
        await file.create(recursive: true);
      }

    try {
      print("outputDirPath >>"+ outputDirPath);
        MergeMultiplePDFResponse response = await PdfMerger.mergeMultiplePDF(
            paths: [
              pdfFile.path,
              await getFilePath("screenshots.pdf"),
              pdfOferta.path
            ],
            outputDirPath: outputDirPath);
        print(response.message);
        print(response.status);
        if (response.status == "success") {
          //response.response for output path  in String
          //response.message for success message  in String

          await shareit(File(await renameFile(
              File(outputDirPath), appModel["id"].toString())));
        }
    } catch (e) {
      print(e.toString());
    }
    }
   
  }

  renameFile(File f, String id) async {
    print('Original path: ${f.path}');
    String dir = path.dirname(f.path);
    int timeValue =DateTime.now().microsecondsSinceEpoch;
    String newPath = path.join(dir, 'Grafik$timeValue-$id.pdf');
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

  // _saveNetworkDoc() async {
  //   var response = await Dio()
  //       .get(filePath, options: Options(responseType: ResponseType.bytes));
  //   //  final directory = await getDownloadsDirectory();
  //   final directory = "/storage/emulated/0/Download/";
  //   String savedPath = directory +
  //       "/premium-pay/" +
  //       DateTime.now().millisecondsSinceEpoch.toString() +
  //       ".pdf";

  //   File file = await File(savedPath).create(recursive: true);
  //   await file.writeAsBytes(response.data);

  //   Flushbar(
  //     backgroundColor: Colors.green.shade700,
  //     dismissDirection: FlushbarDismissDirection.HORIZONTAL,
  //     flushbarPosition: FlushbarPosition.TOP,
  //     flushbarStyle: FlushbarStyle.GROUNDED,
  //     isDismissible: true,
  //     message: "Hujjat Saqlandi",
  //     messageColor: Colors.white,
  //     messageSize: 18.sp,
  //     icon: Icon(
  //       CupertinoIcons.check_mark,
  //       size: 28.0,
  //       color: Colors.white,
  //     ),
  //     duration: Duration(seconds: 3),
  //     leftBarIndicatorColor: Colors.green.shade700,
  //   ).show(context);

  //   // print(result);
  // }

  decorWidget(List data, int selectedIndex) {
    int selectedI = selectedIndex;
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
                    data.length,
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
                            data[index],
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
                              selectedI = value!;
                            });
                          },
                          groupValue: selectedI,
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
                    Navigator.of(context).pop(selectedI);
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
