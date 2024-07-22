import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_ticket_card/movie_ticket_card.dart';
import 'package:tester/utils/config.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SuccessBooking extends StatefulWidget {
  const SuccessBooking({super.key});

  @override
  State<SuccessBooking> createState() => _SuccessBookingState();
}

class _SuccessBookingState extends State<SuccessBooking> {
  late Map<String, dynamic> data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (ModalRoute.of(context) != null) {
      data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    }
  }

  @override
  Widget build(BuildContext context) {
    String currency(dynamic value) {
      final NumberFormat currencyFormat = NumberFormat.currency(
          locale: 'id-ID', symbol: 'IDR ', decimalDigits: 0);
      String formattedValue = currencyFormat.format(value);
      formattedValue = formattedValue.replaceAll('.', ',');
      return formattedValue;
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.indigo[800]!,
          Colors.blue[700]!,
          Colors.lightBlue[700]!,
          Colors.cyan[700]!,
          Colors.cyan[200]!,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.fromLTRB(15, 15, 13, 20),
          child: TicketCard(
            decoration: TicketDecoration(
                border: TicketBorder(
                    color: const Color.fromARGB(0, 0, 0, 0),
                    width: 0.1,
                    style: TicketBorderStyle.none)),
            lineFromTop: 320,
            child: Card(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Config.spaceBig,
                  Expanded(
                      flex: 2,
                      child:
                          Lottie.asset('assets/success.json', repeat: false)),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Successfully Booked!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (currency(data['total_price'])),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Config.spaceSmall,
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        DottedBorder(
                          color: Colors.grey,
                          dashPattern: const [8, 10],
                          customPath: (size) {
                            return Path()
                              ..moveTo(0, size.height)
                              ..lineTo(size.width, size.height);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Config.spaceSmall,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Booking Number",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "${data['booking_number']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Hotel",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "${data['hotel']['name']}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Rooms",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "${data['room_type']['name']}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Check-in Date ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    formatDate(data['booking_date']),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Check-out Date ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "${formatDate(data['end_date'])}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Config.spaceSmall,
                            ],
                          ),
                        ),
                        DottedBorder(
                            dashPattern: const [8, 10],
                            customPath: (size) {
                              return Path()
                                ..moveTo(0, size.height)
                                ..lineTo(size.width, size.height);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Amount",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "${currency(data['total_price'])}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    )
                                  ]),
                            ))
                      ],
                    ),
                  ),
                  Config.spaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 45,
                          width: Config.widthSize * 0.75,
                          child: ElevatedButton(
                              onPressed: () async {
                                await _printAsPdf();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: Colors.black38)),
                                  backgroundColor: Colors.grey[50],
                                  foregroundColor: Colors.black),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_download_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Print as PDF"),
                                ],
                              )))
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 25),
                    child: SizedBox(
                        width: Config.widthSize * 0.65,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('main');
                          },
                          child: const Text(
                            "Back to Home Page",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  DateTime parseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
    }
  }

  String formatDate(String date) {
    final DateTime dateTime = parseDate(date);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  Future<void> _printAsPdf() async {
    try {
      final pdf = pw.Document();
      final NumberFormat currency =
          NumberFormat.currency(locale: 'id-ID', symbol: 'IDR ');

      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text('Booking Invoice',
              style:
                  pw.TextStyle(fontSize: 26, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 35),
          pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: const <int, pw.TableColumnWidth>{
              0: pw.IntrinsicColumnWidth(),
              1: pw.IntrinsicColumnWidth(),
            },
            children: [
              pw.TableRow(children: [
                pw.Container(
                    color: PdfColor.fromHex("#464545"),
                    child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: pw.Text("Information",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex("#fff"))))),
                pw.Container(
                    color: PdfColor.fromHex("#464545"),
                    child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: pw.Text("Detail",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex("#fff"))))),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        horizontal: 8, vertical: 12),
                    child: pw.Text("Guest Name",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        horizontal: 8, vertical: 12),
                    child: pw.Text("${data['name']}"))
              ]),
              pw.TableRow(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('Booking Number',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('${data['booking_number']}'),
                ),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('Hotel',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('${data['hotel']['name']}'),
                ),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('Rooms',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('${data['room_type']['name']}'),
                ),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('Check-in Date',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('${formatDate(data['booking_date'])}'),
                ),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('Check-out Date',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('${formatDate(data['end_date'])}'),
                ),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('Amount',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: pw.Text('${currency.format(data['total_price'])}'),
                ),
              ]),
            ],
          ),
        ]);
      }));
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save());
    } catch (e) {
      print("Error generating PDF: $e");
    }
  }
}
