import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_responsi/halamanBlog.dart';
import 'package:latihan_responsi/halamanReport.dart';

import 'halamanBerita.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "SPACE FLIGHT NEWS"
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _cardMenu(
                    context,
                    "News",
                    "Get  an overview of the latest Spaceflight news, from various sources! Easily link your users to the right websites",
                    HalamanBerita(),
                    "https://icons.iconarchive.com/icons/bevel-and-emboss/media/256/news-icon.png"
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                _cardMenu(
                    context,
                    "Blogs",
                    "Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast.",
                    HalamanBlog(),
                    "https://icons.iconarchive.com/icons/photoshopedia/xedia/256/Text-Document-icon.png"
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                _cardMenu(
                    context,
                    "Reports",
                    "Space stations and other missions often publish their data. With SNAPI, you can include it in your app app as well!",
                    HalamanReport(),
                    "https://icons.iconarchive.com/icons/treetog/junior/256/document-scroll-icon.png"
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardMenu(
      BuildContext context,
      String judul,
      String deskripsi,
      Widget halaman,
      String gambar
      ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => halaman),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(gambar)
                    )
                  ),
                ),
                Text(
                    judul,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                ),
                Text(deskripsi),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
