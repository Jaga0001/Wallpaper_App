import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/pages/category.dart';
import 'package:wallpaper_app/pages/wallpaper_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> category = ['Music', 'Animal', 'Brands', 'Cars', 'Nature'];

  List images = [];
  int page = 1;
  String searchQuery = '';

  //* Fetching From Image api
  fetchapi() async {
    String url;

    if (searchQuery.isEmpty) {
      url = 'https://api.pexels.com/v1/curated?per_page=80';
    } else {
      url =
          'https://api.pexels.com/v1/search?query=$searchQuery&?per_page=80&page=$page';
    }

    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '5RpYyfaRKMLbMp67n2Q6Sh8KY52GTiSDKikf623UhIpknp3dSYyAThRT'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
        print(images.length);
      });
    });
  }

  //* Load More From Image API
  LoadMore() async {
    setState(() {
      page = page + 1;
    });

    String url;
    // 'https://api.pexels.com/v1/curated?per_page=80' + page.toString();

    if (searchQuery.isEmpty) {
      url = 'https://api.pexels.com/v1/curated?per_page=80' + page.toString();
    } else {
      url = 'https://api.pexels.com/v1/search?query=$searchQuery?per_page=80' +
          page.toString();
    }

    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '5RpYyfaRKMLbMp67n2Q6Sh8KY52GTiSDKikf623UhIpknp3dSYyAThRT'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  //* Search Query
  void handleSearch(String query) {
    setState(() {
      searchQuery = query;

      //* Reset Page to 1 for New Search
      page = 1;

      fetchapi();
    });
  }

  @override
  void initState() {
    fetchapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homepage',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          //* Carousel View
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
                height: 150,
                child: CarouselView(
                    onTap: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryPage(category: category[value]),
                        ),
                      );
                    },
                    itemExtent: 240,
                    children: category.map((item) {
                      return Builder(builder: (context) {
                        return Container(
                          decoration: BoxDecoration(color: Colors.black),
                          child: Center(
                            child: Text(
                              item,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                        );
                      });
                    }).toList())),
          ),
          const SizedBox(height: 10),
          //* Search Bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: handleSearch,
              decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ),

          SizedBox(height: 10),

          //* List of Photos
          Expanded(
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    childAspectRatio: 2 / 4),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WallpaperPage(
                                    imageurl: images[index]['src']
                                        ['large2x'])));
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
                }),
          ),

          //* Load More Button
          InkWell(
            onTap: LoadMore,
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                  child: Text('Load More',
                      style: GoogleFonts.roboto(
                          fontSize: 20, color: Colors.white))),
            ),
          )
        ],
      ),
    );
  }
}
