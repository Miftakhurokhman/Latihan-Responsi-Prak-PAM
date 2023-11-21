import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_responsi/halamanReportDetail.dart';
import 'api_data_source.dart';
import 'model/reportModel.dart';

class HalamanReport extends StatefulWidget {
  const HalamanReport({super.key});

  @override
  State<HalamanReport> createState() => _HalamanReportState();
}

class _HalamanReportState extends State<HalamanReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('REPORT LIST')),
      ),
      body: _buildListReportBody(),
    );
  }

  Widget _buildListReportBody(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadReport(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            ReportModel newsModel =
            ReportModel.fromJson(snapshot.data);
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

  Widget _buildSuccessSection(ReportModel data){
    return ListView.builder(
        itemCount: data.results!.length,
        itemBuilder: (BuildContext context, int index){
          return _buildItemReport(data.results![index]);
        }
    );
  }

  Widget _buildItemReport(Results reportModel){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HalamanReportDetail(reportModel: reportModel)
          ),
        );
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(reportModel.imageUrl!),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      reportModel.title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(reportModel.publishedAt!),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
