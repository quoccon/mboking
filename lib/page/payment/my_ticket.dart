import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:intl/intl.dart';
import 'package:mbooking/homescreen.dart';
import 'package:mbooking/model/auth.dart';
import 'package:mbooking/model/booking.dart';
import 'package:mbooking/page/home/home_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../model/movies.dart';

class MyTicket extends StatefulWidget {
  final Auth auth;
  final MovieElement movie;
  final Booking booking;
  final List<String> selectSeat;
  final DateTime selectDate;
  final String selectTime;
  final int totalPrice;

  const MyTicket({super.key, required this.auth, required this.booking, required this.movie, required this.selectSeat, required this.selectDate, required this.selectTime, required this.totalPrice});

  @override
  State<MyTicket> createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  final barcode = Barcode.code128();
  final barcodeData = '12345678';

  late String formatDate;

  @override
  void initState() {
    super.initState();
    formatDate = DateFormat('dd.MM.yyyy').format(widget.selectDate);
  }

  @override
  Widget build(BuildContext context) {
    var cinema = widget.movie.cinemas[0];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đơn hàng của tôi"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Homescreen(auth: widget.auth,)));
                },
                child: Image.asset("assets/images/house.png",color: Colors.white,)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Thông tin phim
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: Image.network(
                              widget.movie.imageMovie??"",
                              fit: BoxFit.cover,
                              width: 150,
                              height: 200,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                widget.movie.movieName??"",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/clock.png",
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                   Text(
                                    "${widget.movie.duration.toString()} phút",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/video.png",
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    "Action,adventure,sci-fi",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //Chỗ ngồi
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/calendar-days.png",
                                color: Colors.black,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "14h50'",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    formatDate,
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/seat.png",
                                color: Colors.black,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Section 4",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.selectSeat.join(","),
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        color: Colors.black54,
                      ),

                      //Chi tiết thanh toán
                       Row(
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.totalPrice.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //Thông tin rạp chiếu
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                     Text(
                                      cinema.nameCinema??"",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Image.network(
                                      cinema.imageCinema??"",width: 30,height: 30,
                                    )
                                  ],
                                ),
                                 Text(
                                  cinema.location??"",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,

                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //Chú ý
                      const Row(
                        children: [
                          Icon(
                            Icons.event_note,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Xuất trình mã QR này cho quầy vé để nhận vé",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      const Divider(
                        color: Colors.black54,
                      ),

                      Container(
                        color: Colors.white,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Mã vạch của bạn"),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: QrImageView(
                                data: widget.booking.id??"",
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
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
