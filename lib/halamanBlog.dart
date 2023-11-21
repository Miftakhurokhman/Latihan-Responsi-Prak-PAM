import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_responsi/halamanBlogDetail.dart';

import 'api_data_source.dart';
import 'model/blogModel.dart';

class HalamanBlog extends StatefulWidget {
  const HalamanBlog({super.key});

  @override
  State<HalamanBlog> createState() => _HalamanBlogState();
}

class _HalamanBlogState extends State<HalamanBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BLOG LIST')),
      ),
      body: _buildListBlogBody(),
    );
  }

  Widget _buildListBlogBody(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadBlog(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            BlogModel newsModel =
            BlogModel.fromJson(snapshot.data);
            return _buildSuccessSection(newsModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection(){
    return Text('gagal');
  }

  Widget _buildLoadingSection(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(BlogModel data){
    return ListView.builder(
        itemCount: data.results!.length,
        itemBuilder: (BuildContext context, int index){
          return _buildItemBlog(data.results![index]);
        }
    );
  }

  Widget _buildItemBlog(Results blogModel){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HalamanBlogDetail(blogModel: blogModel),
          ),
        );
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(blogModel.imageUrl!),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      blogModel.title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(blogModel.publishedAt!),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
