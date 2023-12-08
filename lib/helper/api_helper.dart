import 'dart:convert';

import 'package:adv_flutter_4pm/model/photo.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<List<Photo>> fetchPhotosFromAPI() async {
    String apiKey = '39250301-82c95e13e873140cd9dfd6bd9';
    List<Photo> fetchedPhotos = [];

    String api = 'https://pixabay.com/api/?key=$apiKey';

    http.Response response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      String data = response.body;

      Map<String, dynamic> fetchApiData = jsonDecode(data);

      List allPhotosData = fetchApiData['hits'];

      fetchedPhotos = allPhotosData
          .map((e) => Photo(largeImageURL: e['largeImageURL']))
          .toList();
    }
    return fetchedPhotos;
  }

  Future<List<Photo>> fetchPhotosFromAPISearching(String searchText) async {
    String apiKey = '39250301-82c95e13e873140cd9dfd6bd9';
    List<Photo> fetchedPhotos = [];

    String api = 'https://pixabay.com/api/?key=$apiKey&q=$searchText';

    http.Response response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      String data = response.body;

      Map<String, dynamic> fetchApiData = jsonDecode(data);

      List allPhotosData = fetchApiData['hits'];

      fetchedPhotos = allPhotosData
          .map((e) => Photo(largeImageURL: e['largeImageURL']))
          .toList();
    }
    return fetchedPhotos;
  }
}
