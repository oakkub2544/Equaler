import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../components/header_bar.dart';

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

enum TtsState { playing, stopped, paused }

class _ReadNewsState extends State<ReadNews> {
  //instantiate FlutterTts (text to speech)
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();

  get isPaused => ttsState == TtsState.paused;
  TtsState ttsState = TtsState.stopped;



  bool _isListening = false; //set state text to speech

  speakMethod(String text) async {
    //setting text to speech
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  pauseMethod(String text) async {
    //pause text

    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);

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
            Padding(
              //format the text of the news
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
                        //display news date
                        Text(widget.newsDate,
                            style: const TextStyle(fontSize: 15)),
                        //display news content
                        GestureDetector(
                          child: Text(
                            textAlign: TextAlign.justify,
                            widget.newsContent,
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
              //pause text to speech
              pauseMethod(widget.newsContent);
              _isListening = false;
            }
          });
        },
        backgroundColor: const Color.fromRGBO(50, 48, 45, 1),
        //set icon text to speech
        child: Icon((_isListening == false)
            ? Icons.play_arrow_rounded
            : Icons.stop_rounded),

        backgroundColor:
            Color.fromRGBO(50, 48, 45, 1), //set text to speech icon


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
