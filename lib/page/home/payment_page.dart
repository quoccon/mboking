import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mbooking/blocs/bill/bill_cubit.dart';
import 'package:mbooking/blocs/booking/booking_cubit.dart';
import 'package:mbooking/blocs/vorcher/vorcher_cubit.dart';
import 'package:mbooking/model/booking.dart';
import 'package:mbooking/model/movies.dart';
import 'package:mbooking/page/home/vorcher.dart';
import 'package:mbooking/page/payment/my_ticket.dart';

import '../../model/auth.dart';

class Payment extends StatelessWidget {
  final Auth auth;
  final MovieElement movie;
  final Booking booking;
  final List<String> selectSeat;
  final DateTime selectDate;
  final String selectTime;
  final int totalPrice;

  const Payment(
      {super.key,
      required this.auth,
      required this.movie,
      required this.booking,
      required this.selectSeat,
      required this.selectDate,
      required this.selectTime,
      required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookingCubit(),
          ),
          BlocProvider(
            create: (context) => VorcherCubit(),
          ),
        ],
        child: PaymentPage(
            auth: auth,
            movie: movie,
            booking: booking,
            totalPrice: totalPrice,
            selectSeat: selectSeat,
            selectDate: selectDate,
            selectTime: selectTime),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final Auth auth;
  final MovieElement movie;
  final Booking booking;
  final List<String> selectSeat;
  final DateTime selectDate;
  final String selectTime;
  final int totalPrice;

  const PaymentPage({
    Key? key,
    required this.auth,
    required this.movie,
    required this.booking,
    required this.selectSeat,
    required this.selectDate,
    required this.selectTime,
    required this.totalPrice,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late String paymentMethod;

  @override
  void initState() {
    super.initState();
    paymentMethod = "";
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Xác nhận"),
            content: const Text("Bạn có chắc chắn muốn thoát?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Tiếp tục"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Giao dịch mới"),
              )
            ],
          );
        });
  }

  Future<bool> _onWillPop() async {
    _showConfirmDialog(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    context.read<VorcherCubit>().getVoucher();
    final String bookingId = widget.booking.id ?? "";
    final String formatDate =
        DateFormat('dd.MM.yyyy').format(widget.selectDate);

    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16.0),
                      Text(
                        'Please wait...',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyTicket(
                        auth: widget.auth,
                        movie: widget.movie,
                        booking: widget.booking,
                        totalPrice: widget.totalPrice,
                        selectSeat: widget.selectSeat,
                        selectDate: widget.selectDate,
                        selectTime: widget.selectTime)));
          });
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: const Text("Chi tiết thanh toán"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xff1c1c1c),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            child: Image.network(
                              widget.movie.imageMovie ?? "",
                              fit: BoxFit.cover,
                              width: 150,
                              height: 200,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 20,
                              bottom: 20,
                              right: 30,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.movie?.movieName ?? "",
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/video-play.png",
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Acton,adventure,sci-fi",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/location.png",
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Vincom Ocean Park CGV",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/clock.png",
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      formatDate,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "ID Đơn hàng",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          widget.booking.id ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Ghế ngồi",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          widget.selectSeat.join(","),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff1c1c1c),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/ticket.png",
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Giảm giá 50%"),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Voucher(
                                              auth: widget.auth,
                                              movie: widget.movie,
                                              booking: widget.booking,
                                              selectSeat: widget.selectSeat,
                                              selectDate: widget.selectDate,
                                              selectTime: widget.selectTime,
                                              totalPrice: widget.totalPrice,
                                            )));
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    "Chọn Voucher",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  Icon(
                                    CupertinoIcons.chevron_forward,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tổng tiền",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'vi-VN',
                            symbol: 'đ',
                            decimalDigits: 0,
                          ).format(widget.totalPrice),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Phương thức thanh toán
                    PaymentMethod(
                      imageMethod: "assets/images/zalopay.png",
                      nameMethod: "ZaloPay",
                      onChanged: (selected) {
                        setState(() {
                          paymentMethod = selected ? "ZaloPay" : "";
                        });
                      },
                      isSelected: paymentMethod == "ZaloPay",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PaymentMethod(
                      imageMethod: "assets/images/momo.png",
                      nameMethod: "MoMo",
                      onChanged: (selected) {
                        setState(() {
                          paymentMethod = selected ? "MoMo" : "";
                        });
                      },
                      isSelected: paymentMethod == "MoMo",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PaymentMethod(
                      imageMethod: "assets/images/visa.png",
                      nameMethod: "International payment",
                      onChanged: (selected) {
                        setState(() {
                          paymentMethod =
                              selected ? "International payment" : "";
                        });
                      },
                      isSelected: paymentMethod == "International payment",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PaymentMethod(
                      imageMethod: "assets/images/atm.png",
                      nameMethod: "ATM Card",
                      onChanged: (selected) {
                        setState(() {
                          paymentMethod = selected ? "ATM Card" : "";
                        });
                      },
                      isSelected: paymentMethod == "ATM Card",
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: GestureDetector(
                  onTap: () {
                    if (paymentMethod.isNotEmpty) {
                      context
                          .read<BookingCubit>()
                          .paymentBooking(bookingId, paymentMethod);
                    } else {
                      // Hiển thị thông báo lựa chọn phương thức thanh toán
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xfffcc434),
                    ),
                    child: const Center(
                      child: Text(
                        "Thanh toán",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PaymentMethod extends StatefulWidget {
  final String? imageMethod;
  final String? nameMethod;
  final bool isSelected;
  final Function(bool) onChanged;

  const PaymentMethod({
    Key? key,
    this.imageMethod,
    this.nameMethod,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.isSelected);
      },
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.isSelected ? Colors.amber : const Color(0xff1c1c1c),
          ),
          color: widget.isSelected
              ? const Color(0xff261d08)
              : const Color(0xff1c1c1c),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Image.asset(
                  widget.imageMethod ?? "",
                  width: 100,
                  height: 80,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.nameMethod ?? "",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              Image.asset(
                "assets/images/chevron.png",
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
