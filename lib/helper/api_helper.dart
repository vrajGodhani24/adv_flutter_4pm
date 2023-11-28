import 'dart:convert';

import 'package:adv_flutter_4pm/model/photo.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<List<Photo>> fetchImages() async {
    String apiKey = '39250301-82c95e13e873140cd9dfd6bd9';
    String api = "https://pixabay.com/api/?key=$apiKey";

    http.Response res = await http.get(Uri.parse(api));

    dynamic data = jsonDecode(res.body);

    List<dynamic> imagesData = data['hits'];

    List<Photo> allPhotos = imagesData.map((e) => Photo.fromJson(e)).toList();

    return allPhotos;
  }

  Future<List<Photo>> searchImages(String searchText) async {
    String apiKey = '39250301-82c95e13e873140cd9dfd6bd9';
    String api = "https://pixabay.com/api/?key=$apiKey&q=$searchText";

    http.Response res = await http.get(Uri.parse(api));

    dynamic data = jsonDecode(res.body);

    List<dynamic> imagesData = data['hits'];

    List<Photo> allPhotos = imagesData.map((e) => Photo.fromJson(e)).toList();

    return allPhotos;
  }
}
