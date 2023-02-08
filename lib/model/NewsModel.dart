import 'package:rxdartapimaster/constant/app%20constant.dart';

class NewsModel {
  final String title;
  final String urlToImage;

  NewsModel({required this.title, required this.urlToImage});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      urlToImage: json['urlToImage'] ?? AppConstant.errorImage,
    );
  }
}
