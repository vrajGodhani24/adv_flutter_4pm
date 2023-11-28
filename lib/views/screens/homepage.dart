import 'package:adv_flutter_4pm/helper/api_helper.dart';
import 'package:adv_flutter_4pm/model/photo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();

    getImages();
  }

  Future<void> getImages() async {
    photos = await APIHelper.apiHelper.fetchImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
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
                  photos = await APIHelper.apiHelper.searchImages(val);
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
                children: photos
                    .map((e) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(e.largeImageURL),
                                fit: BoxFit.cover),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
