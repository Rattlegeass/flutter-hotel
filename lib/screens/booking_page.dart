import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:tester/providers/dio_provider.dart';
import 'package:tester/utils/config.dart';

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

  int _quantity = 1;
  bool _isUsePromo = false;
  num _totalPrice = 0;
  DateTime? _startBookingDate;
  DateTime? _endBookingDate;

  late Map<String, dynamic> room;
  Map<String, dynamic> user = {};
  Map<String, dynamic> promo = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      room = arguments;
      _totalPrice = room['price'].toDouble();
    }
  }

  void increment() {
    setState(() {
      _quantity++;
      _updateTotalPrice();
    });
  }

  void decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        _updateTotalPrice();
      }
    });
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty && token != '') {
      final response = await DioProvider().getUser(token);
      if (response != null) {
        setState(() {
          user = json.decode(response);
        });
      }
    }
  }

  Future<void> _showErrorAnimation() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Card(
            color: Colors.grey[400],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Lottie.asset(
                      'assets/failed.json',
                      repeat: false,
                      fit: BoxFit.fill,
                      onLoaded: (composition) {
                        Future.delayed(composition.duration, () {
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "No promo found / not valid",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  final NumberFormat currency =
      NumberFormat.currency(locale: 'id-ID', symbol: "IDR ");

  void _updateTotalPrice() {
    if (_startBookingDate != null && _endBookingDate != null) {
      final timeDifference = _endBookingDate!.difference(_startBookingDate!);
      final int daysDifference = timeDifference.inDays;
      final int hoursDifference = timeDifference.inHours;

      setState(() {
        if (room['payment_rate'] == 'Daily') {
          _totalPrice = room['price'] * daysDifference * _quantity;
        } else if (room['payment_rate'] == 'Hourly') {
          _totalPrice = room['price'] * hoursDifference * _quantity;
        }

        if (_isUsePromo && promo.isNotEmpty) {
          _totalPrice -= promo['discount'];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Booking'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _startBookingDate = pickedDate;
                    _startBookingDateController.text = formatDate(pickedDate);
                    _endBookingDateController.clear();
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
                  if (_startBookingDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Please select the start booking date first")));
                    return;
                  }

                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate:
                        _startBookingDate!.add(const Duration(days: 1)),
                    firstDate: _startBookingDate!.add(const Duration(days: 1)),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _endBookingDate = pickedDate;
                    _endBookingDateController.text = formatDate(pickedDate);
                    _updateTotalPrice();
                  }
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: _isUsePromo,
                    onChanged: (value) async {
                      setState(() {
                        _isUsePromo = value!;
                      });
                      if (_isUsePromo) {
                        await _showPromoCodeDialog();
                        _updateTotalPrice();
                      }
                    },
                  ),
                  const Text('Use Promo Code'),
                ],
              ),
              const SizedBox(height: 15),
              if (_endBookingDateController.text != '')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currency.format(_totalPrice),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 50,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              onPressed: () {
                                setState(() {
                                  decrement();
                                });
                              },
                              child: const Text(
                                "-",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${_quantity}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 40,
                          width: 50,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              onPressed: () {
                                setState(() {
                                  increment();
                                });
                              },
                              child: const Text(
                                "+",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              const SizedBox(height: 15),
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
                    final userId = user['user']['id'];
                    final num totalPrice = _totalPrice;
                    const int quantity =
                        1; // Asumsikan quantity 1 untuk contoh ini

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
                      userId,
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

  Future<void> _showPromoCodeDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Use Promo"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  controller: _promoCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Promo Code',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                setState(() {
                  _isUsePromo = false;
                  _promoCodeController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Apply'),
              onPressed: () async {
                final response = await DioProvider().promo(
                  _promoCodeController.text.toString(),
                  room['hotel']['id'],
                  formatDate(DateTime.parse(_startBookingDateController.text)),
                  formatDate(DateTime.parse(_endBookingDateController.text)),
                  user['user']['id'],
                );

                if (response != null) {
                  setState(() {
                    promo = response;
                  });
                  Navigator.of(context).pop();
                } else {
                  _showErrorAnimation();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
