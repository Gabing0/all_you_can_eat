import 'package:all_you_can_eat/view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import 'package:all_you_can_eat/library/globals.dart' as globals;

class CustomText extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;
  const CustomText(
      {Key? key,
      required this.text,
      required this.size,
      this.color,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: GoogleFonts.openSans(
        fontSize: size,
        color: color == null ? Colors.black : color,
        fontWeight: fontWeight == null ? FontWeight.normal : fontWeight,
      ),
    );
  }
}

class TabsHook extends HookConsumerWidget {
  final title;
  final route;
  final color;
  final underline;
  const TabsHook({Key? key, this.title, this.route, this.color, this.underline})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tabs(
      context: context,
      viewModelProvider: ref.watch(viewModel),
      title: title,
      route: route,
      color: color,
      underline: underline,
    );
  }
}

class Tabs extends StatefulWidget {
  final context;
  final viewModelProvider;
  final title;
  final route;
  final color;
  final underline;
  const Tabs(
      {Key? key,
      this.context,
      this.viewModelProvider,
      this.title,
      this.route,
      required this.color,
      this.underline})
      : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.route);
        switch (widget.route) {
          case '/menu':
            {
              widget.viewModelProvider.goMenu();
              break;
            }
          case '/summary':
            {
              widget.viewModelProvider.goSummary();
              break;
            }
          default:
            {
              widget.viewModelProvider.goHome();
              break;
            }
        }
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isSelected = true;
          });
        },
        onExit: (_) {
          setState(() {
            isSelected = false;
          });
        },
        child: AnimatedDefaultTextStyle(
          curve: Curves.elasticIn,
          duration: const Duration(milliseconds: 100),
          style: isSelected
              ? GoogleFonts.pacifico(
                  color: widget.color,
                  fontSize: 22.0,
                )
              : GoogleFonts.pacifico(
                  color: widget.color,
                  fontSize: 20.0,
                ),
          child: widget.underline == null
              ? Text(widget.title)
              : Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2.5,
                  ),
                ),
        ),
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  final text;
  final containerWidth;
  final hintText;
  final controller;
  final digitsOnly;
  final validator;

  const TextForm({
    Key? key,
    required this.text,
    required this.containerWidth,
    required this.hintText,
    required this.controller,
    this.digitsOnly,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          size: 13.0,
          text: text,
        ),
        SizedBox(height: 5.0),
        SizedBox(
          width: containerWidth,
          child: TextFormField(
            validator: validator,
            inputFormatters: digitsOnly != null
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            controller: controller,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(fontSize: 13.0),
            ),
          ),
        ),
      ],
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  var RstrRef = FirebaseFirestore.instance.collection("restaurant");
  List<String> searchResults = ['Uramakao'];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              if (query == '') {
                close(context, null);
              }
              query = '';
            })
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero, () {
      close(context, query);
    });

    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showResults(context);
            },
          );
        });
  }
}

/*class MenuPage extends StatefulWidget {
  final title;
  final width;
  final backgroundcolor;
  final textcolor;
  final list;
  final ids;
  const MenuPage(
      {Key? key,
      this.title,
      this.width,
      this.backgroundcolor,
      required this.textcolor,
      required this.list,
      required this.ids})
      : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState(this.list, this.ids);
}

class _MenuPageState extends State<MenuPage> {
  var ListRef;

  _MenuPageState(list, ids) {
    ListRef = getListRef(list, ids);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Card(
        color: widget.backgroundcolor == null
            ? Colors.black
            : widget.backgroundcolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: CustomText(
                      text: widget.title, size: 35.0, color: widget.textcolor)),
              SizedBox(height: 20.0),
              Text(ListRef.toString()),
            ]),
      ),
    );
  }
}*/

initRstrBody(query) async {
  Future<List<String>> ids =
      Future(() async => await getRstrDocsIds("rstr", query));
  return ids;
}

///TODO method 'getRstrDocsIds' optimizable by rearranging Database 'menù' collection
Future<List<String>> getRstrDocsIds(String field, String str) async {
  var DocRef = FirebaseFirestore.instance.collection("restaurant");
  List<String> ids = ['', '', '', '', '', ''];

  await DocRef.where(field, isEqualTo: str)
      .get()
      .then((QuerySnapshot snapshot) => {
            snapshot.docs.forEach((doc) {
              ids[0] = doc.id;
            })
          });

  await DocRef.doc(ids[0])
      .collection('menù')
      .get()
      .then((QuerySnapshot snapshot) => {
            snapshot.docs.forEach((doc) {
              ids[1] = doc.id;
            })
          });

  await DocRef.doc(ids[0])
      .collection('menù')
      .doc(ids[1])
      .collection('formula_add')
      .get()
      .then((QuerySnapshot snapshot) => {
            snapshot.docs.forEach((doc) {
              ids[2] = doc.id;
            })
          });

  await DocRef.doc(ids[0])
      .collection('menù')
      .doc(ids[1])
      .collection('hot_dishes')
      .get()
      .then((QuerySnapshot snapshot) => {
            snapshot.docs.forEach((doc) {
              ids[3] = doc.id;
            })
          });

  await DocRef.doc(ids[0])
      .collection('menù')
      .doc(ids[1])
      .collection('drinks')
      .get()
      .then((QuerySnapshot snapshot) => {
            snapshot.docs.forEach((doc) {
              ids[4] = doc.id;
            })
          });

  await DocRef.doc(ids[0])
      .collection('menù')
      .doc(ids[1])
      .collection('sweets')
      .get()
      .then((QuerySnapshot snapshot) => {
            snapshot.docs.forEach((doc) {
              ids[5] = doc.id;
            })
          });

  return ids;
}

Future<DocumentReference<Map<String, dynamic>>> getListRef(
    String field, List<String> ids) async {
  DocumentReference MenuRef = FirebaseFirestore.instance
      .collection("restaurant")
      .doc(ids[0])
      .collection("menù")
      .doc(ids[1]);
  switch (field) {
    case 'formula_add':
      {
        var ListRef = MenuRef.collection(field).doc(ids[2]);
        return ListRef;
      }
    case 'hot_dishes':
      {
        var ListRef = MenuRef.collection(field).doc(ids[3]);
        return ListRef;
      }
    case 'drinks':
      {
        var ListRef = MenuRef.collection(field).doc(ids[4]);
        return ListRef;
      }
    case 'sweets':
      {
        var ListRef = MenuRef.collection(field).doc(ids[5]);
        return ListRef;
      }
    default:
      {
        var ListRef = MenuRef.collection(field).doc(ids[2]);
        return ListRef;
      }
  }
}

Future<String> getUserDocId(String field, String str) async {
  var DocRef = FirebaseFirestore.instance.collection('user');
  String id = '';

  await DocRef.where(field, isEqualTo: str)
      .get()
      .then((QuerySnapshot snapshot) => {
            snapshot.docs.forEach((doc) {
              id = doc.id;
            })
          });

  return id;
}

DialogueBox(BuildContext context, String title) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            contentPadding: EdgeInsets.all(32.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(width: 2.0, color: Colors.black),
            ),
            title: CustomText(
              text: title,
              size: 20.0,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.black,
                child: CustomText(
                  text: "Okay",
                  size: 20.0,
                  color: Colors.white,
                ),
              )
            ],
          ));
}
