import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_responsi/model/blogModel.dart';
import 'package:url_launcher/url_launcher.dart';

class HalamanBeritaDetail extends StatelessWidget {
  final Results newsModel;

  const HalamanBeritaDetail({required this.newsModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                newsModel.imageUrl!,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                newsModel.title!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(newsModel.publishedAt!),
              SizedBox(height: 10),
              Text(newsModel.summary!),
              SizedBox(height: 60,)
              // Tambahkan informasi lainnya sesuai kebutuhan
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchURL(newsModel.url!);
        },
        icon: Icon(Icons.link),
        label: Text('Website : ' + newsModel.newsSite!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
