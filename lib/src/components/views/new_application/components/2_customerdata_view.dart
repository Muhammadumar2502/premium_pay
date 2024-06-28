import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:premium_pay_new/export_files.dart';
import 'package:premium_pay_new/src/blocs/6_card/check/check_bloc.dart';
import 'package:premium_pay_new/src/blocs/6_card/check/check_state.dart';
import 'package:premium_pay_new/src/controllers/7_card_controller.dart';
import 'package:premium_pay_new/src/core/screenshot/screenshot_secure.dart';
import 'package:translator/translator.dart';

import '../../../../blocs/6_card/send/sendOtp_bloc.dart';
import '../../../../blocs/6_card/send/sendOtp_state.dart';
import '../../../../blocs/6_card/verify/verify_bloc.dart';
import '../../../../blocs/6_card/verify/verify_state.dart';

// ignore: must_be_immutable
class CustomerDataView extends StatefulWidget {
  Map? appModel;
  bool? isAvailable;
  Map? myidInfo;
  String? birthDate;

  CustomerDataView(
      {Key? key,
      required this.myidInfo,
      required this.birthDate,
      required this.appModel,
      this.isAvailable = false})
      : super(key: key);
  // final data;

  @override
  State<CustomerDataView> createState() => _CustomerDataViewState();
}

class _CustomerDataViewState extends State<CustomerDataView> {
  Map? region;
  Map? district;

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController middlenameController = TextEditingController();
  TextEditingController phoneController = TextEditingController(text: "+998 ");
  TextEditingController phoneController2 = TextEditingController(text: "+998 ");

  TextEditingController addressController = TextEditingController();
  TextEditingController nomerpkController = TextEditingController();
  TextEditingController srokController = TextEditingController();

  TextEditingController regionController = TextEditingController();
  TextEditingController dicController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController smscontroller = TextEditingController();
  String? cardId;
  var uzFormat = MaskTextInputFormatter(
    mask: '+998 ## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );
  var uzFormat2 = MaskTextInputFormatter(
    mask: '+998 ## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );
  var cardMask = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );
  var dateMask = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );
  Color unselectedColor = Colors.grey.shade400;
  // String selectedText = '';
  String? first_name;
  String? middle_name;
  String? last_name;
  String? phone1;
  String? phone2;

  String? districtttt;
  String? district_id;
  // String? address;
  String? pk_number;
  String? time_card;

  String? regionName;
  String? districtName;
  String? homeName;
  int? region_id;

  Map? myidInfo;
  Timer? _timer;
  int countDown = 60;

  @override
  void dispose() {
    _timer?.cancel();
    RemoveScreenshotSecure();
    super.dispose();
  }

  @override
  void initState() {
    noScreenshotSecure();
    CardController.setIntialsendOtp(context);
    CardController.setIntialVerify(context);
    // print(widget.appModel!["id"]);
    widget.appModel?["myidInfo"] =
        HiveService.getZayavka(widget.appModel!["id"].toString())?["myidInfo"];
    widget.birthDate =
        HiveService.getZayavka(widget.appModel!["id"].toString())?["birthDate"];
    myidInfo = widget.appModel?["myidInfo"];
    first_name = myidInfo?["profile"]?["common_data"]?["first_name"]
        .toString()
        .capitalize();
    middle_name = myidInfo?["profile"]?["common_data"]?["middle_name"]
        .toString()
        .capitalize();
    last_name = myidInfo?["profile"]?["common_data"]?["last_name"]
        .toString()
        .capitalize();
    // address = myidInfo?["profile"]["address"]["permanent_address"];
    regionName =
        myidInfo?["profile"]?["address"]?["permanent_registration"]?["region"];
    districtName = myidInfo?["profile"]?["address"]?["permanent_registration"]
        ?["district"];
    homeName = myidInfo?["profile"]?["address"]?["permanent_address"];
    region_id = int.tryParse(myidInfo?["profile"]?["address"]
            ?["permanent_registration"]?["region_id"] ??
        "");

    items = [
      {
        "title": "Имя клиента",
        "checked":
            first_name != null && middle_name != null && last_name != null,
        "checkFunc": () =>
            nameController.text.isNotEmpty &&
            middlenameController.text.isNotEmpty &&
            surnameController.text.isNotEmpty,
        "formKey": GlobalKey<FormState>(),
        "textColor": Color(0xff242424),
        // "textColor":Colors.white,
        "children": [
          {
            "hint": "Имя",
            "controller": nameController..text = first_name ?? "",
            "showCursor": first_name == null,
            "readOnly": first_name != null,
            "onChanged": (value) {
              first_name = value;
              setState(() {});
            },
            "keyboardType": TextInputType.name,
          },
          {
            "hint": "Фамилия",
            "controller": surnameController..text = last_name ?? "",
            "showCursor": last_name == null,
            "readOnly": last_name != null,
            "onChanged": (value) {
              last_name = value;
              setState(() {});
            },
            "keyboardType": TextInputType.name,
          },
          {
            "hint": "Отчества",
            "controller": middlenameController..text = middle_name ?? "",
            "showCursor": middle_name == null,
            "readOnly": middle_name != null,
            "onChanged": (value) {
              middle_name = value;
              setState(() {});
            },
            "keyboardType": TextInputType.name,
          },
        ]
      },
      {
        "title": "Номер телефона клиента",
        "checked": false,
        "checkFunc": () =>
            phoneController.text.length == 17 &&
            phoneController2.text.length == 17,
        "formKey": GlobalKey<FormState>(),
        "textColor": Color(0xff242424),
        // "textColor":Colors.white,
        "children": [
          {
            "hint": "Номер телефона",
            "controller": phoneController,
            "autocorrect": false,
            "showCursor": true,
            "keyboardType": TextInputType.number,
            "onChanged": (value) {
              setState(() {});
            },
            "inputFormatters": [uzFormat],
          },
          {
            "hint": "Номер телефона родственника или друга",
            "controller": phoneController2,
            "showCursor": true,
            "autocorrect": false,
            "keyboardType": TextInputType.number,
            "onChanged": (value) {
              setState(() {});
            },
            "inputFormatters": [uzFormat2],
          },
        ]
      },
      {
        "title": "Адресные данные",
        "checked":
            regionName != null && districtName != null && homeName != null,
        "textColor": Color(0xff242424),
        "checkFunc": () =>
            regionController.text.isNotEmpty &&
            dicController.text.isNotEmpty &&
            homeController.text.isNotEmpty,
        "formKey": GlobalKey<FormState>(),
        // "textColor":Colors.white,
        "children": [
          {
            "hint": "Область",
            // "initialValue": regionName,
            "controller": regionController..text = regionName ?? "",
            "showCursor": regionName == null,
            "readOnly": regionName != null,
            "maxLines": null,
            "onChanged": (value) {
              setState(() {});
            },
          },
          {
            "hint": "Город / район проживания",
            // "initialValue": districtName,
            "controller": dicController..text = districtName ?? "",
            "showCursor": districtName == null,
            "readOnly": districtName != null,
            "maxLines": null,
            "onChanged": (value) {
              setState(() {});
            },
          },
          {
            "hint": "Адрес",
            // "initialValue": homeName,
            "controller": homeController..text = homeName ?? "",
            "showCursor": homeName == null,
            "readOnly": homeName != null,
            "maxLines": null,
            "onChanged": (value) {
              setState(() {});
            },
          },
        ]
      },
      {
        "title": "Данные ПК",
        "checked": false,
        "textColor": Color(0xff242424),
        "checkFunc": () =>
            nomerpkController.length == 19 &&
            srokController.text.length == 5 &&
            BlocProvider.of<CardCheckBloc>(context).state
                is CardCheckSuccessState &&
            BlocProvider.of<CardSendOtpBloc>(context).state
                is CardSendOtpSuccessState &&
            BlocProvider.of<CardVerifyBloc>(context).state
                is CardVerifySuccessState,
        "checkFuncForButton": () =>
            nomerpkController.length == 19 &&
            srokController.text.length == 5 &&
            tokenSortPartialRatio(
                    items[3]["children"][0]["placeholder"].toString(),
                    [
                      surnameController.text.toUpperCase(),
                      nameController.text.toUpperCase(),
                      middlenameController.text.toUpperCase()
                    ].join(" ").replaceAll("'", "").replaceAll("‘", "")) >=
                49,
        "formKey": GlobalKey<FormState>(),
        "children": [
          {
            "hint": "XXXX XXXX XXXX XXXX",
            "controller": nomerpkController,
            "keyboardType": TextInputType.number,
            "inputFormatters": [cardMask],
            "onChanged": (value) async {
              countDown = 60;
              _timer?.cancel();
              print(value.toString().length);
              if (value.length == 19) {
                await CardController.check(context,
                    card: cardMask.unmaskText(value));
              } else {
                items[3]["children"][0]["placeholder"] = "";

                await CardController.setIntialsendOtp(
                  context,
                );
                smscontroller.text = "";
              }

              setState(() {});
            },
            "placeholder": ""
          },
          {
            "hint": "Срок",
            "controller": srokController,
            "keyboardType": TextInputType.number,
            "onChanged": (value) async {
              countDown = 60;
              _timer?.cancel();
              await CardController.setIntialsendOtp(
                context,
              );
              smscontroller.text = "";
              setState(() {});
            },
            "inputFormatters": [
              dateMask,
            ],
          },
        ]
      }
    ];
    super.initState();
  }

  LoadingService loadingService = LoadingService();
  List<Map> items = [];

  @override
  Widget build(BuildContext context) {
    // for (var i = 0; i < 5; i++) {
    //   print("******************");
    // }
    // print(HiveService.getZayavka(widget.appModel!["id"].toString())?["myidInfo"]);

    // items.forEach((element) {
    //   print(element["checkFunc"]());
    // });
    final defaultPinTheme = PinTheme(
      width: 45.w,
      height: 45.w,
      textStyle: TextStyle(
          fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    final focusedPinTheme = PinTheme(
      width: 40.w,
      height: 40.w,
      textStyle: TextStyle(
          fontSize: 20.sp,
          color: AppConstant.primaryColor,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppConstant.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppConstant.primaryColor,
      ),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              color: Color(0xFFE4E4E4).withOpacity(0.6),
              height: 1.0,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Данные клиента",
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
        body: myidInfo == null
            ? Center(
                child: SizedBox(
                    width: 325.w,
                    child: Text(
                      "На этом телефоне нет информации о клиенте, проверьте еще раз этот клиент.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red.shade400,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w300),
                    )),
              )
            : SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        ...List.generate(
                            items.length,
                            (index) => Form(
                                  key: items[index]["formKey"],
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 4.h, horizontal: 24.w),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color(0xff323247)
                                                  .withOpacity(0.2),
                                              offset: Offset(0, 4.h),
                                              blurRadius: 8.r)
                                        ]),
                                    child: ExpansionTile(
                                      tilePadding: EdgeInsets.symmetric(
                                          horizontal: 24.w),
                                      maintainState: index.isOdd,
                                      // collapsedBackgroundColor:Color(0xffBE52F2) ,
                                      // collapsedTextColor: ,
                                      // backgroundColor: Color(0xffBE52F2) ,
                                      // collapsedIconColor: Color(0xffBE52F2),
                                      // title: Text(items[index]["checked"] ?  (items[index]["children"] as List).map((e) => e["controller"].text.toString()).toList().join(" "): items[index]["title"]),
                                      onExpansionChanged: (value) {
                                        setState(() {
                                          // items[index]["textColor"] =
                                          //     !value ? Color(0xff242424) : Colors.white;
                                        });
                                      },
      
                                      title: Text(
                                        items[index]["title"],
                                        style: TextStyle(
                                            color: items[index]["textColor"],
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      trailing: items[index]["checkFunc"]()
                                          ? Transform.scale(
                                              scale: 1.4,
                                              child: SvgPicture.asset(
                                                  "assets/icons/check.svg"),
                                            )
                                          : null,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      children: List.generate(
                                        items[index]["children"].length,
                                        (i) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Divider(
                                              thickness: 0.5.h,
                                              height: 0.5.h,
                                              color: Color(0XFF151522)
                                                  .withOpacity(0.1),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.w,
                                                  vertical: 6.h),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    initialValue: items[index]
                                                            ["children"][i]
                                                        ["initialValue"],
                                                    maxLines: items[index]
                                                            ["children"][i]
                                                        ["maxLines"],
                                                    controller: items[index]
                                                            ["children"][i]
                                                        ["controller"],
                                                    readOnly: items[index]
                                                                ["children"][i]
                                                            ["readOnly"] ??
                                                        false,
                                                    showCursor: items[index]
                                                            ["children"][i]
                                                        ["showCursor"],
                                                    onChanged: (value) {
                                                      items[index]["children"]
                                                              [i]
                                                          ["onChanged"](value);
      
                                                      // items[index]
                                                      //     ["checked"] = (items[
                                                      //                 index]
                                                      //             ["children"]
                                                      //         as List)
                                                      //     .every((element) =>
                                                      //         element["controller"]
                                                      //             .text
                                                      //             .toString()
                                                      //             .isNotEmpty &&
                                                      //         (element["placeholder"] !=
                                                      //                 null
                                                      //             ? (element["placeholder"]
                                                      //                     .toString()
                                                      //                     .isNotEmpty
                                                      //                 ? (tokenSortPartialRatio(
                                                      //                         element["placeholder"]
                                                      //                             .toString(),
                                                      //                         [
                                                      //                           surnameController.text.toUpperCase(),
                                                      //                           nameController.text.toUpperCase(),
                                                      //                           middlenameController.text.toUpperCase()
                                                      //                         ].join(" ").replaceAll("'", "").replaceAll("‘",
                                                      //                             "")) >=
                                                      //                     49)
                                                      //                 : false)
                                                      //             : true));
      
                                                      setState(() {});
                                                    },
                                                    autocorrect: items[index]
                                                                ["children"][i]
                                                            ["autocorrect"] ??
                                                        true,
                                                    keyboardType: items[index]
                                                            ["children"][i]
                                                        ["keyboardType"],
                                                    inputFormatters:
                                                        items[index]["children"]
                                                                [i]
                                                            ["inputFormatters"],
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff242424),
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    decoration: InputDecoration(
                                                      border:
                                                          const UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      hintText: items[index]
                                                              ["children"][i]
                                                          ["hint"],
                                                      hintStyle: TextStyle(
                                                        color:
                                                            Color(0xffC0C0C0),
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  if (items[index]["children"]
                                                                  [i]
                                                              ["placeholder"] !=
                                                          null &&
                                                      items[index]["children"]
                                                                      [i]
                                                                  ["controller"]
                                                              .text
                                                              .toString()
                                                              .length ==
                                                          19)
                                                    Row(
                                                      children: [
                                                        BlocBuilder<
                                                                CardCheckBloc,
                                                                CardCheckState>(
                                                            builder: (context,
                                                                state) {
                                                          if (state
                                                              is CardCheckSuccessState) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: 260.w,
                                                                  child: Text(
                                                                      state
                                                                          .data[
                                                                              "data"]
                                                                              [
                                                                              "holder"]
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: tokenSortPartialRatio(
                                                                                    state.data["data"]["holder"].toString().toUpperCase(),
                                                                                    [
                                                                                      surnameController.text.toUpperCase(),
                                                                                      nameController.text.toUpperCase(),
                                                                                      middlenameController.text.toUpperCase()
                                                                                    ].join(" ").replaceAll("'", "").replaceAll("‘", "")) >=
                                                                                49
                                                                            ? Color(0XFF00C48C)
                                                                            : Color(0xffFF647C),
                                                                      )),
                                                                ),
                                                                if (tokenSortPartialRatio(
                                                                        state
                                                                            .data["data"][
                                                                                "holder"]
                                                                            .toString()
                                                                            .toUpperCase(),
                                                                        [
                                                                          surnameController
                                                                              .text
                                                                              .toUpperCase(),
                                                                          nameController
                                                                              .text
                                                                              .toUpperCase(),
                                                                          middlenameController
                                                                              .text
                                                                              .toUpperCase()
                                                                        ].join(" ").replaceAll("'", "").replaceAll(
                                                                            "‘",
                                                                            "")) <
                                                                    49)
                                                                  Icon(
                                                                    Icons.error,
                                                                    color: Color(
                                                                        0xffFF647C),
                                                                    size: 30.sp,
                                                                  )
                                                              ],
                                                            );
                                                          } else if (state
                                                              is CardCheckErrorState) {
                                                            return Text(
                                                              state.message
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xffFF647C)),
                                                            );
                                                          } else {
                                                            return SizedBox();
                                                          }
                                                        }),
                                                        BlocListener<
                                                            CardCheckBloc,
                                                            CardCheckState>(
                                                          listener:
                                                              (context, state) {
                                                            String?
                                                                placeholder =
                                                                "";
                                                            if (state
                                                                is CardCheckSuccessState) {
                                                              placeholder = state
                                                                  .data["data"]
                                                                      ["holder"]
                                                                  .toString();
                                                            } else {
                                                              placeholder = "";
                                                            }
      
                                                            items[3]["children"]
                                                                        [0][
                                                                    "placeholder"] =
                                                                placeholder;
      
                                                            items[index][
                                                                "checked"] = (items[
                                                                            index]
                                                                        [
                                                                        "children"]
                                                                    as List)
                                                                .every((element) =>
                                                                    element["controller"].text.toString().isNotEmpty &&
                                                                    (element["placeholder"] != null
                                                                        ? (element["placeholder"].toString().isNotEmpty
                                                                            ? ((tokenSortPartialRatio(
                                                                                    element["placeholder"].toString(),
                                                                                    [
                                                                                      surnameController.text.toUpperCase(),
                                                                                      nameController.text.toUpperCase(),
                                                                                      middlenameController.text.toUpperCase()
                                                                                    ].join(" ").replaceAll("'", "").replaceAll("‘", "")) >=
                                                                                49))
                                                                            : false)
                                                                        : true));
                                                            print(">>> tokenSortPartialRatio:" +
                                                                tokenSortPartialRatio(
                                                                        placeholder,
                                                                        [
                                                                          surnameController
                                                                              .text
                                                                              .toUpperCase(),
                                                                          nameController
                                                                              .text
                                                                              .toUpperCase(),
                                                                          middlenameController
                                                                              .text
                                                                              .toUpperCase()
                                                                        ].join(" ").replaceAll("'", "").replaceAll("‘", ""))
                                                                    .toString());
                                                            setState(() {});
                                                          },
                                                          child: SizedBox(),
                                                        ),
                                                        BlocListener<
                                                            CardSendOtpBloc,
                                                            CardSendOtpState>(
                                                          listener: (context,
                                                              sendstate) {
                                                            if (sendstate
                                                                is CardSendOtpSuccessState) {
                                                              print(countDown);
                                                              print(_timer !=
                                                                  null);
                                                              print(_timer
                                                                  ?.isActive);
                                                              if (_timer
                                                                      ?.isActive ??
                                                                  false) {
                                                                _timer
                                                                    ?.cancel();
                                                              }
                                                              if (countDown ==
                                                                  60) {
                                                                print(">>>");
                                                                _timer = Timer.periodic(
                                                                    Duration(
                                                                        seconds:
                                                                            1),
                                                                    (timer) {
                                                                  if (countDown >
                                                                      0) {
                                                                    countDown =
                                                                        countDown -
                                                                            1;
                                                                  } else {
                                                                    _timer
                                                                        ?.cancel();
                                                                  }
                                                                  setState(
                                                                      () {});
                                                                });
                                                                print(_timer
                                                                    ?.isActive);
                                                              } else {
                                                                print("else");
                                                              }
      
                                                              setState(() {});
                                                            }
                                                          },
                                                          child: SizedBox(),
                                                        )
                                                      ],
                                                    ),
                                                  if (index == 3 && i == 1)
                                                    BlocBuilder<CardSendOtpBloc,
                                                            CardSendOtpState>(
                                                        builder:
                                                            (context, state) {
                                                      if (state
                                                          is CardSendOtpIntialState) {
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (items[3][
                                                                    "checkFuncForButton"]()) {
                                                                  await CardController
                                                                      .setIntialVerify(
                                                                          context);
                                                                  countDown =
                                                                      60;
                                                                  setState(
                                                                      () {});
                                                                  await CardController.sendOtp(
                                                                      context,
                                                                      card: cardMask.unmaskText(
                                                                          nomerpkController
                                                                              .text),
                                                                      expiry: dateMask
                                                                          .unmaskText(
                                                                              srokController.text));
                                                                }
                                                              },
                                                              child: Container(
                                                                height: 50.h,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: items[3]["checkFuncForButton"]()
                                                                            ? const Color(
                                                                                0xffBE52F2)
                                                                            : Colors
                                                                                .grey.shade400,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.r),
                                                                        boxShadow: items[3]["checkFuncForButton"]()
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
                                                                  "Отправить смс",
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
                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                          ],
                                                        );
                                                      } else if (state
                                                          is CardSendOtpWaitingState) {
                                                        return SizedBox(
                                                          width: 160.w,
                                                          height: 160.w,
                                                          child: Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: const Color(
                                                                  0xffBE52F2),
                                                              strokeWidth: 6.w,
                                                              strokeAlign: 2,
                                                              strokeCap:
                                                                  StrokeCap
                                                                      .round,
                                                              backgroundColor:
                                                                  const Color(
                                                                          0xffBE52F2)
                                                                      .withOpacity(
                                                                          0.2),
                                                            ),
                                                          ),
                                                        );
                                                      } else if (state
                                                          is CardSendOtpSuccessState) {
                                                        return BlocBuilder<
                                                                CardVerifyBloc,
                                                                CardVerifyState>(
                                                            builder: (context,
                                                                verifystate) {
                                                          if (verifystate
                                                              is CardVerifyWaitingState) {
                                                            return SizedBox(
                                                              width: 160.w,
                                                              height: 160.w,
                                                              child: Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: const Color(
                                                                      0xffBE52F2),
                                                                  strokeWidth:
                                                                      6.w,
                                                                  strokeAlign:
                                                                      2,
                                                                  strokeCap:
                                                                      StrokeCap
                                                                          .round,
                                                                  backgroundColor: const Color(
                                                                          0xffBE52F2)
                                                                      .withOpacity(
                                                                          0.2),
                                                                ),
                                                              ),
                                                            );
                                                          } else if (verifystate
                                                              is CardVerifySuccessState) {
                                                            return Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          20.h),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                      padding: EdgeInsets
                                                                          .all(4
                                                                              .w),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          border: Border.all(
                                                                              color: Color(0xff00C48C),
                                                                              width: 0.5.w),
                                                                          shape: BoxShape.circle),
                                                                      child: Icon(
                                                                        Icons
                                                                            .check_rounded,
                                                                        color: Color(
                                                                            0xff00C48C),
                                                                        size: 24
                                                                            .w,
                                                                      )),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  Text(
                                                                    "Одобренная карта",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xff00C48C),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          } else if (verifystate
                                                              is CardVerifyErrorState) {
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  verifystate
                                                                      .message
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Color(
                                                                          0xffFF647C)),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.h,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          280.w,
                                                                      child: Text(
                                                                          "Отправил код на номер\n" +
                                                                              heshUserNumber("+" +
                                                                                  state.data["data"]["phone"]
                                                                                      .toString()),
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.grey.shade400)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 20.h,
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Pinput(
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      length: 6,
                                                                      defaultPinTheme:
                                                                          defaultPinTheme,
                                                                      focusedPinTheme:
                                                                          focusedPinTheme,
                                                                      submittedPinTheme:
                                                                          submittedPinTheme,
                                                                      androidSmsAutofillMethod:
                                                                          AndroidSmsAutofillMethod
                                                                              .none,
                                                                      controller:
                                                                          smscontroller,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20.h,
                                                                    ),
                                                                    countDown !=
                                                                            0
                                                                        ? Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                "Отправить повторно через ",
                                                                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey.shade400),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 60.w,
                                                                                height: 60.w,
                                                                                child: Stack(
                                                                                  alignment: Alignment.center,
                                                                                  children: [
                                                                                    SizedBox.square(
                                                                                      child: CircularProgressIndicator(
                                                                                        value: (countDown / 60),
                                                                                        color: Colors.green,
                                                                                        strokeWidth: 5.0.w,
                                                                                        strokeCap: StrokeCap.round,
                                                                                      ),
                                                                                    ),
                                                                                    Text(timerText(countDown), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppConstant.primaryColor)),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              if (items[3]["checkFuncForButton"]()) {
                                                                                smscontroller.text = "";
                                                                                countDown = 60;
                                                                                setState(() {});
      
                                                                                await CardController.setIntialVerify(context);
                                                                                await CardController.sendOtp(context, card: cardMask.unmaskText(nomerpkController.text), expiry: dateMask.unmaskText(srokController.text));
                                                                              }
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 50.h,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(color: AppConstant.primaryColor, borderRadius: BorderRadius.circular(8.r), boxShadow: [
                                                                                BoxShadow(
                                                                                  color: const Color(0xff323247).withOpacity(0.3),
                                                                                  offset: Offset(0, 4.h),
                                                                                  blurRadius: 4.r,
                                                                                  // blurStyle: BlurStyle.outer
                                                                                ),
                                                                              ]),
                                                                              child: Text(
                                                                                "Еще oтправить смс",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16.sp,
                                                                                  fontWeight: FontWeight.w300,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                    SizedBox(
                                                                      height:
                                                                          20.h,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (smscontroller.text.length ==
                                                                            6) {
                                                                          await CardController.verify(
                                                                              context,
                                                                              id: state.data["data"]["id"].toString(),
                                                                              type: state.data["data"]["type"].toString(),
                                                                              code: smscontroller.text);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            50.h,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            color: smscontroller.text.length == 6 ? const Color(0xffBE52F2) : Colors.grey.shade300,
                                                                            borderRadius: BorderRadius.circular(8.r),
                                                                            boxShadow: smscontroller.text.length != 6
                                                                                ? null
                                                                                : [
                                                                                    BoxShadow(
                                                                                      color: const Color(0xff323247).withOpacity(0.3),
                                                                                      offset: Offset(0, 4.h),
                                                                                      blurRadius: 4.r,
                                                                                      // blurStyle: BlurStyle.outer
                                                                                    ),
                                                                                  ]),
                                                                        child:
                                                                            Text(
                                                                          "Подтвердить код",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                16.sp,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20.h,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            );
                                                          } else {
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                SizedBox(
                                                                  height: 20.h,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          280.w,
                                                                      child: Text(
                                                                          "Отправил код на номер\n" +
                                                                              heshUserNumber("+" +
                                                                                  state.data["data"]["phone"]
                                                                                      .toString()),
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.grey.shade400)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 20.h,
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Pinput(
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      length: 6,
                                                                      defaultPinTheme:
                                                                          defaultPinTheme,
                                                                      focusedPinTheme:
                                                                          focusedPinTheme,
                                                                      submittedPinTheme:
                                                                          submittedPinTheme,
                                                                      androidSmsAutofillMethod:
                                                                          AndroidSmsAutofillMethod
                                                                              .none,
                                                                      controller:
                                                                          smscontroller,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20.h,
                                                                    ),
                                                                    countDown !=
                                                                            0
                                                                        ? Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                "Отправить повторно через ",
                                                                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey.shade400),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 60.w,
                                                                                height: 60.w,
                                                                                child: Stack(
                                                                                  alignment: Alignment.center,
                                                                                  children: [
                                                                                    SizedBox.square(
                                                                                      child: CircularProgressIndicator(
                                                                                        value: (countDown / 60),
                                                                                        color: Colors.green,
                                                                                        strokeWidth: 5.0.w,
                                                                                        strokeCap: StrokeCap.round,
                                                                                      ),
                                                                                    ),
                                                                                    Text(timerText(countDown), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppConstant.primaryColor)),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              if (items[3]["checkFuncForButton"]()) {
                                                                                smscontroller.text = "";
                                                                                countDown = 60;
                                                                                setState(() {});
                                                                                await CardController.setIntialVerify(context);
                                                                                await CardController.sendOtp(context, card: cardMask.unmaskText(nomerpkController.text), expiry: dateMask.unmaskText(srokController.text));
                                                                              }
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 50.h,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(color: AppConstant.primaryColor, borderRadius: BorderRadius.circular(8.r), boxShadow: [
                                                                                BoxShadow(
                                                                                  color: const Color(0xff323247).withOpacity(0.3),
                                                                                  offset: Offset(0, 4.h),
                                                                                  blurRadius: 4.r,
                                                                                  // blurStyle: BlurStyle.outer
                                                                                ),
                                                                              ]),
                                                                              child: Text(
                                                                                "Еще oтправить смс",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16.sp,
                                                                                  fontWeight: FontWeight.w300,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                    SizedBox(
                                                                      height:
                                                                          20.h,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (smscontroller.text.length ==
                                                                            6) {
                                                                          await CardController.verify(
                                                                              context,
                                                                              id: state.data["data"]["id"].toString(),
                                                                              type: state.data["data"]["type"].toString(),
                                                                              code: smscontroller.text);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            50.h,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            color: smscontroller.text.length == 6 ? const Color(0xffBE52F2) : Colors.grey.shade300,
                                                                            borderRadius: BorderRadius.circular(8.r),
                                                                            boxShadow: smscontroller.text.length != 6
                                                                                ? null
                                                                                : [
                                                                                    BoxShadow(
                                                                                      color: const Color(0xff323247).withOpacity(0.3),
                                                                                      offset: Offset(0, 4.h),
                                                                                      blurRadius: 4.r,
                                                                                      // blurStyle: BlurStyle.outer
                                                                                    ),
                                                                                  ]),
                                                                        child:
                                                                            Text(
                                                                          "Подтвердить код",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                16.sp,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20.h,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            );
                                                          }
                                                        });
                                                      } else if (state
                                                          is CardSendOtpErrorState) {
                                                        return Text(
                                                          state.message
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xffFF647C)),
                                                        );
                                                      } else {
                                                        return SizedBox();
                                                      }
                                                    }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      ],
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    BlocListener<CardVerifyBloc, CardVerifyState>(
                      listener: (context, Verifystate) {
                        if (Verifystate is CardVerifySuccessState) {
                          cardId = Verifystate.data["data"]["card"];
                        }
                        setState(() {});
                      },
                      child: SizedBox(),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (check() && cardId != null) {
                          Map? zayavka = HiveService.getZayavka(
                              "${widget.appModel?["id"]}");
                          await HiveService.create_or_updateZayavka({
                            "id": widget.appModel?["id"].toString(),
                            "myidInfo": myidInfo,
                            "cardNumber":
                                nomerpkController.text.replaceAll(" ", ""),
                            "birthDate": zayavka?["birthDate"],
                            "IdentificationVideoBase64":
                                zayavka?["IdentificationVideoBase64"],
                          });
      
                          GoogleTranslator translator = GoogleTranslator();
                          // print(myidInfo?["profile"]["doc_data"]["issued_date"]);
                          // String address = (await translator.translate(
                          //         "${myidInfo?["profile"]["address"]["permanent_address"]}",
                          //         from: "ru",
                          //         to: "uz"))
                          //     .text;
                          // String homeNameTr = (await translator.translate(homeName!,
                          //         from: "ru", to: "uz"))
                          //     .text;
                          //     String regionNameTr = (await translator.translate(regionName!,
                          //       //  from: "cyr",
                          //          to: "uz"))
                          //     .text;
                          //     String districtNameTr = (await translator.translate(districtName!,
                          //         // from: "cyr",
                          //           to: "uz"))
                          //     .text;
                          String dataMini = myidInfo?["profile"]?["address"]
                                  ["permanent_registration"]?["address"] ??
                              "";
                          // print(">>>>> after data");
                          // print(dataMini);
                          String textData = dataMini.contains("ШАҲРИ") ||
                                  dataMini.contains("ТУМАНИ") ||
                                  dataMini.contains("ВИЛОЯТИ") ||
                                  dataMini.contains("область") ||
                                  dataMini.contains("район") ||
                                  dataMini.contains("шаҳри") ||
                                  dataMini.contains("тумани") ||
                                  dataMini.contains("вилояти") ||
                                  dataMini.contains("ОБЛАСТЬ") ||
                                  dataMini.contains("РАЙОН")
                              ? ""
                              : regionController.text +
                                  "," +
                                  dicController.text +
                                  ",";
                          // for (var i = 0; i < 10; i++) {
                          //   print(">>>>");
                          // }
                          // String dData = textData + dataMini;
                          // if (textData.isNotEmpty) {
                          //   if (dData.contains("ШАҲРИ") ||
                          //       dData.contains("ТУМАНИ") ||
                          //       dData.contains("шаҳри") ||
                          //       dData.contains("тумани") ||
                          //       dData.contains("райони") ||
                          //       dData.contains("РАЙОНИ")) {
                          //     textData = (await translator.translate(textData,
                          //             from: "ru", to: "uz"))
                          //         .text;
                          //   } else {
                          //     textData = (await translator.translate(
                          //       textData,
                          //       from: "ru",
                          //       to: "uz",
                          //     ))
                          //         .text;
                          //   }
                          // }
      
                          // if (dataMini.contains("ШАҲРИ") ||
                          //     dataMini.contains("ТУМАНИ") ||
                          //     dataMini.contains("шаҳри") ||
                          //     dataMini.contains("тумани") ||
                          //     dataMini.contains("райони") ||
                          //     dataMini.contains("РАЙОНИ")) {
                          // dataMini =
                          //     (await translator.translate(dataMini, to: "uz"))
                          //         .text;
                          // } else {
                          //   dataMini = (await translator.translate(
                          //     dataMini,
                          //     from: "ru",
                          //     to: "uz",
                          //   ))
                          //       .text;
                          //   dataMini = dataMini.replaceAll("msg", "mfy");
                          //   dataMini = dataMini.replaceAll("МСГ", "MFY");
                          // }
      
                          // dataMini = (await translator.translate(dataMini,
                          //         from: "ru", to: "uz"))
                          //     .text;
      
                          // print(textData);
      
                          String passport_by = (await translator.translate(
                                  "${myidInfo?["profile"]["doc_data"]["issued_by"]}",
                                  from: "ru",
                                  to: "uz"))
                              .text;
                          // print(">>>>>>>>>>..");
                          // print(textData + dataMini);
                          // return;
                          await ZayavkaController.update2(context,
                              id: "${widget.appModel?["id"]}",
                              phoneNumber:
                                  phoneController.text.replaceAll(" ", ""),
                              phoneNumber2:
                                  phoneController2.text.replaceAll(" ", ""),
                              cardNumber:
                                  shrift_cardNumber(nomerpkController.text),
                              passport_date: myidInfo?["profile"]["doc_data"]
                                  ["issued_date"],
                              passport_by: passport_by,
                              address: {
                                "region": regionName,
                                "city": districtName,
                                "home": textData + dataMini,
                                "region_id": myidInfo?["profile"]?["address"]
                                        ?["permanent_registration"]
                                    ?["region_id_cbu"],
                                "city_id": myidInfo?["profile"]?["address"]
                                        ?["permanent_registration"]
                                    ?["district_id_cbu"],
                                "address": myidInfo?["profile"]?["address"]
                                        ?["permanent_registration"]
                                    ?["address"],
      
                                    "passport_by" : myidInfo?["profile"]?["doc_data"]?["issued_by"]
                              },
                              region_id: region_id,
                              cardId: cardId);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: check()
                                ? const Color(0xffBE52F2)
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: check()
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
                          "Подтвердить информация",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    BlocListener<UpdateApp2Bloc, UpdateApp2State>(
                        child: SizedBox(),
                        listener: (context, state) async {
                          if (state is UpdateApp2WaitingState) {
                            loadingService.showLoading(context);
                          } else if (state is UpdateApp2ErrorState) {
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
                                message: state.message ?? "some error",
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
                          } else if (state is UpdateApp2SuccessState) {
                            loadingService.closeLoading(context);
                            widget.appModel = state.data;
                            AppController.update2(context,
                                id: widget.appModel?["id"].toString(),
                                app: widget.appModel);
                            Navigator.pushReplacementNamed(
                              context,
                              RouteNames.SelfieWithPassportView,
                              arguments: {
                                "appModel": widget.appModel,
                              },
                            );
                          }
                        }),
                  ],
                ),
              ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   for (var i = 0; i < 30; i++) {
  //     print("=============");
  //   }

  //   print(myidInfo?["profile"]["address"]["permanent_registration"]);

  //   return AbsorbPointer(
  //     absorbing: !(widget.isAvailable ?? true),
  //     child: Scaffold(
  //       appBar: customAppBar(context, 'Данные клиента'),
  //       body: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 16.w),
  //         child: SingleChildScrollView(
  //           physics: const BouncingScrollPhysics(),
  //           child: Form(
  //             key: formKey,
  //             child: Column(
  //               children: [
  //                 SizedBox(height: 16.h),
  //                 namesArea(),
  //                 SizedBox(height: 16.h),
  //                 numberArea(),
  //                 SizedBox(height: 16.h),
  //                 addressArea(),
  //                 SizedBox(height: 16.h),
  //                 dataArea(),
  //                 SizedBox(height: 16.h),
  //                 customButton(
  //                   context,
  //                   'Подтвердить',
  //                   () async {
  //                     //  print((widget.appModel?["myidInfo"]["profile"]["address"]["permanent_address"] ));

  //                     if (check()) {
  //                       await HiveService.create_or_updateZayavka({
  //                         "id": widget.appModel?["id"].toString(),
  //                         "myidInfo": myidInfo,
  //                         "cardNumber":
  //                             nomerpkController.text.replaceAll(" ", ""),
  //                         "birthDate": widget.birthDate
  //                       });

  //                       GoogleTranslator translator = GoogleTranslator();
  //                       print(myidInfo?["profile"]["doc_data"]["issued_date"]);
  //                       String address = (await translator.translate(
  //                               "${myidInfo?["profile"]["address"]["permanent_address"]}",
  //                               from: "ru",
  //                               to: "uz"))
  //                           .text;
  //                       String homeNameTr =  (await translator.translate(
  //                               homeName!,
  //                               from: "ru",
  //                               to: "uz"))
  //                           .text;
  //                       String passport_by =
  //                       (await translator.translate(
  //                               "${myidInfo?["profile"]["doc_data"]["issued_by"]}",
  //                               from: "ru",
  //                               to: "uz"))
  //                           .text;
  //                       await ZayavkaController.update2(context,
  //                           id: "${widget.appModel?["id"]}",
  //                           phoneNumber:
  //                               phoneController.text.replaceAll(" ", ""),
  //                           phoneNumber2:
  //                               phoneController2.text.replaceAll(" ", ""),
  //                           cardNumber:
  //                               shrift_cardNumber(nomerpkController.text),
  //                           passport_date: myidInfo?["profile"]["doc_data"]
  //                               ["issued_date"],
  //                           passport_by: passport_by,
  //                           address: {
  //                             "region" :regionName,
  //                             "city" : districtName,
  //                             "home" : homeNameTr
  //                           },
  //                           region_id: region_id,
  //                           );
  //                     }
  //                   },
  //                  check() ?  Colors.deepPurple :Colors.grey.shade400,
  //                   buttonWidth: MediaQuery.of(context).size.width
  //                 ),
  //                 BlocListener<UpdateApp2Bloc, UpdateApp2State>(
  //                     child: SizedBox(),
  //                     listener: (context, state) async {
  //                       if (state is UpdateApp2WaitingState) {
  //                         loadingService.showLoading(context);
  //                       } else if (state is UpdateApp2ErrorState) {
  //                         loadingService.closeLoading(context);
  //                         if (state.statusCode == 401) {
  //                           Future.wait([
  //                             CacheService.remove(
  //                               CacheService.token,
  //                             ),
  //                             CacheService.remove(
  //                               CacheService.user,
  //                             )
  //                           ]);
  //                           Flushbar(
  //                             backgroundColor: Colors.red.shade700,
  //                             dismissDirection:
  //                                 FlushbarDismissDirection.HORIZONTAL,
  //                             flushbarPosition: FlushbarPosition.TOP,
  //                             flushbarStyle: FlushbarStyle.GROUNDED,
  //                             isDismissible: true,
  //                             message: "Пожалуйста, войдите снова",
  //                             messageColor: Colors.white,
  //                             messageSize: 18.sp,
  //                             icon: Icon(
  //                               Icons.error,
  //                               size: 28.0,
  //                               color: Colors.white,
  //                             ),
  //                             duration: Duration(minutes:1),
  //                             leftBarIndicatorColor: Colors.red.shade700,
  //                           ).show(context);

  //                           Navigator.pushNamedAndRemoveUntil(
  //                             context,
  //                             RouteNames.login,
  //                             (route) => false,
  //                           );
  //                         } else {
  //                           Flushbar(
  //                             backgroundColor: Colors.red.shade700,
  //                             dismissDirection:
  //                                 FlushbarDismissDirection.HORIZONTAL,
  //                             flushbarPosition: FlushbarPosition.TOP,
  //                             flushbarStyle: FlushbarStyle.GROUNDED,
  //                             isDismissible: true,
  //                             message: state.message,
  //                             messageColor: Colors.white,
  //                             messageSize: 18.sp,
  //                             icon: Icon(
  //                               Icons.error,
  //                               size: 28.0,
  //                               color: Colors.white,
  //                             ),
  //                             duration: Duration(minutes:1),
  //                             leftBarIndicatorColor: Colors.red.shade700,
  //                           ).show(context);
  //                         }
  //                       } else if (state is UpdateApp2SuccessState) {
  //                         loadingService.closeLoading(context);
  //                         widget.appModel = state.data;
  //                         AppController.update2(context,
  //                             id: widget.appModel?["id"].toString(),
  //                             app: widget.appModel);
  //                         Navigator.pushReplacementNamed(
  //                           context,
  //                           RouteNames.SelfieWithPassportView,
  //                           arguments: {
  //                             "appModel": widget.appModel,
  //                           },
  //                         );
  //                       }
  //                     }),
  //                 SizedBox(height: 32.h),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  String heshUserNumber(String? phone) {
    if (phone == null && phone == "") {
      return "";
    } else {
      String res = "+998" +
          "(" +
          phone!.substring(4, 6) +
          ") " +
          " *** " +
          phone.substring(9);
      return res;
    }
  }

  String timerText(int count) {
    if (count == 60) {
      return "60";
    }
    return "${count % 60 < 10 ? "0${count % 60}" : "${count % 60}"}";
  }

  check() {
    return items.every((element) => element["checkFunc"]());
  }
}

String shrift_cardNumber(String card) {
  card = card.replaceAll(" ", "");
  String cardNumber = "";
  for (var i = 0; i < card.length; i++) {
    if (i < 6 || i > 11) {
      cardNumber += card[i];
    } else {
      cardNumber += "*";
    }
  }
  // print(cardNumber);
  return cardNumber;
}
