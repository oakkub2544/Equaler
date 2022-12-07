import 'package:flutter/material.dart';
import './components/header_bar.dart';
import 'package:flutter_tts/flutter_tts.dart';

class readnew extends StatefulWidget {
  final String imgUrl1;

  final String newsTitle1;

  final String newsDate1;

  final String newsDesc1;

  final String newsContent1;

  readnew(
      {this.imgUrl1 = "https://picsum.photos/seed/137/600",
      this.newsTitle1 = "This is news title",
      this.newsDate1 = "This is news date",
      this.newsContent1 = "This is news content",
      this.newsDesc1 = "This is news description"});

  @override
  State<readnew> createState() => _readnewState();
}

class _readnewState extends State<readnew> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();

  speak(String text) async {
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
        body: Container(child: LayoutBuilder(builder: (ctx, constraints) {
          return SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(widget.newsTitle1,
                    style:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.imgUrl1,
                  width: constraints.maxWidth * 0.9,
                  height: constraints.maxHeight * 0.30,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Color.fromRGBO(246, 240, 235, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(widget.newsDate1,
                              style: TextStyle(fontSize: 15)),
                          GestureDetector(
                            child: Text(
                              widget.newsContent1,
                              style: TextStyle(fontSize: 18),
                            ),
                            onDoubleTap: () {
                              speak(widget.newsContent1);
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
        })));
  }

  @override 
  void dispose() { //dispose will active when the last widget disappears from screen
    super.dispose();
    flutterTts.stop();
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
