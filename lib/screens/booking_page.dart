import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tester/providers/dio_provider.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _paymentTypeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _promoCodeController = TextEditingController();
  final TextEditingController _startBookingDateController =
      TextEditingController();
  final TextEditingController _endBookingDateController =
      TextEditingController();

  late Map<String, dynamic> room;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      room = arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Booking'),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "${room['hotel']['name']}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              DropdownButtonFormField<String>(
                value: '1',
                decoration: const InputDecoration(
                  labelText: 'Payment Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: '1',
                    child: Text('ONLINE'),
                  ),
                  DropdownMenuItem(
                    value: '2',
                    child: Text('HOTEL'),
                  ),
                ],
                onChanged: (value) {
                  _paymentTypeController.text = value!;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _promoCodeController,
                decoration: const InputDecoration(
                  labelText: 'Promo Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _startBookingDateController,
                decoration: const InputDecoration(
                  labelText: 'Start Booking Date',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _startBookingDateController.text = pickedDate.toString();
                  }
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _endBookingDateController,
                decoration: const InputDecoration(
                  labelText: 'End Booking Date',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _endBookingDateController.text = pickedDate.toString();
                  }
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final paymentType = _paymentTypeController.text;
                    final email = _emailController.text;
                    final name = _nameController.text;
                    final phone = _phoneController.text;
                    final bookingDate = _startBookingDateController.text;
                    final endDate = _endBookingDateController.text;
                    final promoCode = _promoCodeController.text;

                    final hotelId = room['hotel']['id'];
                    final roomTypeId = room['id'];
                    final totalPrice = room['price'];
                    final quantity = 1; // Asumsikan quantity 1 untuk contoh ini

                    final booking = await DioProvider().booking(
                      paymentType,
                      totalPrice,
                      email,
                      name,
                      phone,
                      bookingDate,
                      endDate,
                      hotelId,
                      roomTypeId,
                      quantity,
                      promotionId: promoCode.isNotEmpty ? promoCode : null,
                    );

                    if (booking != null) {
                      Navigator.of(context).pushNamed('success_booking');
                    } else {
                      // Handle error
                      print('Error during booking');
                    }
                  }
                },
                child: const Text('Reserve'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
