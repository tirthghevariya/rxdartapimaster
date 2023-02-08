import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:rxdartapimaster/constant/app%20constant.dart';
import 'package:rxdartapimaster/model/NewsModel.dart';

class ApiCall {
  final subject = PublishSubject<List<NewsModel>>();

  void fetchData() async {
    final response = await http.get(Uri.parse(AppConstant.newsUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log(response.body);
      final articles = (data['articles'] as List)
          .map((article) => NewsModel.fromJson(article))
          .toList();
      subject.add(articles);
    } else if (response.statusCode == 403) {
      subject.addError('Access to the URL is forbidden');
    } else {
      subject.addError("Failed to load data");
    }
  }
}
