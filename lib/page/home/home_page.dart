import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mbooking/blocs/movie/movie_cubit.dart';
import 'package:mbooking/model/auth.dart';
import 'package:mbooking/model/movies.dart';
import 'package:mbooking/page/home/detail_film_page.dart';

class Home extends StatelessWidget {
  final Auth auth;

  const Home({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit(),
      child: Scaffold(
        body: HomePage(
          auth: auth,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final Auth auth;

  const HomePage({super.key, required this.auth});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    context.read<MovieCubit>().getFilm();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, ${widget.auth?.username ?? ""}",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                "Welcome back",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Color(0xff1c1c1c),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Tìm kiếm ở đây...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phim đang chiếu",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "Xem thêm",
                    style: TextStyle(fontSize: 15, color: Colors.amber),
                  )
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if(state is MovieInitial){
                    return Center(
                      child: Text("Hiện chưa có bộ phim nào"),
                    );
                  }else if(state is MovieLoaded){
                    return SizedBox(
                      height: 300, // Adjusted height to accommodate images better
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                          MovieElement movie = state.movies[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailFilmPage(
                                        auth: widget.auth,movie:movie
                                      )));
                            },
                            child: Container(
                              width: 150, // Adjusted width for better fit
                              margin: const EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    movie.imageMovie??"",
                                    width: 150,
                                    height: 200,
                                    // Adjusted height for a consistent aspect ratio
                                    fit: BoxFit
                                        .cover, // Added BoxFit to ensure image covers the entire area
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                   movie.movieName??"" ,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/images/video.png"),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "Adventure",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xffdedede)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/images/calendar.png"),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                       Text(
                                        movie.releaseDate != null ? DateFormat('dd.MM.yyyy').format(movie.releaseDate!) : "",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xffdedede)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Phim được yêu thích nhất",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
