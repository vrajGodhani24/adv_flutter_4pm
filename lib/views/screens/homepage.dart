import 'package:adv_flutter_4pm/helper/api_helper.dart';
import 'package:adv_flutter_4pm/model/photo.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Photo> allPhotos = [];

  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  getPhotos() async {
    await APIHelper.apiHelper.fetchPhotosFromAPI().then((value) {
      allPhotos = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WallPaper App"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                onChanged: (val) async {
                  await APIHelper.apiHelper
                      .fetchPhotosFromAPISearching(val)
                      .then((value) {
                    allPhotos = value;
                    setState(() {});
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                children: allPhotos
                    .map(
                      (e) => Container(
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(e.largeImageURL),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.wallpaper),
                          onPressed: () async {
                            await AsyncWallpaper.setWallpaper(
                                url: e.largeImageURL,
                                wallpaperLocation: AsyncWallpaper.BOTH_SCREENS);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
