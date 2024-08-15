import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/pages/wallpaper_page.dart';

class CategoryPage extends StatefulWidget {
  final String category;

  CategoryPage({required this.category, super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    String url =
        'https://api.pexels.com/v1/search?query=${widget.category}&per_page=80&page=$page';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          '5RpYyfaRKMLbMp67n2Q6Sh8KY52GTiSDKikf623UhIpknp3dSYyAThRT'
    });

    if (response.statusCode == 200) {
      Map result = jsonDecode(response.body);
      setState(() {
        images = result['photos'];
      });
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<void> loadMore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/search?query=${widget.category}&per_page=80&page=$page';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'YOUR_API_KEY_HERE'});

    if (response.statusCode == 200) {
      Map result = jsonDecode(response.body);
      setState(() {
        images.addAll(result['photos']);
      });
    } else {
      throw Exception('Failed to load more images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                childAspectRatio: 2 / 4,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WallpaperPage(
                                  imageurl: images[index]['src']['large2x'])));
                    },
                    child: Container(
                      color: Colors.grey,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: loadMore,
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text(
                  'Load More',
                  style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
