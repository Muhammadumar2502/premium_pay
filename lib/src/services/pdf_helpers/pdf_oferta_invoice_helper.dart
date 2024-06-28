import 'dart:io';


import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:premium_pay_new/src/models/pdf/customer_info.dart';
import 'package:premium_pay_new/src/models/pdf/invoice.dart';
import 'package:premium_pay_new/src/services/pdf_helpers/pdf_helper.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfOfertaInvoicePdfHelper {
  static Future<File> generate(Invoice invoice,{required String fileName,required Map appModel}) async {
    final pdf = Document(version: PdfVersion.pdf_1_5);
    
    final ttfData =await rootBundle.load("assets/fonts/uzbek/NotoSans_Condensed-Bold.ttf");
    final uzbekFont = pw.Font.ttf(ttfData);

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const EdgeInsets.all(40.0),
        build: (context) => [
          buildHeader(invoice,appModel,uzbekFont),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          buildConditions(),
        ],
      ),
    );
    // var font = await rootBundle.load("assets/GenYoMinTW-Heavy.ttf");
    // PDFTTFFont ttf = new PDFTTFFont(pdf, font);

    return await PdfHelper.saveDocument(name: fileName, pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice,Map appModel,uzbekFont) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 0.2 * PdfPageFormat.cm),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              invoice.customer!.shartnomaDate!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 8.0,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
   
            "N: PPD-"
            
            +  appModel["id"].toString() + " ONLAYN ELEKTRON OFERTA" ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 8.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox()
          ],
        ),
       
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        buildCustomerContract(invoice.customer!,uzbekFont),
      ],
    );
  }

  static Widget buildCustomerContract(Customer customer,uzbekFont) => RichText(
        text: TextSpan(
          text: '       MCHJ "BREND TO`LOV"ga tegishli "PREMIUM PAY" tizimi - ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
          children: <TextSpan>[
            TextSpan(
              text:
                  "loyihasi asosida Tijorat banklari tomonidan muomalaga chiqarilgan bank kartasining egasi bo'lgan hamda quyida taklif qilinayotgan shartlarni to'laligicha va sozsiz qabul qilishini elektron shaklda akseptlash (rozilik bildirish) orqali bildirgan jismoniy shaxs ",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(text: "${customer.name}, "),
            TextSpan(
              text: '(pasport: ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(text: "${customer.passportSeria} "),
            TextSpan(
              text: 'No ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(text: "${customer.passportNumber} "),
            TextSpan(
              text: '${customer.givenWhen} da ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
             TextSpan(text:customer.givenByWhom.toString()  ),
            TextSpan(
              text: ' tomonidan berilgan), ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(text: "${customer.address} ",style: pw.TextStyle(font: uzbekFont,fontWeight: FontWeight.bold)),
            
              TextSpan(
              text: " da yashovchi,mijozning telefon raqami: ",
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            TextSpan(
              text: "${customer.phoneNumber}, ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: "${customer.phoneNumber2} "),
            TextSpan(
              text:
                  "(keyingi o'rinlarda - Qarzdor/mijoz), ikkinchi tomondan, shu bo'yicha Onlayn Elektron ofertani tuzdik.",
              style: TextStyle(fontWeight: FontWeight.normal),
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
              fontSize: 8.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: '       1. ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Mazkur Elektron ofertada quyidagi tushunchalar ishlatiladi:",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       "BREND TOLOV" ma'suliyati cheklangan jamiyati """,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "(keying o'rinlarda - hamkor tashkilot) - o'zining va/yoki hamkorining savdo shoxobchalaridan tovarni ",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'onlayn-qarz',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      "ga sotish yuzasidan Bank bilan hamkorlik qilayotgan yuridik shaxs;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       PREMIUM PAY tizimi """,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "- Hamkor tashkilotning Bank axborot resurslariga integratsiyalangan maxsus dasturiy mahsuloti bo'lib, u Qarzdor/mijoz tomonidan hamkor tashkilot va/yoki uning hamkorlarining savdo shoxobchalaridan tovarni ",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'onlayn-qarz',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "ga sotib olishga xizmat qiladi;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       onlayn-qarz - PREMIUM PAY """,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "tizimi orqali hamkor tashkilot va/yoki uning hamkorining savdo shoxobchalaridan xarid qilingan tovar uchun bo'lib to'lash sharti bilan muddatlilik, qaytarishlilik va ta'minlanganlik asosida Bank tomonidan Qarzdorga/mijozga, qarz berilganligi uchun ",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'foiz va penya ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "undirilmagan holda, ajratilgan pul mablag'i;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       Qarzdor/mijoz - onlayn-qarzga """,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "hamkor tashkilot va/yoki uning hamkori savdo shoxobchasidan tovar sotib oluvchi, O'zbekiston Respublikasi qonun hujjatlarida belgilangan tartibda raqamli identifikatsiyadan (raqamli autentifikatsiyadan) o'tgan, tijorat banklarining biri tomonidan ish haqi loyihasi asosida muomalaga chiqarilgan bank kartasiga egalik qiluvchi O'zbekiston Respublikasi rezidenti bo'lgan jismoniy shaxs; ",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'foiz va penya ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "undirilmagan holda, ajratilgan pul mablag'i;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "SHARTLAR VA TA'RIFLAR:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       Tovar""",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      " - O'zbekiston Respublikasi qonun hujjatlariga muvofiq chakana savdoga chiqarilishi taqiqlanmagan mahalliy yoki import mahsulot;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       elektron oferta - PREMIUM PAY""",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      " tizimi orqali onlayn-qarz ajratish to'g'risida Bank va Qarzdor/mijoz o'rtasida tuziladigan elektron bitim;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       qarz beruvchilar""",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      " - tijorat banklari faoliyatini amalga oshiruvchi to'lov tashkiloti;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       o'rtacha oylik daromad miqdori """,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Qarzdorning/mijozning ish haqi loyihasi asosida muomalaga chiqarilgan bank kartasi orqali [",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'elektron oferta ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      "akseptlangan sanaga nisbatan so'nggi 12 oy (agar 12 oydan kam ishlagan bo'lsa, 6 oydan kam bo'lmagan haqiqatda ishlagan davri) davomida] olgan daromadining o'rtacha arifmetik qiymati. Bunda Qarzdor/mijoz so'nggi 2 oy davomida daromadga ega bo'lishi lozim;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       Skoring""",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      " - Bank tomonidan elektron axborot resurslari bazalaridan O'zbekiston Respublikasi qonun hujjatlarida belgilangan tartibda olingan ma'lumotlarga asoslangan holda Qazdorning/mijozning tolovga layoqatliligini aniqlash dasturi;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "Qarzdorning/mijozning tolovga layoqatliligini aniqlash dasturi;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       shaxsni tasdiqlovchi hujjat""",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      " - O'zbekiston Respublikasi fuqarosining pasporti yoki ID-kartasi.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: '       2. ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Elektron ofertaga asosan Bank tomonidan o'tkazilgan pul mablag'i Qarzdorga/mijozga onlayn-qarz sifatida rasmiylashtiriladi.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Center(
          child: Text(
            "2-§. Onlayn-qarz ofertasi shartlari",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: '       3. ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Onlayn-qarz, Qarzdor/mijoz xohishidan va/yoki to'lov qobilyatidan kelib chiqqan holda, 3 (uch), 6 (olti), 9 (to`qqiz) va 12 (o`ng ikki) oylari muddatlarida ajratiladi.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: '       4. ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Onlayn-qarz limitining maksimal miqdori 35 000 000 (o`ttiz besh million) so'mdan oshmaydi, minimal miqdori 500 000 (besh yuz ming) so'mni tashkil etadi.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: '       5. ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Onlayn-qarz ta'minoti sifatida onlayn-qarzning qaytarilmaslik tavakkalchiligi bo'yicha elektron sug'urta polisi rasmiylashtiriladi. Sugurtani rasmiylashtirish xarajati tijorat banklari tizimi hisobidan amalga oshiriladi.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: '       6. ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Onlayn-qarz Qarzdorga/mijozga skoring tizimi orqali ajratiladi.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: '       7. Skoringni ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "- amalga oshirish jarayonida quyidagi holatlardan biri mavjud bo'lganda Qarzdorga/mijozga onlayn-qarz ajratilmaydi:",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       a) ilgari olingan kredit va boshqa majburiyatlari bo'yicha muddati o'tgan qarzdorlik mavjud bo'lganda;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       b) ilgari olingan kredit va boshqa majburiyatlari bo'yicha onlayn-qarz olish uchun ariza berilgan sanadan boshlab oxirgi 1 (bir) yil davomida 3 va undan ko'p marta 30 kundan ortiq to'lovning kechikish holatlari mavjud bo'lsa;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       d) ilgari olingan kredit va boshqa majburiyatlari bo'yicha onlayn-qarz olish uchun ariza berilgan sanadan boshlab oxirgi 1 (bir) yil davomida 1 va undan ko'p marta 90 kundan ortiq to'lovning kechikish holatlari mavjud bo'lsa;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          """       e) "Soliq-servis" davlat unitar korxonasi bazasidagi Qarzdor/mijoz daromadi 6 oydan kam bo'lganda;""",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          """       f) "Soliq-servis" davlat unitar korxonasi bazasida onlayn-qarz so'rab murojaat qilingan oydan oldingi 2 oyda Qarzdorning/mijozning daromadiga oid ma'lumot mavjud bo'lmasa;""",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       g) Qarzdor/mijoz yoshi 21 dan 55 gacha bo'lgan yosh diapazoniga tushmaganda;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       h) olinayotgan onlayn-qarz qiymatini ham qo'shib hisoblaganda qarz yuki ko'rsatkichi 50 foizdan oshgan taqdirda.",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       8. """,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text: "Qarzdor/mijoz onlayn-qarzning ",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'Tasdiqlangan limiti, ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      "uning qancha qismini ishlatishidan qa`tiy nazar, bir marta foydalanilgandan so'ng o'z kuchini yo'qotgan deb hisoblanadi;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: """       9. """,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text: "Foydalanilgan ",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'onlayn-qarz ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      "uchun Qarzdordan/mijozdan foiz yoki foizsiz shaklida to'lov undirilmaydi.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       10. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Onlayn-qarz Qarzdor/mijoz tomonidan onlayn-qarzni qaytarish jadvaliga muvofiq qaytariladi. ",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Center(
          child: Text(
            "3-§. Tomonlarning huquq va majburiyatlari",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       11. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text: "Bankning huquqlari:",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       a) onlayn-qarz bo'yicha to'lov muddati kelganda, qarzdorlikni Qarzdorning/mijozning bank kartasi hisobvarag'idan akseptsiz undirish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text:
                  """       b) onlayn-qarz belgilangan muddatda qaytarilmaganda, qarzdorlikni Qarzdorning/mijozning Bankdagi va boshqa rezident banklaridagi hisobvaraqlaridan yani """,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text: """ "Uzcard va Humo va boshqa turdagi kartalaridan" """,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "akseptsiz undiriladi;",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       d) onlayn-qarzni to'lash muddati buzilganda nizoni hal qilish yuzasidan talabnomani Qarzdorga/mijozga ma'lum qilish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text:
                  """       e) onlayn-qarzning uni qaytarish jadvali bo'yicha o'z muddatida to'lanmasligi tufayli""",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text: """ "SUG'URTA" """,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      "odisasi sodir bo'lganda, onlayn-qarzni undirish huquqini",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: """ "SUG'URTA" """,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "tashkilotiga o'tkazish.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       12. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text: "Bankning majburiyatlari:",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       a) onlayn-qarzni ushbu Elektron ofertada belgilangan shartlarda berish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       b) onlayn-qarzni muddatidan oldin undirish sabablari haqida Qarzdorni/mijozni xabardor etish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       d) Qarzdordan/mijozdan onlayn-qarzning joriy to'lovi uchun onlayn-qarzni qaytarish jadvalida belgilanganga nisbatan ko'p mablag' kelib tushsa, u holda kelib tushgan mablag'ning ortiqcha qismini keyingi oy bo'yicha qarzdorlikni so'ndirishga yo'naltirish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       e) onlayn-qarz bo'yicha muddati o'tkazib yuborilgan qarzdorlik yuzaga kelganda Qarzdor/mijoz zimmasidagi qarz yuki yanada oshib ketishining oldini olish maqsadida ushbu qarzdorlik yuzaga kelgan sanadan boshlab 7 kalendar kuni davomida har qanday aloqa bog'lash usulidan, shu jumladan elektron aloqa vositasidan foydalanib, Qarzdorga/mijozga muddati o'tkazib yuborilgan qarzdorlik yuzaga kelganligi haqida onlayn-qarzni qaytarish jadvalini ilova qilgan holda xabar berish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       f) Qarzdorni/mijozni ushbu Elektron oferta bo'yicha muddati o'tkazib yuborilgan qarzdorlikni qaytarish majburiyati bajarilmaganligi holati, muddati, qiymati, tarkibi va oqibatlari haqida xabardor qilish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       g) Qarzdordan/mijozdan muddati o'tkazib yuborilgan qarzdorlik yuzaga kelishi sabablari haqida so'rash;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       h) Qarzdor/mijoz tomonidan ushbu Elektron oferta bo'yicha onlayn-qarzni qaytarish muddati buzilganda nizoni hal qilish yuzasidan o'z talabnomasini Qarzdorga/mijozga yetkazish (ushbu talabnomada u tuzilgan sanadagi Qarzdorning/mijozning joriy qarzi miqdori va tarkibi, qarzni to'lash usullari, talabnomada ko'rsatilgan muddatgacha Qarzdor/mijoz o'z majburiyatlarini bajarmasligi oqibatlari va nizoni hal qilish usullari qayd etiladi);",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "       i) Qarzdor/mijoz tomonidan onlayn-qarz bo'yicha qarzdorlik to'liq to'langanidan so'ng, qarzdorning/mijozning shaxsiy kabinetida onlayn-qarz bo'yicha qarzdorlik to'liq so'ndirilganligi to'g'risida ma'lumotni avtomat tarzda shakllantirish.",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       13. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text: "Qarzdorning/mijozning huquqlari:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "      a) ushbu Elektron ofertani akseptlash bo'yicha mustaqil qaror qabul qilish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "      b) onlayn-qarzning o'z vaqtida ajratilishini talab qilish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "      d) onlayn-qarzni istalgan vaqtda muddatidan oldin to'liq to'lagan holda ushbu Elektron ofertani muddatidan oldin bekor qilish.",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       14. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text: "Qarzdorning/mijozning majburiyatlari:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "      a) onlayn-qarzni o'z vaqtida qaytarish;",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        Text(
          "      b) ish haqi loyihasi asosida bank kartasi berilgan korxonadan (tashkilotdan, muassasadan) ishdan bo'shayotganda onlayn-qarzni muddatidan oldin qaytarish.",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
              text: '       15. Bank - ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Qarzdor/mijoz tomonidan onlayn-qarz hisobiga xarid qilingan tovarlar miqdori, sifati, yetkazib berish tartibi va shakli, ularni butligi yuzasidan javobgar bo'lmaydi.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Center(
          child: Text(
            "4-§. Tomonlarning javobgarligi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       16. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Tomonlar ushbu Elektron oferta majburiyatlarini bajarmagan yoki lozim darajada bajarmagan taqdirda, ularga nisbatan O'zbekiston Respublikasining qonun hujjatlarida belgilangan tartibda javobgarlik choralari qo'llaniladi.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Center(
          child: Text(
            "5-§. Fors-major holatlar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       17. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    """ Tomonlar fors-major holatlar amal qilgan davrda Elektron oferta bo'yicha o'z majburiyatlarining qisman yoki to'liq bajarilmaganligi uchun javob bermaydilar.
        Fors-major holatlarga quyidagilar kiradi: tabiiy hodisalar (zilzila, ko'chki, dovul, qurg'oqchilik va boshqa tabiiy ofat hodisalar) yoki ijtimoiy-iqtisodiy vaziyatlar (iqtisodiy sanksiyalar, harbiy harakatlar, ish tashlashlar, qamallar, davlat tashkilotlarining hamda davlat tashkilotlari o'rtasidagi cheklovchi va taqiqlovchi choralar, Hukumat qarorlari va boshqalar) oqibatida kelib chiqqan favqulodda, joriy sharoitda bartaraf etib bo'lmaydigan va oldindan kutilmagan vaziyatlar, agar ushbu vaziyatlar Elektron ofertani bajarishga bevosita ta'sir ko'rsatgan bo'lsa.
        Fors-major holatlar yuzaga kelganda va to'xtaganda tomonlar bir-birini darhol xabardor qiladilar. Xabarnoma tomonlarda mavjud bo'lgan barcha aloqa vositalari orqali yuboriladi.
        Fors-major holatlar yuzaga kelgan taqdirda majburiyatlarni bajarish muddatini tomonlar fors-major holatlar amal qilgan davrga mutanosib tarzda kechiktiradi. """,
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Center(
          child: Text(
            "6-§. Nizolarni hal qilish",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       18. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Bank va Qarzdor/mijoz, taraflarning o'zaro roziligiga ko'ra, qonun hujjatlarida belgilangan nizoni hal qilish usullarini qo'llashga, shu jumladan muzokara o'tkazish orqali hal qilishga haqli hisoblanadi.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       19. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    """Qarzdor/mijoz nizoni hal qilish yuzasidan ushbu Elektron oferta 14-bandining "h" kichik bandida qayd etilgan talabnomada ko'rsatilgan talablar bajarilmaganligi oqibatida qarzdorlik""",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              TextSpan(
                text: """ "SUG'URTA" """,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'tashkiloti tomonidan qoplab berilganda onlayn-qarzni undirish huquqini',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              TextSpan(
                text: """ "SUG'URTA" """,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: "tashkilotiga o'tkazadi.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Center(
          child: Text(
            "7-§. Elektron ofertaning boshqa shartlari",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       20. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Qarzdor/mijoz Elektron ofertani akseptlash bilan o'z shaxsiga doir ma'lumotlarga ishlov berish rozilik bildirgan hisoblanadi.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       21. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Bank Qarzdor/mijoz uchun ushbu Elektron oferta bo'yicha onlayn-qarzni to'lashning masofadan turib amalga oshirish imkoniyatini yaratadi.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       22. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Bank onlayn-qarz shartlarini, shu jumladan mazkur Elektron ofertaning amal qilish muddatini bir tomonlama o'zgartirishga haqli emas.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       23. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Qarzdor/mijoz vafot etganda uning huquq va majburiyatlari O'zbekiston Respublikasi qonun hujjatlariga muvofiq hal etiladi.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       24. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Mazkur Elektron oferta u online tasdiqlangan kundan boshlab to Qarzdor/mijoz tomonidan ushbu Elektron oferta majburiyatlari to'liq bajarilgunga qadar amal qiladi.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       25. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Ushbu Elektron ofertaning bekor qilinishi tomonlarni u bekor qilingunga qadar bildirilgan o'zaro da'vosini (talabini) qondirish majburiyatidan ozod qilmaydi.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.05 * PdfPageFormat.cm),
        RichText(
          text: TextSpan(
            text: """       26. """,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            children: <TextSpan>[
              TextSpan(
                text:
                    "Mazkur Elektron ofertada ko'zda tutilmagan holatlar yuzasidan O'zbekiston Respublikasi qonun hujjatlari qo'llaniladi.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
