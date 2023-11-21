import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_responsi/halamanBeritaDetail.dart';
import 'api_data_source.dart';
import 'model/newsModel.dart';

class HalamanBerita extends StatefulWidget {
  const HalamanBerita({Key? key}) : super(key: key);

  @override
  State<HalamanBerita> createState() => _HalamanBeritaState();
}

class _HalamanBeritaState extends State<HalamanBerita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('NEWS LIST')),
      ),
      body: _buildListNewsBody(),
    );
  }

  Widget _buildListNewsBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadNews(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            NewsModel newsModel = NewsModel.fromJson(snapshot.data);
            return _buildSuccessSection(newsModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text('Failed to load data.'),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(NewsModel data) {
    return ListView.builder(
      itemCount: data.results!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemNews(data.results![index]);
      },
    );
  }

  Widget _buildItemNews(Results newsModel) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HalamanBeritaDetail(newsModel: newsModel),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100, // Set a fixed height for the image container
                child: Image.network(
                  newsModel.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsModel.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      newsModel.publishedAt!,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
