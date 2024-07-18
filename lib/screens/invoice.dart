import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tester/components/button.dart';
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
    final NumberFormat currency =
        NumberFormat.currency(locale: 'id-ID', symbol: 'IDR ');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Config.spaceBig,
          Expanded(
              flex: 2,
              child: Lottie.asset('assets/success.json', repeat: false)),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Successfully Booked!',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Config.spaceMedium,
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Config.spaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${data['booking_number']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${data['hotel']['name']}"),
                    Text(" - ${data['room_type']['name']}"),
                  ],
                ),
                Config.spaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Check-in Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("${data['booking_date']}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Check-out Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("${data['end_date']}"),
                  ],
                ),
                Config.spaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () async {
                              await _printAsPdf();
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shadowColor: Colors.red,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black),
                            child: const Text("Print as PDF")))
                  ],
                ),
                Config.spaceMedium,
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (currency.format(data['total_price'])),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Button(
                width: double.infinity,
                title: 'Back to Home Page',
                onPressed: () => Navigator.of(context).pushNamed('main'),
                disable: false),
          )
        ],
      )),
    );
  }

  Future<void> _printAsPdf() async {
    final pdf = pw.Document();
    final NumberFormat currency =
        NumberFormat.currency(locale: 'id-ID', symbol: 'IDR ');

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Booking Invoice',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Booking Number : ${data['booking_rumber']}'),
            pw.Text('Hotel: ${data['hotel']['name']}'),
            pw.Text('Room Type: ${data['room_type']['name']}'),
            pw.Text('Check-in Date: ${data['booking_date']}'),
            pw.Text('Check-out Date: ${data['end_date']}'),
            pw.SizedBox(height: 20),
            pw.Text('Total Price: ${currency.format(data['total_price'])}'),
          ]);
    }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
