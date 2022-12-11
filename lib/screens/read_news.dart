import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../components/header_bar.dart';

class ReadNews extends StatefulWidget {
//Class for display news that passed sent from class news_card
//================== Initial Constructor =======================
  final String imgUrl;
  final String newsTitle;
  final String newsDate;
  final String newsDesc;
  final String newsContent;

  ReadNews(
      {this.imgUrl = "https://picsum.photos/seed/137/600",
      this.newsTitle = "This is news title",
      this.newsDate = "This is news date",
      this.newsContent = "This is news content",
      this.newsDesc = "This is news description"});
//==============================================================

  @override
  State<ReadNews> createState() => _ReadNewsState();
}

class _ReadNewsState extends State<ReadNews> {
  final FlutterTts flutterTts = FlutterTts(); //Instantiate FlutterTts
  final TextEditingController textEditingController = TextEditingController();

  speakMethod(String text) async {
    //Setting Text to Speech
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: 'Read News',
        ),
        body: LayoutBuilder(builder: (ctx, constraints) {
          return SingleChildScrollView(
            //Display news image, date and content
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(widget.newsTitle,
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold)),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.imgUrl,
                  width: constraints.maxWidth * 0.9,
                  height: constraints.maxHeight * 0.30,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: const Color.fromRGBO(246, 240, 235, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(widget.newsDate,
                              style: const TextStyle(fontSize: 15)),
                          GestureDetector(
                            child: Text(
                              textAlign: TextAlign.justify,
                              widget.newsContent,
                              style: const TextStyle(fontSize: 18),
                            ),
                            onDoubleTap: () {
                              //When user double tap on Text, speak news content
                              speakMethod(widget.newsContent);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          );
        }));
  }

  @override
  void dispose() {
    //dispose will active when the last widget disappears from screen
    super.dispose();
    flutterTts.stop(); //Stop text to speech when user leave from read news page
  }

  @override
  //Custom appbar with the same height, width
  Size get preferredSize => Size.fromHeight(60);
}
