import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/blocs/vorcher/vorcher_cubit.dart';
import 'package:mbooking/model/vorcher.dart';
import 'package:mbooking/page/home/payment_page.dart';

import '../../model/auth.dart';
import '../../model/booking.dart';
import '../../model/movies.dart';

class Voucher extends StatelessWidget {
  final Auth auth;
  final MovieElement movie;
  final Booking booking;
  final List<String> selectSeat;
  final DateTime selectDate;
  final String selectTime;
  final int totalPrice;

  const Voucher(
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
    return BlocProvider(
      create: (context) => VorcherCubit(),
      child: Scaffold(
        body: VoucherWidget(
          auth: auth,
          movie: movie,
          booking: booking,
          selectSeat: selectSeat,
          selectDate: selectDate,
          selectTime: selectTime,
          totalPrice: totalPrice,
        ),
      ),
    );
  }
}

class VoucherWidget extends StatefulWidget {
  final Auth auth;
  final MovieElement movie;
  final Booking booking;
  final List<String> selectSeat;
  final DateTime selectDate;
  final String selectTime;
  final int totalPrice;

  const VoucherWidget(
      {super.key,
      required this.auth,
      required this.movie,
      required this.booking,
      required this.selectSeat,
      required this.selectDate,
      required this.selectTime,
      required this.totalPrice});

  @override
  State<VoucherWidget> createState() => _VoucherWidgetState();
}

class _VoucherWidgetState extends State<VoucherWidget> {
  @override
  Widget build(BuildContext context) {
    context.read<VorcherCubit>().getVoucher();
    return BlocBuilder<VorcherCubit, VorcherState>(
      builder: (context, state) {
        if (state is VorcherInitial) {
          return const Center(
            child: Text("Hiện bạn không có voucher nào"),
          );
        } else if (state is VorcherLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Voucher của bạn"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: state.vorcher.length,
                  itemBuilder: (context, index) {
                    final Vorcher voucher = state.vorcher[index];
                    final int? remainingDay =
                        voucher.expiryDate?.difference(DateTime.now()).inDays;
                    final String expiryDateMess = remainingDay! > 0
                        ? "Còn $remainingDay ngày"
                        : remainingDay <= 0
                            ? "Hết hạn hôm nay"
                            : "Voucher đã hết hạn";
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 300,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Color(0xff1c1c1c),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      voucher.content ?? "",
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      expiryDateMess,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.yellow[200]),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final double discount =
                                            (voucher.discount ?? 0) /
                                                100 *
                                                widget.totalPrice;
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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

                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          Navigator.of(context).pop();
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Payment(
                                                      auth: widget.auth,
                                                      movie: widget.movie,
                                                      booking: widget.booking,
                                                      selectSeat:
                                                          widget.selectSeat,
                                                      selectDate:
                                                          widget.selectDate,
                                                      selectTime:
                                                          widget.selectTime,
                                                      totalPrice:
                                                          widget.totalPrice)));
                                        });
                                      },
                                      child: const Text(
                                        "Dùng ngay",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.amber),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else if (state is VorcherError) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

// class TicketClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double radius = 20;
//     Path path = Path()
//     ..moveTo(radius, 0)
//     ..lineTo(size.width - radius, 0)
//     ..arcToPoint(Offset(size.width, radius),radius: Radius.circular(radius))
//     ..lineTo(size.width, size.height - radius)
//     ..arcToPoint(Offset(size.width - radius, size.height),radius: Radius.circular(radius),clockwise: false)
//     ..lineTo(radius, size.height)
//     ..lineTo(radius, size.height)
//     ..arcToPoint(Offset(0, size.height - radius),radius: Radius.circular(radius))
//     ..lineTo(0, radius)
//     ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius),clockwise: false)
//     ..close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//   return false;
//   }
//
// }
