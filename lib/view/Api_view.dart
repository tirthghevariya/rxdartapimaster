import 'package:flutter/material.dart';
import 'package:rxdartapimaster/constant/app%20constant.dart';
import 'package:rxdartapimaster/controller/api%20call_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';
import '../model/NewsModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiCall _apiCall = ApiCall();

  List<NewsModel> _articles = [];
  @override
  void initState() {
    super.initState();
    _apiCall.fetchData();
  }

  @override
  void dispose() {
    _apiCall.subject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Api call using rxdart'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
            stream: _apiCall.subject.stream,
            builder: (BuildContext context,
                AsyncSnapshot<List<NewsModel>> snapshot) {
              if (snapshot.hasData) {
                _articles = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _articles.length,
                        itemBuilder: (context, index) {
                          final res = _articles[index];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              child: ClipRRect(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 30.0.h,
                                        child: FadeInImage.memoryNetwork(
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.network(
                                                AppConstant.errorImage);
                                          },
                                          fadeInDuration:
                                              const Duration(milliseconds: 500),
                                          image: res.urlToImage,
                                          placeholder: kTransparentImage,
                                        )),
                                    Text(
                                      res.title.toString(),
                                      style: TextStyle(fontSize: 18.0.sp),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
