import 'package:premium_pay_new/src/core/extensions/date_extension.dart';
import 'package:premium_pay_new/export_files.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key, required this.apps}) : super(key: key);
  final apps;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<String> status = [
    'Завершен',
    'Скоринг',
    'Отказано',
  ];
  List<Color> color = [
    const Color(0xFF1BDA17),
    const Color(0xFFECA400),
    const Color(0xFFDA2222),
  ];
  List? apps = [];
  @override
  void initState() {
    super.initState();
    apps = widget.apps;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawerEnableOpenDragGesture: false,
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
            "Поиск",
            style: TextStyle(
              color: Color(0XFF242424),
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
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
        ),
        body:
          
                          widget.apps.isEmpty ? Center(
                            child: 
                            SizedBox(
                              height: 200.h,
                              child: Text("Нет данных",style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700
                              ),),
                            ),
                          ):
                          
               
        
        
         Container(
          width: 1.sw,
          height: 1.sh,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 12.h,
              bottom: 32.h,
            ),
            children: [
              SizedBox(height: 8.h),
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
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      apps = (widget.apps as List).where((element) {
                        return element["fullname"]
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase());
                      }).toList();
                      setState(() {});
                    } else {
                      apps = widget.apps;
                    }
                  },
                  style: TextStyle(
                      fontSize: 15.sp, fontWeight: FontWeight.w300, height: 1),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                    isDense: true,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Transform.scale(
                      scale: 0.5,
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                        // ignore: deprecated_member_use
                        color: Color(0xff4F4F4F),
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xffC0C0C0),
                    ),
                    hintText: "Поиск",
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              if (widget.apps.isEmpty)
                SizedBox(
                  height: 480.h,
                  child: Center(
                    child: Text(
                      "Нет заявка",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppConstant.primaryColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              apps!.isEmpty && widget.apps.isNotEmpty
                  ? SizedBox(
                      height: 480.h,
                      child: Center(
                        child: Text(
                          "Заявка не найдена",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppConstant.primaryColor,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        universalList(apps).length,
                        (j) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                // horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              child: Row(
                                children: [
                                  // SizedBox(height: 24.h),
                                  Text(
                                    DateTime.parse((universalList(apps)[j][0]
                                                ["created_time"] ??
                                            universalList(apps)[j][0]
                                                ["finished_time"]))
                                        .textInString
                                        .capitalize(),
                                    style: TextStyle(
                                      color: const Color(0xFF242424),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                // decoration: BoxDecoration(
                                //   color: Colors.white,
                                //   borderRadius: BorderRadius.circular(6.r),
                                //   border: Border.all(
                                //     width: 1.sp,
                                //     color: const Color(0xffE8E8E8),
                                //   ),
                                // ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: List.generate(
                                          universalList(apps)[j].length,
                                          (index) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomTile(
                                                app: universalList(apps)[j]
                                                    [index],
                                                status: status[index % 3],
                                                fullname: "Шомансуров Бекзод",
                                                finished_time: "16:53",
                                                avatar:
                                                    "assets/icons/person.svg",
                                              ),
                                              Divider(
                                                color: Color(0xFFE4E4E4)
                                                    .withOpacity(0.5),
                                                thickness: 1,
                                              ),
                                            ],
                                          ),
                                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
