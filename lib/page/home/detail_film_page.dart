import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mbooking/model/movies.dart';
import 'package:mbooking/page/home/select_seat_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/auth.dart';

class DetailFilmPage extends StatefulWidget {
  final MovieElement movie;
  final Auth auth;
  const DetailFilmPage({super.key, required this.auth, required this.movie});

  @override
  State<DetailFilmPage> createState() => _DetailFilmPageState();
}

class _DetailFilmPageState extends State<DetailFilmPage> {
  int isSelected = -1;

  Future<void> _launchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      // Xử lý khi có lỗi
      print('Lỗi khi mở liên kết: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Lỗi'),
          content: Text('Đã xảy ra lỗi khi mở liên kết.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng dialog
              },
              child: Text('Đóng'),
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  widget.movie.imageMovie??"",
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xff1c1c1c),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          widget.movie?.movieName??"",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                         Text(//"2h29min - 16.12.2022"
                          "${widget.movie.duration} phút - ${widget.movie.releaseDate != null ? DateFormat('dd.MM.yyyy').format(widget.movie.releaseDate!) : ""}",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber),
                                Text(
                                  '4.8 ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '(1.222)',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                _launchUrl(widget.movie.trailer??"");
                              },
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: const Color(0xff1c1c1c),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.white)),
                                child: const Center(
                                  child: Text(
                                    "Watch trailer",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 60), // Adjust height as necessary
             Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Thể loại phim: Action, adventure, sci-fi",
                    style: TextStyle(color: Color(0xffcdcdcd), fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    "Kiểm duyệt: ${widget.movie.ageLimit}",
                    style: const TextStyle(color: Color(0xffcdcdcd), fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    "Ngôn ngữ: ${widget.movie.language}",
                    style: const TextStyle(color: Color(0xffcdcdcd), fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    "Đạo diễn: ${widget.movie.director}",
                    style: const TextStyle(color: Color(0xffcdcdcd), fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    "Diễn viên: ${widget.movie.actor}",
                    style: const TextStyle(color: Color(0xffcdcdcd), fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Cốt truyện",
                    style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    widget.movie.plot??"",
                    style: const TextStyle(color: Color(0xffcdcdcd), fontSize: 14),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Chọn rạp chiếu",
                    style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: widget.movie.cinemas.length,
                      itemBuilder: (context, index) {
                        Cinema cinema = widget.movie.cinemas[index];
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                             if(isSelected == index){
                               isSelected = -1;
                             }else{
                               isSelected = index;
                             }
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 80,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: isSelected == index ? Colors.amber : const Color(0xff1c1c1c)),
                                color: isSelected == index ? const Color(0xff261d08) : const Color(0xff1c1c1c)
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cinema.nameCinema??"",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  Image.network(cinema.imageCinema??"",width: 50,height: 50,)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(right: 10,left: 10),
          child: GestureDetector(
            onTap: (){
              if(isSelected == -1){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title:
                      const Text("Lựa chọn rạp chiếu"),
                      content: const Text(
                          "Vui lòng chọn rạp chiếu để tiếp tục."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  SelectSeat(auth: widget.auth,movie:widget.movie,cinemaId:widget.movie.cinemas[isSelected].id)));
              }
            },
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                  color: const Color(0xfffcc434)
              ),
              child: const Center(
                child: Text("Tiếp tục",  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
