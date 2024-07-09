import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mbooking/blocs/booking/booking_cubit.dart';
import 'package:mbooking/model/auth.dart';
import 'package:mbooking/model/movies.dart';
import 'package:mbooking/page/home/payment_page.dart';

class SelectSeat extends StatelessWidget {
  final Auth auth;
  final MovieElement movie;
  final String? cinemaId;

  const SelectSeat({super.key, required this.auth, required this.movie, this.cinemaId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit(),
      child: Scaffold(
        body: SelectSeatPage(
          auth: auth,
          movie: movie,
          cinemaId:cinemaId,
        ),
      ),
    );
  }
}

class SelectSeatPage extends StatefulWidget {
  final MovieElement movie;
  final Auth auth;
  final String? cinemaId;

  const SelectSeatPage({super.key, required this.auth, required this.movie, required this.cinemaId});

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  final List<String> selectedSeats = [];
  DateTime? selectedDate;
  String? selectedTime;
  Cinema? selectedCinema;

  @override
  void initState() {
    super.initState();
    if (widget.movie.showDate.isNotEmpty) {
      selectedDate = widget.movie.showDate.first.showDate;
    }
    if (widget.movie.cinemas.isNotEmpty) {
      selectedCinema = widget.movie.cinemas.first;
    }
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    for (var seatId in selectedSeats) {
      final seat = selectedCinema!.seat.firstWhere((s) => s.id == seatId);
      totalPrice += seat.price!;
    }
    return totalPrice;
  }

  List<String> getSelectedSeatName(){
    List<String> seatName = [];
    for(var seatId in selectedSeats){
      final seat = selectedCinema!.seat.firstWhere((s) => s.id == seatId);
      seatName.add('${seat.row}${seat.number}');
    }
    return seatName;
  }


  @override
  Widget build(BuildContext context) {
    String userId = widget.auth.id ?? "";
    String movieId = widget.movie.id ?? "";
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xff1c1c1c),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xff1c1c1c),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Select seat'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select your seat",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ClipPath(
                  clipper: CurvedClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 13,
                      childAspectRatio: 1,
                    ),
                    itemCount: selectedCinema?.seat.length ?? 0,
                    itemBuilder: (context, index) {
                      final seat = selectedCinema!.seat[index];
                      final isSelected = selectedSeats.contains(seat.id);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (seat.isSelected!) return;
                            isSelected
                                ? selectedSeats.remove(seat.id)
                                : selectedSeats.add(seat.id!);
                          });
                          print('ghế == $selectedSeats');
                        },
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.amber
                                : (seat.isSelected!
                                ? Colors.grey
                                : Colors.white),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              seat.row! + seat.number.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.movie.showDate.length,
                    itemBuilder: (context, index) {
                      final date = widget.movie.showDate[index];
                      final isSelected = date.showDate == selectedDate;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = isSelected ? null : date.showDate;
                            selectedTime = null;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xff261d08)
                                : const Color(0xff1c1c1c),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color:
                                isSelected ? Colors.amber : Colors.white),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('dd').format(date.showDate!),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                DateFormat('EEE').format(date.showDate!),
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: selectedDate != null,
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedDate != null
                          ? widget.movie.showDate
                          .firstWhere(
                              (date) => date.showDate == selectedDate)
                          .time
                          .length
                          : 0,
                      itemBuilder: (context, index) {
                        final time = widget.movie.showDate
                            .firstWhere((date) => date.showDate == selectedDate)
                            .time[index];
                        final isSelectedTime = time == selectedTime;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTime = isSelectedTime ? null : time;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isSelectedTime
                                  ? const Color(0xff261d08)
                                  : const Color(0xff1c1c1c),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: isSelectedTime
                                      ? Colors.amber
                                      : Colors.white),
                            ),
                            child: Center(
                              child: Text(
                                time,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${calculateTotalPrice()} VND',
                          // Calculated total price
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        context
                            .read<BookingCubit>()
                            .addBooking(userId, movieId, calculateTotalPrice(),selectedSeats,widget.cinemaId??"",selectedDate!,selectedTime!);
                        if (state is BookingInitial) {
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
                        } else if (state is BookingSuccess) {
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Payment(
                                      auth: widget.auth,
                                      movie: widget.movie,
                                      booking: state.booking,
                                      totalPrice:calculateTotalPrice(),
                                      selectSeat:getSelectedSeatName(),
                                      selectDate:selectedDate!,
                                      selectTime:selectedTime!)),
                            );
                          });
                        }
                      },
                      child: const Text('Buy ticket',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 20, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
