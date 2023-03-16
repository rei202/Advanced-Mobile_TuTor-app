import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/screens/HomePage/components/SearchComponent.dart';
import 'package:lettutor/screens/LessonDetail/PdfScreen.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key});

  @override
  State<StatefulWidget> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail>
    with TickerProviderStateMixin {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  int? _selectedChipIndex = 0;

  void _updateText() {
    setState(() {
      // Update the text.
      textToShow = 'Flutter is Awesome!';
    });
  }

  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Course Detail'),
        ),
        body: Container(
          child: ListView(
            children: [
              Card(
                color: Colors.white,
                child: Column(children: [
                  Image.network("https://camblycurriculumicons.s3.amazonaws.com/5e2b895e541a832674533c18?h=d41d8cd98f00b204e9800998ecf8427e"),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Basic Conversation Topics",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Gain confidence speaking about familliar topics",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(children: <Widget>[
                            Container(
                                width: 16,
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 20.0),
                                child: Divider(
                                  color: Colors.black,
                                  height: 36,
                                )),
                            Text(
                              "List Topics",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                            ),
                          ]),
                          Container(
                              child: ExpansionPanelList.radio(
                            children:
                                _data.map<ExpansionPanelRadio>((Item item) {
                              return ExpansionPanelRadio(
                                  value: item.id,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return ListTile(
                                      title: Text(item.headerValue),
                                    );
                                  },
                                  body: ListTile(
                                      title: Text(item.expandedValue),
                                      subtitle: const Text(
                                          'To open pdf file of this topic, tap icon on the right !'),
                                      trailing: const Icon(Icons.picture_as_pdf, size: 30,),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder:  (context) => PdfScreen(document: item)));
                                      }));
                            }).toList(),
                          ))
                        ],
                      ))
                ]),
              ),
            ],
          ),
        ));
  }
}

class Item {
  Item(
      {required this.id,
      required this.expandedValue,
      required this.headerValue,
      required this.url});

  int id;
  String expandedValue;
  String headerValue;
  String url;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
        id: index,
        headerValue: 'Topic $index',
        expandedValue: 'Food your love',
        url: "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFoods%20You%20Love.pdf"
            //
        );
  });
}

// /https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFoods%20You%20Love.pdf
