import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class WallpaperPage extends StatefulWidget {
  final String imageurl;

  const WallpaperPage({super.key, required this.imageurl});

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  Future<void> setWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;

    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);

    await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Image.network(widget.imageurl),
            )),
            InkWell(
              onTap: setWallpaper,
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                    child: Text('Set Wallpaper',
                        style: GoogleFonts.roboto(
                            fontSize: 20, color: Colors.white))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
