import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:premium_pay_new/export_files.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ProductsView extends StatefulWidget {
  Map appModel;
  bool? isAvailable;
  ProductsView({Key? key, required this.appModel, this.isAvailable = true})
      : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController productController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<String> types = [
    'Итого продукт:',
    'Итого сумма:',
    'Сумма товара :',
  ];
  List<String> customer_rejection = [
    'Слишком долго ждал',
    'Высокий процент',
    'Неподходящий срок',
  ];
  // List<String> costs = [
  //   '3,000,000 сум',
  //   '7,000,000 сум',
  //   '583.333.00 сум',
  // ];
  TextEditingController fullPriceController = TextEditingController();

  List products = [
    // {"name": TextEditingController(), "price": TextEditingController()}
  ];
  int radioListValue = 0;
  @override
  void initState() {
    super.initState();
    PercentsController.get(context);
    products =
        widget.appModel["products"] == null || widget.appModel["products"] == []
            ? []
            : List.generate(
                widget.appModel["products"].length,
                (index) => {
                      "name": TextEditingController(
                          text: widget.appModel["products"][index]["name"]
                              .toString()),
                      "price": TextEditingController(
                          text: widget.appModel["products"][index]["price"]
                              .toString())
                    });
  }

  LoadingService loadingService = LoadingService();

  double getAvg() {
    return (double.tryParse(widget.appModel["limit_summa"].toString()) ?? 0) /
        12;
  }

  checkPeriod(int period, List months) {
    final monthsValue = [12, 9, 6, 3];
    int index = monthsValue.indexOf(period);
    print(index);
    // print(months);
    // print(period);
    // print(monthsValue.firstWhere((e)=>e==period));
    return getAvg() * period >= (totallPrice() ?? 0) * months[index];
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: (widget.appModel["step"] ?? 0) > 6,
      child: SafeArea(
        child: Scaffold(
          endDrawerEnableOpenDragGesture: false,
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
              "Покупка",
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
                  products.add({
                    "name": TextEditingController(),
                    "price": TextEditingController()
                  });
        
                  final data = await customBottomSheet(context,
                      StatefulBuilder(builder: (context, setsta) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(34.r),
                            topRight: Radius.circular(34.r),
                          )),
                      height: 420.h,
                      width: 1.sw,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 325.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Новый продукт",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Text(
                                    "Отмена",
                                    style: TextStyle(
                                      color: Color(0xffBE52F2),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            height: 89.h,
                            width: 325.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Название товара",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Container(
                                  width: 325.w,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 6.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(
                                      width: 1.w,
                                      color: Color(0xffE4E4E4),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: products.last["name"],
                                    onChanged: (value) => setsta(() {}),
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        height: 1),
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        color: const Color(0xffC0C0C0),
                                      ),
                                      hintText: "Название товара",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 15.h),
                                      isDense: true,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            height: 89.h,
                            width: 325.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Цена",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Container(
                                  width: 325.w,
                                  // height: 50.h,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 6.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(
                                      width: 1.w,
                                      color: Color(0xffE4E4E4),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: products.last["price"],
                                    inputFormatters: [
                                      ThousandsSeparatorInputFormatter()
                                    ],
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => setsta(() {}),
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        height: 1),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 15.h),
                                      isDense: true,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintStyle: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        color: const Color(0xffC0C0C0),
                                      ),
                                      hintText: "Цена",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 48.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (products.last["name"].text.isNotEmpty &&
                                      products.last["price"].text.isNotEmpty) {
                                    Navigator.pop(context, {
                                      "name": products.last["name"].text,
                                      "price": products.last["price"].text
                                          .toString()
                                          .replaceAll(" ", ""),
                                    });
                                  }
                                },
                                child: Container(
                                  width: 327.w,
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: products.last["name"].text
                                                  .isNotEmpty &&
                                              products
                                                  .last["price"].text.isNotEmpty
                                          ? const Color(0xffBE52F2)
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(8.r),
                                      boxShadow: products.last["name"].text
                                                  .isNotEmpty &&
                                              products
                                                  .last["price"].text.isNotEmpty
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
                                    "Добавить",
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
                    );
                  }));
                  if (data == null) {
                    products.removeLast();
                  } else {
                    products.last["name"].text = data["name"];
                    products.last["price"].text = data["price"];
                    setState(() {});
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: SvgPicture.asset(
                    'assets/icons/add-product.svg',
                    width: 24.w,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          body: BlocBuilder<GetPercentsBloc, GetPercentsState>(
              builder: (context, state) {
            if (state is GetPercentsWaitingState) {
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: const Color(0xffBE52F2),
                    strokeWidth: 6.w,
                    strokeAlign: 2,
                    strokeCap: StrokeCap.round,
                    backgroundColor: const Color(0xffBE52F2).withOpacity(0.2),
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  SizedBox(
                    width: 365.w,
                    child: Text(
                      "Загрузка информации...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ));
            } else if (state is GetPercentsSuccessState) {
              print(state.data);
              final data = (state.data as List);
              data.sort((a, b) => ((int.tryParse(a["month"].toString()) ?? 0) <
                      (int.tryParse(b["month"].toString()) ?? 0))
                  ? 1
                  : -1);
              print(">> " + data.toString());
              final monthData = data
                  .map((e) =>
                      (((double.tryParse(e["percent"].toString()) ?? 0) + 100) /
                          100))
                  .toList();
              print(monthData);
              print(((totallPrice() ?? 0) * monthData.first >
                      ((widget.appModel["limit_summa"] ?? 1))
                  ? 1
                  : (((totallPrice() ?? 0) *
                      monthData.first /
                      (widget.appModel["limit_summa"] ?? 1)))));
              return Container(
                width: 1.sw,
                height: 1.sh,
                color: widget.appModel["step"] > 6
                    ? Color.fromARGB(255, 246, 195, 191).withOpacity(0.3)
                    : null,
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    // left: 16.w,
                    // right: 16.w,
                    // top: 12.h,
                    bottom: 32.h,
                  ),
                  children: [
                    products.isEmpty
                        ? Container(
                            height: 540.h,
                            child: Column(
                              children: [
                                SizedBox(height: 50.h),
                                Image.asset(
                                  "assets/images/products.png",
                                  width: 271.w,
                                  height: 279.h,
                                  fit: BoxFit.fitHeight,
                                ),
                                SizedBox(height: 48.h),
                                SizedBox(height: 20.h),
                                SizedBox(
                                  width: 325.w,
                                  child: Text(
                                    "Ваш лимит :",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0XFF242424),
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 325.w,
                                  child: Text(
                                    "${toMoney(widget.appModel["limit_summa"])} сум",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0XFF00C48C),
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                // Text(
                                //   "Успешный!",
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //     color: Color(0XFF242424),
                                //     fontSize: 28.sp,
                                //     fontWeight: FontWeight.w300,
                                //   ),
                                // ),
                                SizedBox(height: 12.h),
                                Text(
                                  "Добавьте ваши любимые продукты",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0XFF242424),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 320.h,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                        products.length,
                                        (index) => Slidable(
                                          key: ValueKey(index),
                                          endActionPane: ActionPane(
                                            motion: ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed:
                                                    (BuildContext? ctx) async {
                                                  final data =
                                                      await customBottomSheet(
                                                          context,
                                                          StatefulBuilder(
                                                              builder: (context,
                                                                  setsta) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    34.r),
                                                            topRight:
                                                                Radius.circular(
                                                                    34.r),
                                                          )),
                                                      height: 420.h,
                                                      width: 1.sw,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                            height: 16.h,
                                                          ),
                                                          SizedBox(
                                                            width: 325.w,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Изменить продукт",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child: Text(
                                                                    "Отмена",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xffBE52F2),
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 16.h,
                                                          ),
                                                          Container(
                                                            height: 89.h,
                                                            width: 325.w,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Название товара",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 325.w,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              6.w),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.r),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width:
                                                                          1.w,
                                                                      color: Color(
                                                                          0xffE4E4E4),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        products[index]
                                                                            [
                                                                            "name"],
                                                                    onChanged:
                                                                        (value) =>
                                                                            setsta(() {}),
                                                                    style: TextStyle(
                                                                        fontSize: 15
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        height:
                                                                            1),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                        color: const Color(
                                                                            0xffC0C0C0),
                                                                      ),
                                                                      hintText:
                                                                          "Название товара",
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          horizontal: 10
                                                                              .w,
                                                                          vertical:
                                                                              15.h),
                                                                      isDense:
                                                                          true,
                                                                      border: const OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide.none),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 16.h,
                                                          ),
                                                          Container(
                                                            height: 89.h,
                                                            width: 325.w,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Цена",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 325.w,
                                                                  // height: 50.h,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              6.w),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.r),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width:
                                                                          1.w,
                                                                      color: Color(
                                                                          0xffE4E4E4),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        products[index]
                                                                            [
                                                                            "price"],
                                                                    inputFormatters: [
                                                                      ThousandsSeparatorInputFormatter()
                                                                    ],
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    onChanged:
                                                                        (value) =>
                                                                            setsta(() {}),
                                                                    style: TextStyle(
                                                                        fontSize: 15
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        height:
                                                                            1),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          horizontal: 10
                                                                              .w,
                                                                          vertical:
                                                                              15.h),
                                                                      isDense:
                                                                          true,
                                                                      border: const OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide.none),
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                        color: const Color(
                                                                            0xffC0C0C0),
                                                                      ),
                                                                      hintText:
                                                                          "Цена",
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 48.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  if (products[index]
                                                                              [
                                                                              "name"]
                                                                          .text
                                                                          .isNotEmpty &&
                                                                      products[index]
                                                                              [
                                                                              "price"]
                                                                          .text
                                                                          .isNotEmpty) {
                                                                    Navigator.pop(
                                                                        context,
                                                                        {
                                                                          "name":
                                                                              products[index]["name"].text,
                                                                          "price": products[index]["price"]
                                                                              .text
                                                                              .toString()
                                                                              .replaceAll(" ", ""),
                                                                        });
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 327.w,
                                                                  height: 50.h,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: products[index]["name"].text.isNotEmpty && products[index]["price"].text.isNotEmpty ? const Color(0xffBE52F2) : Colors.grey.shade400,
                                                                      borderRadius: BorderRadius.circular(8.r),
                                                                      boxShadow: products[index]["name"].text.isNotEmpty && products[index]["price"].text.isNotEmpty
                                                                          ? [
                                                                              BoxShadow(
                                                                                color: const Color(0xff323247).withOpacity(0.3),
                                                                                offset: Offset(0, 4.h),
                                                                                blurRadius: 4.r,
                                                                                // blurStyle: BlurStyle.outer
                                                                              ),
                                                                            ]
                                                                          : null),
                                                                  child: Text(
                                                                    "Изменить",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }));
                                                  if (data != null) {
                                                    products[index]["name"]
                                                        .text = data["name"];
                                                    products[index]["price"]
                                                        .text = data["price"];
                                                    setState(() {});
                                                  }
                                                },
                                                backgroundColor: Color.fromARGB(
                                                    255, 237, 189, 100),
                                                foregroundColor: Colors.white,
                                                icon: Icons.edit,
                                                spacing: 1,
                                                label: 'Изменить',
                                              ),
                                              SlidableAction(
                                                // An action can be bigger than the others.
                                                // flex: 2,
                                                spacing: 1,
                                                onPressed: (BuildContext? ctx) {
                                                  products.removeAt(index);
                                                  setState(() {});
                                                },
                                                backgroundColor:
                                                    Color(0xFFFF647C),
                                                foregroundColor: Colors.white,
                                                icon: Icons.delete,
                                                label: 'Удалить',
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                            height: 54.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        products[index]["name"]
                                                            .text,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0XFF242424),
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        toMoney(double.tryParse(products[
                                                                            index]
                                                                        [
                                                                        "price"]
                                                                    .text
                                                                    .toString()
                                                                    .replaceAll(
                                                                        ",",
                                                                        ".")) ??
                                                                0) +
                                                            " сум",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0XFF242424),
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1.h,
                                                  color: Color(0XFF151522)
                                                      .withOpacity(0.1),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: products.length > 0 ? 1 : 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  // margin: EdgeInsets.symmetric(
                                  //     vertical: 4.h, horizontal: 25.w),
                                  // decoration: BoxDecoration(
                                  //   color: Colors.white,
                                  //   borderRadius: BorderRadius.circular(6.r),
                                  //   border: Border.all(
                                  //     width: 1.sp,
                                  //     color: const Color(0xffE8E8E8),
                                  //   ),
                                  // ),
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 16.w, vertical: 8.h),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Container(
                                          width: 325.w,
                                          // height: 200.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 16.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 50.w,
                                                    height: 50.w,
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      (totallPrice() ?? 0) >=
                                                                  500000 &&
                                                              checkFuncOne(
                                                                  monthData)
                                                          ? Icons.check_rounded
                                                          : Icons.close_rounded,
                                                      color: Colors.white,
                                                      size: 38.r,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          (totallPrice() ??
                                                                          0) >=
                                                                      500000 &&
                                                                  checkFuncOne(
                                                                      monthData)
                                                              ? AppConstant
                                                                  .primaryColor
                                                              : Color(
                                                                  0xffFF647C),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  SizedBox(
                                                    width: 154.w,
                                                    child: Text(
                                                      (totallPrice() ?? 0) <
                                                              500000
                                                          ? "Минимальная сумма 500 000,00  сум"
                                                          : "Ежемесячного дохода ${checkFuncOne(monthData) ? "" : "не"}достаточно",
                                                      // textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0XFF242424),
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Container(
                                                // color: Colors.green,
                                                width: 325.w,
                                                padding: EdgeInsets.all(5.h),
        
                                                height: 38.h,
                                                child: Container(
                                                  width: 325.w - 10.h,
                                                  child: Stack(
                                                    fit: StackFit.loose,
                                                    children: [
                                                      Positioned(
                                                        top: 9.h,
                                                        left: 0,
                                                        right: 0,
                                                        bottom: 9.h,
                                                        child: Container(
                                                          width: 325.w - 10.h,
                                                          height: 10.h,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            width: ((totallPrice() ??
                                                                                0) *
                                                                            monthData
                                                                                .first >
                                                                        ((widget.appModel["limit_summa"] ??
                                                                            1))
                                                                    ? 1
                                                                    : (((totallPrice() ??
                                                                            0) *
                                                                        monthData
                                                                            .first /
                                                                        (widget.appModel["limit_summa"] ??
                                                                            1)))) *
                                                                (325.w - 48.h),
                                                            height: 10.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppConstant
                                                                  .primaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.h),
                                                            ),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey.shade300,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.h),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        // top:-9.h ,
                                                        bottom: 0,
                                                        top: 0,
        
                                                        left: ((totallPrice() ??
                                                                            0) *
                                                                        monthData
                                                                            .first >
                                                                    ((widget.appModel[
                                                                            "limit_summa"] ??
                                                                        1))
                                                                ? 1
                                                                : (((totallPrice() ??
                                                                        0) *
                                                                    monthData
                                                                        .first /
                                                                    (widget.appModel[
                                                                            "limit_summa"] ??
                                                                        1)))) *
                                                            (325.w - 76.h),
        
                                                        child: Container(
                                                          width: 28.h,
                                                          height: 28.h,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            width: 22.h,
                                                            height: 22.h,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Icon(
                                                              (totallPrice() ??
                                                                              0) >=
                                                                          500000 &&
                                                                      checkFuncOne(
                                                                          monthData)
                                                                  ? Icons
                                                                      .check_rounded
                                                                  : Icons
                                                                      .close_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 17.r,
                                                            ),
                                                            decoration: BoxDecoration(
                                                                color: (totallPrice() ??
                                                                                0) >=
                                                                            500000 &&
                                                                        checkFuncOne(
                                                                            monthData)
                                                                    ? Color(
                                                                        0xff00C48C)
                                                                    : Color(
                                                                        0xffFF647C),
                                                                shape: BoxShape
                                                                    .circle),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        blurRadius:
                                                                            5.r,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300)
                                                                  ],
                                                                  shape: BoxShape
                                                                      .circle),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    child: Text(
                                                      toMoney(totallPrice()) +
                                                          " сум",
                                                      // textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0XFF242424),
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      toMoney(widget.appModel[
                                                                  "limit_summa"] /
                                                              monthData.first) +
                                                          " сум",
        
                                                      // textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0XFF242424),
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(0xff323247)
                                                        .withOpacity(0.3),
                                                    blurRadius: 16.r,
                                                    offset: Offset(
                                                      0,
                                                      16.h,
                                                    ))
                                              ]),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ...List.generate(
                                              4,
                                              (index) => Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 18.w),
                                                width: 45.h,
                                                height: 45.h,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  ["3", "6", "9", "12"][index],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 22.sp),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: checkPeriod(
                                                            int.parse([
                                                              "3",
                                                              "6",
                                                              "9",
                                                              "12"
                                                            ][index]),
                                                            monthData)
                                                        ? Color(0xffb00C48C)
                                                        : Color(0xffFF647C),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9.r),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color(
                                                                  0xff323247)
                                                              .withOpacity(0.3),
                                                          blurRadius: 5.r,
                                                          offset: Offset(
                                                            0,
                                                            5.h,
                                                          ))
                                                    ]),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.w),
                                    child: customButton(
                                      context,
                                      "Перейти в oформеления",
                                      () async {
                                        if (products.length > 0) {
                                          Map? location;
                                          Map? device =
                                              await DeviceService.getinfo();
                                          Position? position =
                                              await LocationService
                                                  .getCurrentPoint();
                                          if (position != null) {
                                            location = {
                                              "lat": position.latitude,
                                              "long": position.longitude
                                            };
                                          }
                                          // print(widget.appModel["limit_summa"]);
                                          if (totallPrice() != 0 &&
                                              totallPrice() != null &&
                                              checkProduct() &&
                                              checkFuncOne(monthData) &&
                                              (totallPrice() ?? 0) >= 500000 &&
                                              (totallPrice() ?? 0) <=
                                                  (widget.appModel[
                                                          "limit_summa"] ??
                                                      0)) {
                                            await ZayavkaController.update5(
                                              context,
                                              id: "${widget.appModel["id"]}",
                                              products: productToJson(),
                                              device: device,
                                              location: location,
                                              amount: totallPrice() ?? 0,
                                            );
                                          } else if ((totallPrice() ?? 0) >
                                              widget.appModel["limit_summa"]) {
                                            Flushbar(
                                              backgroundColor:
                                                  Colors.red.shade700,
                                              dismissDirection:
                                                  FlushbarDismissDirection
                                                      .HORIZONTAL,
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              flushbarStyle:
                                                  FlushbarStyle.GROUNDED,
                                              isDismissible: true,
                                              message: "максимальная сумма " +
                                                  toMoney(widget.appModel[
                                                          "limit_summa"] /
                                                      monthData.first) +
                                                  " сум",
                                              messageColor: Colors.white,
                                              messageSize: 18.sp,
                                              icon: Icon(
                                                Icons.error,
                                                size: 28.0,
                                                color: Colors.white,
                                              ),
                                              duration: Duration(minutes: 1),
                                              leftBarIndicatorColor:
                                                  Colors.red.shade700,
                                            ).show(context);
                                          } else if ((totallPrice() ?? 0) <
                                              500000) {
                                            Flushbar(
                                              backgroundColor:
                                                  Colors.red.shade700,
                                              dismissDirection:
                                                  FlushbarDismissDirection
                                                      .HORIZONTAL,
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              flushbarStyle:
                                                  FlushbarStyle.GROUNDED,
                                              isDismissible: true,
                                              message:
                                                  "минимальная сумма 500 000,00  сум",
                                              messageColor: Colors.white,
                                              messageSize: 18.sp,
                                              icon: Icon(
                                                Icons.error,
                                                size: 28.0,
                                                color: Colors.white,
                                              ),
                                              duration: Duration(minutes: 1),
                                              leftBarIndicatorColor:
                                                  Colors.red.shade700,
                                            ).show(context);
                                          } else {}
                                        }
                                      },
                                      (totallPrice() != 0 &&
                                                  totallPrice() != null &&
                                                  checkProduct() &&
                                                  checkFuncOne(monthData) &&
                                                  (totallPrice() ?? 0) >=
                                                      500000) &&
                                              (totallPrice() ?? 0) <=
                                                  (widget.appModel[
                                                          "limit_summa"] ??
                                                      0)
                                          ? Color(0xffBE52F2)
                                          : Colors.grey.shade300,
                                      buttonWidth: 325.w,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    BlocListener<UpdateApp5Bloc, UpdateApp5State>(
                        child: SizedBox(),
                        listener: (context, state) async {
                          if (state is UpdateApp5WaitingState) {
                            loadingService.showLoading(context);
                          } else if (state is UpdateApp5ErrorState) {
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
                                duration: Duration(minutes: 1),
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
                                duration: Duration(minutes: 1),
                                leftBarIndicatorColor: Colors.red.shade700,
                              ).show(context);
                            }
                          } else if (state is UpdateApp5SuccessState) {
                            loadingService.closeLoading(context);
                            widget.appModel = state.data;
        
                            AppController.update5(context,
                                id: widget.appModel["id"].toString(),
                                total: totallPrice(),
                                app: widget.appModel);
        
                            Navigator.pushReplacementNamed(
                              context,
                              RouteNames.DecorView,
                              arguments: {
                                "appModel": widget.appModel,
                                "total": totallPrice()
                              },
                            );
                          }
                        }),
                  ],
                ),
              );
        
              // return SingleChildScrollView(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           elevation: 5,
              //           backgroundColor: Color(0xFFBE52F2),
              //           shadowColor: const Color(0xff323247).withOpacity(0.3),
              //           fixedSize: Size(327.w, 50.h),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8.r),
              //           ),
              //         ),
              //         onPressed: () {
              //           Navigator.popAndPushNamed(
              //               context, RouteNames.productsView,
              //               arguments: {
              //                 "appModel": widget.appModel,
              //               });
              //         },
              //         child: Text(
              //           "Изменить товары   -->",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16.sp,
              //             fontWeight: FontWeight.w300,
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       Container(
              //         margin:
              //             EdgeInsets.symmetric(vertical: 4.h, horizontal: 24.w),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(8.r),
              //           boxShadow: [
              //             BoxShadow(
              //               color: const Color(0xff323247).withOpacity(0.2),
              //               offset: Offset(0, 4.h),
              //               blurRadius: 8.r,
              //             )
              //           ],
              //         ),
              //         child: ExpansionTile(
              //           controller: controller,
              //           tilePadding: EdgeInsets.symmetric(horizontal: 24.w),
              //           // collapsedBackgroundColor:Color(0xffBE52F2) ,
              //           // collapsedTextColor: ,
              //           // backgroundColor: Color(0xffBE52F2) ,
              //           // collapsedIconColor: Color(0xffBE52F2),
              //           // title: Text(items[index]["checked"] ?  (items[index]["children"] as List).map((e) => e["controller"].text.toString()).toList().join(" "): items[index]["title"]),
              //           onExpansionChanged: (value) {
              //             setState(() {
              //               // items[index]["textColor"] =
              //               //     !value ? Color(0xff242424) : Colors.white;
              //             });
              //           },
        
              //           title: Text(
              //             selectedPeriod == -1
              //                 ? "Выберите период"
              //                 : "${[12, 9, 6, 3][selectedPeriod]} месяцев",
              //             style: TextStyle(
              //                 color: Color(0xff242424),
              //                 fontSize: 14.sp,
              //                 fontWeight: FontWeight.w300),
              //           ),
        
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(8.r)),
              //           children: List.generate(
              //             4,
              //             (i) => Column(
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 Divider(
              //                   thickness: 0.5.h,
              //                   height: 0.5.h,
              //                   color: Color(0XFF151522).withOpacity(0.1),
              //                 ),
              //                 InkWell(
              //                   onTap: () {
              //                     if (checkPeriod([12, 9, 6, 3][i])) {
              //                       selectedPeriod = i;
              //                       setState(() {});
              //                       controller?.collapse();
              //                     }
              //                   },
              //                   child: Padding(
              //                     padding: EdgeInsets.symmetric(
              //                         horizontal: 24.w, vertical: 10.h),
              //                     child: Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Text(
              //                           [
              //                             "12 месяцев",
              //                             "9 месяцев",
              //                             "6 месяцев",
              //                             "3 месяцев",
              //                           ][i],
              //                           style: TextStyle(
              //                               color: Color(0xff242424),
              //                               fontSize: 14.sp,
              //                               fontWeight: FontWeight.w300),
              //                         ),
              //                         checkPeriod([12, 9, 6, 3][i])
              //                             ? Transform.scale(
              //                                 scale: 1.4,
              //                                 child: SvgPicture.asset(
              //                                   "assets/icons/check.svg",
              //                                   fit: BoxFit.cover,
              //                                 ),
              //                               )
              //                             : Transform.scale(
              //                                 scale: 1.4,
              //                                 child: SvgPicture.asset(
              //                                   "assets/icons/cancel.svg",
              //                                   fit: BoxFit.cover,
              //                                 ),
              //                               )
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       Divider(
              //         color: Color(0xFFE4E4E4).withOpacity(0.6),
              //         thickness: 1,
              //       ),
              //       Container(
              //         width: 325.w,
              //         height: 40.h,
              //         alignment: Alignment.center,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Сумма покупки",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 13.sp,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //             Text(
              //               "${toMoney(totalPrice())}сум",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 13.sp,
              //                 fontWeight: FontWeight.w300,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Divider(
              //         color: Color(0xFFE4E4E4).withOpacity(0.6),
              //         thickness: 1,
              //       ),
              //       Container(
              //         width: 325.w,
              //         height: 40.h,
              //         alignment: Alignment.center,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Сумма с рассрочкой",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 13.sp,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //             Text(
              //               selectedPeriod == -1
              //                   ? "- - -"
              //                   : "${toMoney((monthData[selectedPeriod] * totalPrice()))} сум",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 13.sp,
              //                 fontWeight: FontWeight.w300,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Divider(
              //         color: Color(0xFFE4E4E4).withOpacity(0.6),
              //         thickness: 1,
              //       ),
              //       Container(
              //         width: 325.w,
              //         height: 40.h,
              //         alignment: Alignment.center,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Ежемесячный платеж",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 13.sp,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //             Text(
              //               selectedPeriod == -1
              //                   ? "- - -"
              //                   : "${toMoney(monthData[selectedPeriod] * totalPrice() / [
              //                         12,
              //                         9,
              //                         6,
              //                         3
              //                       ][selectedPeriod])} сум",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 13.sp,
              //                 fontWeight: FontWeight.w300,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Divider(
              //         color: Color(0xFFE4E4E4).withOpacity(0.6),
              //         thickness: 1,
              //       ),
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       SizedBox(
              //         width: 325.w,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             SizedBox(
              //               width: 325.w,
              //               child: Text(
              //                 "Расчёты произведены на основе данных представленных клиентом и могут отличаться от произведённых в банке ",
              //                 style: TextStyle(
              //                   color: Colors.grey.shade600,
              //                   fontSize: 15.sp,
              //                   fontWeight: FontWeight.w200,
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           elevation: 5,
              //           backgroundColor: const Color(0xffBE52F2),
              //           shadowColor: const Color(0xff323247).withOpacity(0.3),
              //           fixedSize: Size(327.w, 50.h),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8.r),
              //           ),
              //         ),
              //         onPressed: () {
              //           // print(selectedIndex);
              //           print(selectedPeriod);
              //           if (selectedPeriod > -1) {
              //             ZayavkaController.update6(context,
              //                 id: "${widget.appModel["id"]}",
              //                 expired_month:
              //                     state.data[selectedPeriod]["month"].toString(),
              //                 payment_amount: ((((widget.appModel["amount"] ??
              //                             widget.total) ??
              //                         0) *
              //                     monthData[selectedPeriod])));
              //           }
              //         },
              //         child: Text(
              //           "Оформить",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16.sp,
              //             fontWeight: FontWeight.w300,
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 16.h,
              //       ),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           elevation: 5,
              //           backgroundColor: const Color(0xffE9C5FB),
              //           shadowColor: const Color(0xff323247).withOpacity(0.3),
              //           fixedSize: Size(327.w, 50.h),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8.r),
              //           ),
              //         ),
              //         onPressed: () async {
              //           final data = await customBottomSheet(
              //               context, decorWidget(customer_rejection, -1));
              //           print(data);
              //           if (data != null) {
              //             String canceled_reason = customer_rejection[data];
              //             ZayavkaController.cancelByClient(context,
              //                 id: "${widget.appModel["id"]}",
              //                 canceled_reason: canceled_reason);
              //           }
              //         },
              //         child: Text(
              //           "Отказ клиента",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16.sp,
              //             fontWeight: FontWeight.w300,
              //           ),
              //         ),
              //       ),
              //       BlocListener<UpdateApp6Bloc, UpdateApp6State>(
              //           child: SizedBox(),
              //           listener: (context, state) async {
              //             if (state is UpdateApp6WaitingState) {
              //               loadingService.showLoading(context);
              //             } else if (state is UpdateApp6ErrorState) {
              //               loadingService.closeLoading(context);
              //               if (state.statusCode == 401) {
              //                 Future.wait([
              //                   CacheService.remove(
              //                     CacheService.token,
              //                   ),
              //                   CacheService.remove(
              //                     CacheService.user,
              //                   )
              //                 ]);
              //                 Flushbar(
              //                   backgroundColor: Colors.red.shade700,
              //                   dismissDirection:
              //                       FlushbarDismissDirection.HORIZONTAL,
              //                   flushbarPosition: FlushbarPosition.TOP,
              //                   flushbarStyle: FlushbarStyle.GROUNDED,
              //                   isDismissible: true,
              //                   message: "Пожалуйста, войдите снова",
              //                   messageColor: Colors.white,
              //                   messageSize: 18.sp,
              //                   icon: Icon(
              //                     Icons.error,
              //                     size: 28.0,
              //                     color: Colors.white,
              //                   ),
              //                   duration: Duration(minutes:1),
              //                   leftBarIndicatorColor: Colors.red.shade700,
              //                 ).show(context);
        
              //                 Navigator.pushNamedAndRemoveUntil(
              //                   context,
              //                   RouteNames.login,
              //                   (route) => false,
              //                 );
              //               } else {
              //                 Flushbar(
              //                   backgroundColor: Colors.red.shade700,
              //                   dismissDirection:
              //                       FlushbarDismissDirection.HORIZONTAL,
              //                   flushbarPosition: FlushbarPosition.TOP,
              //                   flushbarStyle: FlushbarStyle.GROUNDED,
              //                   isDismissible: true,
              //                   message: state.message,
              //                   messageColor: Colors.white,
              //                   messageSize: 18.sp,
              //                   icon: Icon(
              //                     Icons.error,
              //                     size: 28.0,
              //                     color: Colors.white,
              //                   ),
              //                   duration: Duration(minutes:1),
              //                   leftBarIndicatorColor: Colors.red.shade700,
              //                 ).show(context);
              //               }
              //             } else if (state is UpdateApp6SuccessState) {
              //               loadingService.closeLoading(context);
              //               widget.appModel = state.data;
              //               AppController.update6(
              //                 context,
              //                 id: widget.appModel["id"].toString(),
              //                 app: widget.appModel,
              //               );
              //               Navigator.pushReplacementNamed(
              //                 context,
              //                 RouteNames.SelfieWithCheckView,
              //                 arguments: {
              //                   "appModel": widget.appModel,
              //                 },
              //               );
              //             }
              //           }),
              //       BlocListener<CancelByClientBloc, CancelByClientState>(
              //           child: SizedBox(),
              //           listener: (context, state) async {
              //             if (state is CancelByClientWaitingState) {
              //               loadingService.showLoading(context);
              //             } else if (state is CancelByClientErrorState) {
              //               loadingService.closeLoading(context);
              //               if (state.statusCode == 401) {
              //                 Future.wait([
              //                   CacheService.remove(
              //                     CacheService.token,
              //                   ),
              //                   CacheService.remove(
              //                     CacheService.user,
              //                   )
              //                 ]);
              //                 Flushbar(
              //                   backgroundColor: Colors.red.shade700,
              //                   dismissDirection:
              //                       FlushbarDismissDirection.HORIZONTAL,
              //                   flushbarPosition: FlushbarPosition.TOP,
              //                   flushbarStyle: FlushbarStyle.GROUNDED,
              //                   isDismissible: true,
              //                   message: "Пожалуйста, войдите снова",
              //                   messageColor: Colors.white,
              //                   messageSize: 18.sp,
              //                   icon: Icon(
              //                     Icons.error,
              //                     size: 28.0,
              //                     color: Colors.white,
              //                   ),
              //                   duration: Duration(minutes:1),
              //                   leftBarIndicatorColor: Colors.red.shade700,
              //                 ).show(context);
        
              //                 Navigator.pushNamedAndRemoveUntil(
              //                   context,
              //                   RouteNames.login,
              //                   (route) => false,
              //                 );
              //               } else {
              //                 Flushbar(
              //                   backgroundColor: Colors.red.shade700,
              //                   dismissDirection:
              //                       FlushbarDismissDirection.HORIZONTAL,
              //                   flushbarPosition: FlushbarPosition.TOP,
              //                   flushbarStyle: FlushbarStyle.GROUNDED,
              //                   isDismissible: true,
              //                   message: state.message,
              //                   messageColor: Colors.white,
              //                   messageSize: 18.sp,
              //                   icon: Icon(
              //                     Icons.error,
              //                     size: 28.0,
              //                     color: Colors.white,
              //                   ),
              //                   duration: Duration(minutes:1),
              //                   leftBarIndicatorColor: Colors.red.shade700,
              //                 ).show(context);
              //               }
              //             } else if (state is CancelByClientSuccessState) {
              //               loadingService.closeLoading(context);
              //               Navigator.pushNamedAndRemoveUntil(
              //                   context, RouteNames.applicationView, (r) => true);
              //               Flushbar(
              //                 backgroundColor: Colors.green.shade500,
              //                 dismissDirection:
              //                     FlushbarDismissDirection.HORIZONTAL,
              //                 flushbarPosition: FlushbarPosition.TOP,
              //                 flushbarStyle: FlushbarStyle.GROUNDED,
              //                 isDismissible: true,
              //                 message: "Заявка успешно удалено",
              //                 messageColor: Colors.white,
              //                 messageSize: 18.sp,
              //                 icon: Icon(
              //                   Icons.check,
              //                   size: 28.0,
              //                   color: Colors.white,
              //                 ),
              //                 duration: Duration(minutes:1),
              //                 leftBarIndicatorColor: Colors.white,
              //               ).show(context);
              //             }
              //           }),
              //     ],
              //   ),
              // );
        
              // return SingleChildScrollView(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Container(
              //             height: 89.h,
              //             width: 325.w,
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   "Общая сумма товара",
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 15.sp,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //                 Container(
              //                   width: 325.w,
              //                   alignment: Alignment.centerLeft,
              //                   padding: EdgeInsets.symmetric(horizontal: 15.w),
              //                   decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     borderRadius: BorderRadius.circular(5.r),
              //                     border: Border.all(
              //                       width: 1.w,
              //                       color: Color(0xffE4E4E4),
              //                     ),
              //                   ),
              //                   child: TextField(
              //                     readOnly: true,
              //                     style: TextStyle(
              //                         fontSize: 15.sp,
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.w500,
              //                         height: 1),
              //                     decoration: InputDecoration(
              //                       contentPadding: EdgeInsets.symmetric(
              //                           horizontal: 10.w, vertical: 15.h),
              //                       // isDense: true,
              //                       border: const OutlineInputBorder(
              //                           borderSide: BorderSide.none),
              //                       hintStyle: TextStyle(
              //                         fontSize: 15.sp,
              //                         fontWeight: FontWeight.w500,
              //                         color: widget.appModel["amount"] == null
              //                             ? Color(0xffC0C0C0)
              //                             : Colors.black,
              //                       ),
              //                       hintText: widget.appModel["amount"] == null
              //                           ? null
              //                           : toMoney(widget.appModel["amount"]) +
              //                               " сум",
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       SizedBox(
              //         width: 325.w,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Text(
              //               "Выберите один из периодов рассрочки",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 15.sp,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         height: 16.h,
              //       ),
              //       Container(
              //         margin:
              //             EdgeInsets.symmetric(vertical: 4.h, horizontal: 24.w),
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(8.r),
              //             boxShadow: [
              //               BoxShadow(
              //                   color: const Color(0xff323247).withOpacity(0.14),
              //                   offset: Offset(0, 4.h),
              //                   blurRadius: 8.r)
              //             ]),
              //         child: ExpansionTile(
              //           controller: controller,
              //           tilePadding: EdgeInsets.symmetric(horizontal: 24.w),
              //           // collapsedBackgroundColor:Color(0xffBE52F2) ,
              //           // collapsedTextColor: ,
              //           // backgroundColor: Color(0xffBE52F2) ,
              //           // collapsedIconColor: Color(0xffBE52F2),
              //           // title: Text(items[index]["checked"] ?  (items[index]["children"] as List).map((e) => e["controller"].text.toString()).toList().join(" "): items[index]["title"]),
              //           onExpansionChanged: (value) {
              //             // setState(() {
              //             // items[index]["textColor"] =
              //             //     !value ? Color(0xff242424) : Colors.white;
              //             // });
              //           },
        
              //           title: Text(
              //             (state.data as List)
              //                     .map((e) => e["month"])
              //                     .toList()[selectedIndex]
              //                     .toString() +
              //                 " месяцев",
              //             style: TextStyle(
              //               color: Color(0xff242424),
              //               fontSize: 14.sp,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
        
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8.r),
              //           ),
              //           children: List.generate(
              //             1,
              //             // (state.data as List)
              //             //     .map((e) => e["month"])
              //             //     .toList()
              //             //     .length,
              //             (i) => Column(
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 Divider(
              //                   thickness: 0.5.h,
              //                   height: 0.5.h,
              //                   color: Color(0XFF151522).withOpacity(0.1),
              //                 ),
              //                 GestureDetector(
              //                   onTap: () {
              //                     if (isAvailableMonth(
              //                         widget.appModel,
              //                         (state.data as List)
              //                             .map((e) => e["month"].toString())
              //                             .toList()[i])) {
              //                       selectedIndex = i;
              //                       controller?.collapse();
              //                       setState(() {});
              //                     }
              //                   },
              //                   child: Padding(
              //                       padding: EdgeInsets.symmetric(
              //                           horizontal: 24.w, vertical: 10.h),
              //                       child: Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.spaceBetween,
              //                         children: [
              //                           Text(
              //                             (state.data as List)
              //                                     .map((e) =>
              //                                         e["month"].toString())
              //                                     .toList()[i] +
              //                                 " месяцев",
              //                             style: TextStyle(
              //                                 color: Color(0xff242424),
              //                                 fontSize: 14.sp,
              //                                 fontWeight: FontWeight.w300),
              //                           ),
              //                           Transform.scale(
              //                             scale: 1.4,
              //                             child: SvgPicture.asset(
              //                                 "assets/icons/" +
              //                                     (isAvailableMonth(
              //                                             widget.appModel,
              //                                             (state.data as List)
              //                                                 .map((e) =>
              //                                                     e["month"]
              //                                                         .toString())
              //                                                 .toList()[i])
              //                                         ? "check.svg"
              //                                         : "cancel.svg"),
              //                                 fit: BoxFit.cover),
              //                           )
              //                         ],
              //                       )),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       SizedBox(
              //         width: 325.w,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Text(
              //               "Оформление рассрочки",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 15.sp,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         height: 16.h,
              //       ),
              //       Container(
              //         width: 325.w,
              //         // xasg
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(8.r),
              //             boxShadow: [
              //               BoxShadow(
              //                   color: const Color(0xff323247).withOpacity(0.14),
              //                   offset: Offset(0, 4.h),
              //                   blurRadius: 8.r)
              //             ]),
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Container(
              //               width: 325.w,
              //               height: 40.h,
              //               alignment: Alignment.center,
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     "Общая сумма рассрочки :",
              //                     style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 13.sp,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                   Text(
              //                     toMoney(((((widget.total ??
              //                                         widget
              //                                             .appModel["amount"]) ??
              //                                     0) *
              //                                 (1 +
              //                                     (int.parse(state
              //                                             .data[selectedIndex]
              //                                                 ["percent"]
              //                                             .toString()) /
              //                                         100))) as double)
              //                             .toInt()) +
              //                         " сум",
              //                     style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 13.sp,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Container(
              //               width: 325.w,
              //               height: 40.h,
              //               alignment: Alignment.center,
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     "Ежемесячная оплата : ",
              //                     style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 13.sp,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                   Text(
              //                     "${((((widget.total ?? widget.appModel["amount"]) ?? 0) * (1 + (int.parse(state.data[selectedIndex]["percent"].toString()) / 100))) as double).toInt() ~/ int.parse(state.data[selectedIndex]["month"].toString())} сум",
              //                     style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 13.sp,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       SizedBox(
              //         width: 325.w,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             SizedBox(
              //               width: 325.w,
              //               child: Text(
              //                 "Расчёты произведены на основе данных представленных клиентом и могут отличаться от произведённых в банке ",
              //                 style: TextStyle(
              //                   color: Colors.grey.shade600,
              //                   fontSize: 15.sp,
              //                   fontWeight: FontWeight.w200,
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         height: 32.h,
              //       ),
              //       BlocListener<UpdateApp6Bloc, UpdateApp6State>(
              //           child: SizedBox(),
              //           listener: (context, state) async {
              //             if (state is UpdateApp6WaitingState) {
              //               loadingService.showLoading(context);
              //             } else if (state is UpdateApp6ErrorState) {
              //               loadingService.closeLoading(context);
              //               if (state.statusCode == 401) {
              //                 Future.wait([
              //                   CacheService.remove(
              //                     CacheService.token,
              //                   ),
              //                   CacheService.remove(
              //                     CacheService.user,
              //                   )
              //                 ]);
              //                 Flushbar(
              //                   backgroundColor: Colors.red.shade700,
              //                   dismissDirection:
              //                       FlushbarDismissDirection.HORIZONTAL,
              //                   flushbarPosition: FlushbarPosition.TOP,
              //                   flushbarStyle: FlushbarStyle.GROUNDED,
              //                   isDismissible: true,
              //                   message: "Пожалуйста, войдите снова",
              //                   messageColor: Colors.white,
              //                   messageSize: 18.sp,
              //                   icon: Icon(
              //                     Icons.error,
              //                     size: 28.0,
              //                     color: Colors.white,
              //                   ),
              //                   duration: Duration(minutes:1),
              //                   leftBarIndicatorColor: Colors.red.shade700,
              //                 ).show(context);
        
              //                 Navigator.pushNamedAndRemoveUntil(
              //                   context,
              //                   RouteNames.login,
              //                   (route) => false,
              //                 );
              //               } else {
              //                 Flushbar(
              //                   backgroundColor: Colors.red.shade700,
              //                   dismissDirection:
              //                       FlushbarDismissDirection.HORIZONTAL,
              //                   flushbarPosition: FlushbarPosition.TOP,
              //                   flushbarStyle: FlushbarStyle.GROUNDED,
              //                   isDismissible: true,
              //                   message: state.message,
              //                   messageColor: Colors.white,
              //                   messageSize: 18.sp,
              //                   icon: Icon(
              //                     Icons.error,
              //                     size: 28.0,
              //                     color: Colors.white,
              //                   ),
              //                   duration: Duration(minutes:1),
              //                   leftBarIndicatorColor: Colors.red.shade700,
              //                 ).show(context);
              //               }
              //             } else if (state is UpdateApp6SuccessState) {
              //               loadingService.closeLoading(context);
              //               widget.appModel = state.data;
              //               AppController.update6(
              //                 context,
              //                 id: widget.appModel["id"].toString(),
              //                 app: widget.appModel,
              //               );
              //               Navigator.pushReplacementNamed(
              //                 context,
              //                 RouteNames.contractView,
              //                 arguments: {
              //                   "appModel": widget.appModel,
              //                 },
              //               );
              //             }
              //           }),
              //       BlocListener<CancelByClientBloc, CancelByClientState>(
              //           child: SizedBox(),
              //           listener: (context, state) async {
              //             if (state is CancelByClientWaitingState) {
              //               loadingService.showLoading(context);
              //             } else if (state is CancelByClientErrorState) {
              //               loadingService.closeLoading(context);
              //               if (state.statusCode == 401) {
              //                 Future.wait([
              //                   CacheService.remove(
              //                     CacheService.token,
              //                   ),
              //                   CacheService.remove(
              //                     CacheService.user,
              //                   )
              //                 ]);
              //                 Flushbar(
              //                   backgroundColor: Colors.red.shade700,
              //                   dismissDirection:
              //                       FlushbarDismissDirection.HORIZONTAL,
              //                   flushbarPosition: FlushbarPosition.TOP,
              //                   flushbarStyle: FlushbarStyle.GROUNDED,
              //                   isDismissible: true,
              //                   message: "Пожалуйста, войдите снова",
              //                   messageColor: Colors.white,
              //                   messageSize: 18.sp,
              //                   icon: Icon(
              //                     Icons.error,
              //                     size: 28.0,
              //                     color: Colors.white,
              //                   ),
              //                   duration: Duration(minutes:1),
              //                   leftBarIndicatorColor: Colors.red.shade700,
              //                 ).show(context);
        
              //                 Navigator.pushNamedAndRemoveUntil(
              //                   context,
              //                   RouteNames.login,
              //                   (route) => false,
              //                 );
              //               } else {
              //                 Flushbar(
              //                   backgroundColor: Colors.red.shade700,
              //                   dismissDirection:
              //                       FlushbarDismissDirection.HORIZONTAL,
              //                   flushbarPosition: FlushbarPosition.TOP,
              //                   flushbarStyle: FlushbarStyle.GROUNDED,
              //                   isDismissible: true,
              //                   message: state.message,
              //                   messageColor: Colors.white,
              //                   messageSize: 18.sp,
              //                   icon: Icon(
              //                     Icons.error,
              //                     size: 28.0,
              //                     color: Colors.white,
              //                   ),
              //                   duration: Duration(minutes:1),
              //                   leftBarIndicatorColor: Colors.red.shade700,
              //                 ).show(context);
              //               }
              //             } else if (state is CancelByClientSuccessState) {
              //               loadingService.closeLoading(context);
              //               Navigator.pushNamedAndRemoveUntil(
              //                   context, RouteNames.applicationView, (r) => true);
              //               Flushbar(
              //                 backgroundColor: Colors.green.shade500,
              //                 dismissDirection:
              //                     FlushbarDismissDirection.HORIZONTAL,
              //                 flushbarPosition: FlushbarPosition.TOP,
              //                 flushbarStyle: FlushbarStyle.GROUNDED,
              //                 isDismissible: true,
              //                 message: "Заявка успешно удалено",
              //                 messageColor: Colors.white,
              //                 messageSize: 18.sp,
              //                 icon: Icon(
              //                   Icons.check,
              //                   size: 28.0,
              //                   color: Colors.white,
              //                 ),
              //                 duration: Duration(minutes:1),
              //                 leftBarIndicatorColor: Colors.white,
              //               ).show(context);
              //             }
              //           }),
        
              //       GestureDetector(
              //         onTap: () {
              //           // ignore: unnecessary_type_check
              //           if (state is GetPercentsSuccessState) {
              //             ZayavkaController.update6(context,
              //                 id: "${widget.appModel["id"]}",
              //                 expired_month:
              //                     state.data[selectedIndex]["month"].toString(),
              //                 payment_amount: ((((widget.appModel["amount"] ??
              //                                 widget.total) ??
              //                             0) *
              //                         (1 +
              //                             (int.parse(state.data[selectedIndex]
              //                                         ["percent"]
              //                                     .toString()) /
              //                                 100))) as double)
              //                     .toInt());
              //           }
              //         },
              //         child: Container(
              //           width: 327.w,
              //           height: 50.h,
              //           alignment: Alignment.center,
              //           decoration: BoxDecoration(
              //               color: const Color(0xffBE52F2),
              //               borderRadius: BorderRadius.circular(8.r),
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: const Color(0xff323247).withOpacity(0.3),
              //                   offset: Offset(0, 4.h),
              //                   blurRadius: 4.r,
              //                   // blurStyle: BlurStyle.outer
              //                 ),
              //               ]),
              //           child: Text(
              //             "Оформить",
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 16.sp,
              //               fontWeight: FontWeight.w300,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 16.h,
              //       ),
              //       Container(
              //         width: 327.w,
              //         height: 50.h,
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           color: Colors.grey.shade400,
              //           borderRadius: BorderRadius.circular(8.r),
              //         ),
              //         child: Text(
              //           "Отказ клиента",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16.sp,
              //             fontWeight: FontWeight.w300,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            } else {
              return SizedBox();
            }
          }),
        ),
      ),
    );
  }

  bool checkFuncOne(List monthData) {
    return (checkPeriod(3, monthData) ||
        checkPeriod(6, monthData) ||
        checkPeriod(9, monthData) ||
        checkPeriod(12, monthData));
  }

  fullProductPriceArea<Widget>() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Общая сумма товара',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(
              width: 1.sp,
              color: const Color(0xffE8E8E8),
            ),
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Общая сумма товара',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    width: 1.sp,
                    color: const Color(0xffE8E8E8),
                  ),
                ),
                child: TextFormField(
                  controller: fullPriceController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '5,000,000.00 сум',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Выберите срок',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  customBottomSheet(context, decorWidget());
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      width: 1.sp,
                      color: const Color(0xffE8E8E8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '12 месяцев',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_down,
                        color: Colors.grey.shade400,
                        size: 16.sp,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Условия рассрочки:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  customBottomSheet(context, decorWidget());
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      width: 1.sp,
                      color: const Color(0xffE8E8E8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Условия рассрочки:',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_down,
                        color: Colors.grey.shade400,
                        size: 16.sp,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  decorWidget() {
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
                            customer_rejection[index],
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
                customButton(context, 'Применить', () {
                  Navigator.of(context).pop();
                }, Colors.deepPurple,
                    buttonWidth: MediaQuery.of(context).size.width),
                SizedBox(height: 16.sp),
              ],
            ),
          ),
        );
      },
    );
  }

  double? totallPrice() {
    double total = 0;
    products.forEach((p) {
      double? summa = double.tryParse(
          p["price"].text.toString().replaceAll(" ", "").replaceAll(",", "."));
      if (summa != null && p["name"].text.toString().isNotEmpty) {
        total += summa;
      }
    });
    if (total == 0) {
      return null;
    }
    return total;
  }

  checkProduct() {
    bool result = true;
    products.forEach((p) {
      double? summa = double.tryParse(
          p["price"].text.toString().replaceAll(" ", "").replaceAll(",", "."));
      if (summa == null || p["name"].text.toString().isEmpty) {
        result = false;
        ;
      }
    });
    return result;
  }

  List productToJson() {
    print(products);
    List result = [];
    for (var i = 0; i < products.length; i++) {
      var e = products[i];
      if (e["name"].text.toString().isNotEmpty &&
          e["price"].text.toString().replaceAll(" ", "").isNotEmpty) {
        result.add({
          "name": e["name"].text,
          "price": double.parse(e["price"]
              .text
              .toString()
              .replaceAll(" ", "")
              .replaceAll(",", "."))
        });
      }
    }
    return result;
  }
}
