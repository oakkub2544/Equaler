import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../components/header_bar.dart';
import '../components/news_info.dart';

//page that display news content
class ReadNews extends StatefulWidget {
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
  //instantiate FlutterTts (text to speech)
  final FlutterTts flutterTts = FlutterTts();
  //set state text to speech
  bool _isListening = false;

  speakMethod(String text) async {
    //setting text to speech
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  pauseMethod(String text) async {
    //stop text to speech
    await flutterTts.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headerbar(
        headerTitle: 'Read News',
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        //displays news images, dates and news content vertically
        return SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(widget.newsTitle,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              //display news image
              child: Image.network(
                widget.imgUrl,
                width: constraints.maxWidth * 0.9,
                height: constraints.maxHeight * 0.30,
                fit: BoxFit.cover,
              ),
            ),
            NewsInfo(
              info: widget.newsDate,
              isNewsDate: true,
            ),
            NewsInfo(
              info: widget.newsContent,
              isNewsDate: false,
            )
          ]),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_isListening == false) {
              //when pressed speak text and set _isListening to true
              speakMethod(widget.newsContent);
              _isListening = true;
            } else if (_isListening == true) {
              //stop text to speech
              pauseMethod(widget.newsContent);
              _isListening = false;
            }
          });
        },
        //set text to speech icon
        backgroundColor: const Color.fromRGBO(50, 48, 45, 1),
        //set icon text to speech
        child: Semantics(
          label: "Text To Speech Button",
          child: Icon((_isListening == false)
              ? Icons.play_arrow_rounded
              : Icons.stop_rounded),
        ),
      ),
    );
  }

  //dispose will active when the last widget disappears from screen
  @override
  void dispose() {
    super.dispose();
    //stop text to speech when user leave from read news page
    flutterTts.stop();
  }

  //custom appbar with the same height
  @override
  Size get preferredSize => Size.fromHeight(60);
}
