import 'package:premium_pay_new/export_files.dart';
import 'package:premium_pay_new/src/models/app_model.dart';



// ignore: must_be_immutable
class SelfieWithCheckView extends StatefulWidget {
  Map appModel;
  bool? isAvailable;
  SelfieWithCheckView({Key? key, required this.appModel,this.isAvailable =true }) : super(key: key);

  @override
  State<SelfieWithCheckView> createState() => _SelfieWithCheckViewState();
}

class _SelfieWithCheckViewState extends State<SelfieWithCheckView> {
  List<String> types = [
    'Сумма покупки:',
    'Сумма с рассрочкой:',
    'Ежемесячный платеж:',
    'Дата оплаты:',
    'Дата первого погашения:',
  ];
  List<String> costs = [
    '3,000,000 сум',
    '7,000,000 сум',
    '583.333.00 сум',
    '10 число каждого месяца',
    '10.05.2023',
  ];

  AppModel? appModel;
   File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 100);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Rasm yuklashda xatolik: $e');
    }
  }
   LoadingService loadingService = LoadingService();
  @override
  void initState() {
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
             "Селфи с распиской",
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
         body: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
                    BlocListener<UpdateApp7Bloc, UpdateApp7State>(
                   child: SizedBox(),
                   listener: (context, state) async {
                     if (state is UpdateApp7WaitingState) {
                       loadingService.showLoading(context);
                     } else if (state is UpdateApp7ErrorState) {
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
                           dismissDirection: FlushbarDismissDirection.HORIZONTAL,
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
                     } else if (state is UpdateApp7SuccessState) {
                       loadingService.closeLoading(context);
                       widget.appModel = state.data;
                       AppController.update7(context,id: widget.appModel["id"].toString(),app: widget.appModel);
                       Navigator.pushReplacementNamed(
                         context,
                         RouteNames.contractView,
                          arguments: {
                           "appModel": widget.appModel,
                         },
                       );
                     }
                   }),
       
                GestureDetector(
                 onTap: () {
                   pickImage(ImageSource.camera);
                 },
                  child: Container(
                   width: 1.sw,
                   height: 420.h,
                  
                   // padding: EdgeInsets.symmetric(horizontal: 140.w),
                   decoration: BoxDecoration(
                      color: Colors.white,
                      image:image ==null ? null : DecorationImage(image: FileImage(image!),filterQuality: FilterQuality.high,fit: BoxFit.cover)
                   ),
                   child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 140.w),
                     child:image ==null ?  SvgPicture.asset("assets/icons/image.svg",):null),
                  ),
                ),
       
                  Divider(
                           thickness: 1.h,
                           color: Color(0XFF151522).withOpacity(0.1),
                         ),
                SizedBox(
                 height: 180.h,
               ),
              
               GestureDetector(
                   onTap: () async{
                 if (image!=null) {
                      await ZayavkaController.update7(
                   context,
                   id: "${widget.appModel["id"]}",
                   selfie:image!.path 
                   // Base64Service().filetoBase64(image!.path)
         
                 );
                      
                  }
                 },
                 child: Container(
                   width: 327.w,
                   height: 50.h,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                       color:image ==null ? Colors.grey.shade400 : const Color(0xffBE52F2),
                       borderRadius: BorderRadius.circular(8.r),
                       boxShadow:image ==null ? null : [
                         BoxShadow(
                           color: const Color(0xff323247).withOpacity(0.3),
                           offset: Offset(0, 4.h),
                           blurRadius: 4.r,
                           // blurStyle: BlurStyle.outer
                         ),
                       ]),
                   child: Text(
                     "Подтвердить",
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
         ),
       ),
     );
  
  }
}
