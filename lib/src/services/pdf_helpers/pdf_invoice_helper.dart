// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:premium_pay_new/src/models/pdf/customer_info.dart';
import 'package:premium_pay_new/src/models/pdf/invoice.dart';
import 'package:premium_pay_new/src/services/pdf_helpers/pdf_helper.dart';

class PdfInvoicePdfHelper {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    final ttfData =await rootBundle.load("assets/fonts/uzbek/NotoSans_Condensed-Bold.ttf");
    final uzbekFont = pw.Font.ttf(ttfData);

    final List<String> conditions = [
      "Xaridor shu bilan «BREND TO'lOV» MChJdan foydalanishning umumiy qoidalari va shuningdek, tovarlarni muddatli to'lov asosida sotib olish va sotish shartlari bilan tanishganligini tasdiqlaydi va ularni so'zsiz qabul qiladi.",
      "Xaridor shu bilan Sotuvchining do'konidagi umumiy shartlar va Xaridorning arizasiga, shuningdek quyidagi to'lovlar jadvaliga muvofiq sotib olingan tovar(lar)ga haq to'lashni tasdiqlaydi va o'z zimmasiga oladi:",
      "Tovar shartnomaga asosan Sotuvchi tomonidan Xaridorga to'liq va sifatli yetkazib berildi.",
      "Umumiy Shartlarning qoidalariga muvofiq, Tovarning to'liq qiymati to'langunga qadar Tovar Shartnoma bo'yicha garov predmeti hisoblanadi.",
      "Muddatidan oldin to'lash muddatli to'lovnining umumiy miqdoriga ta'sir qilmaydi, ya'ni bunda muddatli to'lov asosida sotilgan tovarlarning narxi o'zgarmaydi.",
      "Xaridor o'zining shaxsiy ma'lumotlarini va ushbu Shartnomaning ma'lumotlarni uchinchi shaxslarga o'tkazishga yoki almashishga to'liq rozilik bildiradi.",
      """Ushbu dalolatnomada keltirilgan jadval asosida ko'rsatilgan to'lovlarni to'lamagan yoki 30 kundan ko'p muddatga kechiktirgan taqdirda, Xaridor jadvalda ko'rsatilgan to'lovlarni barchasini ushbu muddatga ko'chirgan holda (shartnoma bo'yicha barcha qarzdorlikni to'lash majburiyati) o'zini qora ro'yxatga yoki to'lamaydiganlar ro'yxatiga qo'shishga rozilik beradi va bu ro'yxat keng ommaga oshkor etiladi.""",
      "Umumiy shartlar va ushbu Shartnoma Xaridor tushunadigan tilda yozilgan.",
      "Ushbu Shartnoma 2 (ikki) nusxada tuzilgan bo'lib, ulardan biri Sotuvchiga, ikkinchisi Xaridorga tegishli.",
    ];

    // final image1Jpg =
    //     (await rootBundle.load('assets/oferta_img1.jpg')).buffer.asUint8List();
    // final image2Jpg =
    //     (await rootBundle.load('assets/oferta_img2.jpg')).buffer.asUint8List();
    // final image3Jpg =
    //     (await rootBundle.load('assets/oferta_img3.jpg')).buffer.asUint8List();
    final logoPng =
        (await rootBundle.load('assets/logo_2.png')).buffer.asUint8List();
    final davrbankPng =
        (await rootBundle.load('assets/davrbank.png')).buffer.asUint8List();

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const EdgeInsets.all(40.0),
        build: (context) => [
          buildHeader(invoice, logoPng, davrbankPng,uzbekFont),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          buildInvoice(invoice,uzbekFont),
          // Divider(),
          buildTotal(invoice),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          buildConditions(conditions, invoice),

        ],
        // footer: (context) => buildFooter(invoice),
      ),
    );

    // pdf.addPage(
    //   MultiPage(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (context) => [
    //       Image(
    //         MemoryImage(image1Jpg),
    //       ),
    //       Image(
    //         MemoryImage(image2Jpg),
    //       ),
    //       Image(
    //         MemoryImage(image3Jpg),
    //       ),
    //     ],
    //   ),
    // );

    // pdf.addPage(
    //   pw.Page(
    //     build: (pw.Context context) => pw.Center(
    //       child: pw.Text('Hello World!'),
    //     ),
    //   ),
    // );

    return await PdfHelper.saveDocument(name: 'premiumpay.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice, var logoPng, var davrbankPng,uzbekFont) {
    // var now = invoice.info.date;
    // var nextYear = DateTime(now.year, now.month + invoice., 2);

    var formatter = DateFormat(
      'dd-MM-yyyy',
    );
    String formattedDate = formatter.format(invoice.info!.dueDate,);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  MemoryImage(
                    logoPng,
                  ),
                  width: 60.0,
                ),
                SizedBox(width: 10.0),
                Image(
                  MemoryImage(davrbankPng),
                  width: 80.0,
                ),
              ],
            ),
            Text(
              "$formattedDate gacha bo'lib to'lash haqida shartnoma",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 8.0,
              ),
            ),
          ],
        ),
        Divider(thickness: 0.7),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        buildShartnoma(invoice.info!),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        buildCustomerContract(invoice.customer!,uzbekFont),
      ],
    );
  }

  static Widget buildCustomerContract(Customer customer,uzbekFont) => RichText(
        text: TextSpan(
          text: '«BREND TO\'LOV» MChJ, ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
          children: <TextSpan>[
            TextSpan(
              text:
                  'bundan keyin "Sotuvchi" deb nomlanadigan, tegishli ishonchnoma asosida harakatlanuvchi vakili ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(text: "${customer.storeName.replaceAll("ʻ", "'")} "),
            TextSpan(
              text: 'va Fuqaro ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(text: "${customer.name} ,".replaceAll("ʻ", "'")),
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
            TextSpan(text: '${customer.givenByWhom.replaceAll("ʻ", "'")} '),
            TextSpan(
              text: 'tomonidan berilgan), ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(text: "${customer.address.replaceAll("ʻ", "'")} ",style: pw.TextStyle(font: uzbekFont,fontWeight: FontWeight.bold)),
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
                  """bundan keyin "Xaridor" deb nomlanuvchi, Xaridorning so'rovi asosida Sotuvchi yetkazib berganligi va Xaridor Tovarni quyidagi spetsifikatsiyaga muvofiq olganligi to'g'risida ushbu shartnomani tuzdilar:""",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      );

  static Widget buildShartnoma(InvoiceInfo invoiceInfo) {
    var now = invoiceInfo.date;
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Xaridorning ${invoiceInfo.number}-sonli arizasi va $formattedDate dagi to'lov jadvali asosida tovarlarni qabul qilish va topshirish bo'yicha SHARTNOMA",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  static Widget buildInvoice(Invoice invoice,Font uzbekFont) {
    final headers = [
      'Mahsulot nomi',
      'Miqdori',
      'Hujjatlar, qadoqlash',
      'Donasining narxi, so\'m',
    ];

    final data = invoice.items!.map((item) {
      // final formattedCost = intl.NumberFormat.currency(locale: 'uz', symbol: '')
      //     .format(int.parse(item.cost.replaceAll(" ", "")));
      return [
        item.name.replaceAll("ʻ", "'"),
        item.quantity,
        item.packaging,
        item.cost,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: TableBorder.all(),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0,font: uzbekFont),
      headerDecoration: const BoxDecoration(color: PdfColors.deepPurple100),
      cellStyle: const TextStyle(fontSize: 8.0),
      cellHeight: 8,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final headers = [
      'QQS bilan jami summa, so\'m',
      "To'lovni hisobga olgan holda umumiy qiymati, so'm",
    ];
    final data = invoice.total!.map((item) {

      return [
        item.cost.substring(0, item.cost.length - 1),
        item.totalCost.substring(0, item.totalCost.length - 1),
      ];
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.0),
        Text(
          "Sertifikatda ko'rsatilgan tovar siz sotib olayotgan tovarga mosligini aniq tekshirib oling.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 8.0,
          ),
        ),
        SizedBox(height: 5.0),
        Align(
          alignment: Alignment.centerRight,
          child: Table.fromTextArray(
            tableWidth: TableWidth.min,
            headers: headers,
            data: data,
            border: TableBorder.all(),
            headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
            headerDecoration:
                const BoxDecoration(color: PdfColors.deepPurple100),
            cellStyle: const TextStyle(fontSize: 8.0),
            cellHeight: 8,
            cellAlignments: {
              0: Alignment.center,
              1: Alignment.center,
            },
          ),
        ),
      ],
    );
  }

  static Widget buildConditions(List conditions, Invoice invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        conditions.length,
        (index) {
          return index != 1
              ? Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  '${index + 1}. ' + conditions[index],
                  style: TextStyle(
                    fontSize: 8.0,
                    // fontWeight: FontWeight.normal,
                    fontWeight:
                        index == 6 ? FontWeight.bold : FontWeight.normal,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      '${index + 1}. ' + conditions[index],
                      style: TextStyle(
                        fontSize: 8.0,
                        // fontWeight: FontWeight.normal,
                        fontWeight:
                            index == 6 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "To'lovni to'lash grafiki",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    buildGraph(invoice),
                    SizedBox(height: 5.0),
                  ],
                );
        },
      ),
    );
  }

  static Widget buildGraph(Invoice invoice) {
    final headers1 = [
      "Umumiy summa miqdori, so'm",
      "Oylik to'lovi, so'm",
      "To'lov muddati (oy)",
      "Berilgan sana"
    ];
    final data1 = invoice.invoiceGraphHeader!.map((item) {
      var now = item.date;
      var formatter = DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);
      final formattedCost = intl.NumberFormat.currency(locale: 'uz', symbol: '')
          .format(item.price);

      final formattedMonthCost =
          intl.NumberFormat.currency(locale: 'uz', symbol: '')
              .format(item.price / item.period);
      return [formattedCost, formattedMonthCost, item.period, formattedDate];
    }).toList();

    final headers = [
      'Tartib raqami',
      'Oy, yil',
      'To\'lov sanasi',
      "Oylik to'lovi, so'm",
      "To'lov qoldig'i, so'm",
    ];
    final data = invoice.invoiceGraph!.map((item) {
      
      var finished_time = DateTime(item.date.year, item.date.month  + item.number -1 , item.date.day); 
      var formatter = DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(finished_time);
      print(formattedDate);
      
      final formattedCost = intl.NumberFormat.currency(locale: 'uz', symbol: '')
          .format(item.price - item.price / item.period * item.number);
      final formattedMonthCost =
          intl.NumberFormat.currency(locale: 'uz', symbol: '')
              .format(item.price / item.period);
      return [
        item.number,
        "${item.number}-oy 1-yil",
        formattedDate,
        formattedMonthCost,
        formattedCost,
      ];
    }).toList();

    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Table.fromTextArray(
          tableWidth: TableWidth.max,
          headers: headers1,
          data: data1,
          border: TableBorder.all(),
          headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
          headerDecoration: const BoxDecoration(color: PdfColors.deepPurple100),
          cellStyle: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold),
          cellHeight: 8,
          cellAlignments: {
            0: Alignment.center,
            1: Alignment.center,
            2: Alignment.center,
            3: Alignment.center,
          },
        ),
      ),
      SizedBox(height: 10.0),
      Table.fromTextArray(
        headers: headers,
        data: data,
        border: TableBorder.all(),
        headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0),
        headerDecoration: const BoxDecoration(color: PdfColors.deepPurple100),
        cellStyle: const TextStyle(fontSize: 8.0),
        cellHeight: 8,
        cellAlignments: {
          0: Alignment.center,
          1: Alignment.center,
          2: Alignment.center,
          3: Alignment.center,
          4: Alignment.center,
        },
      ),
    ]);
  }

  static Widget buildFooter(Invoice invoice) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSimpleText(
            title: 'Topshirdi:',
            value: invoice.supplier!.name!.replaceAll("ʻ", "'"),
          ),
          buildSimpleText(
            title: 'Qabul qildi:',
            value: invoice.customer!.name.replaceAll("ʻ", "'"),
          ),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Expanded(
            child: Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0))),
        Text(value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0)),
      ],
    );
  }
}
