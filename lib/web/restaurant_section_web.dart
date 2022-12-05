import 'package:all_you_can_eat/components.dart';
import 'package:all_you_can_eat/view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:all_you_can_eat/library/globals.dart' as globals;

class RestaurantSectionWeb extends HookConsumerWidget {
  RestaurantSectionWeb(
      {Key? key,
      required BuildContext context,
      required ViewModel viewModelProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return statefulScaffold(
        context: context, viewModelProvider: ref.watch(viewModel));
  }
}

class statefulScaffold extends StatefulWidget {
  final context;
  final viewModelProvider;

  statefulScaffold({Key? key, required this.context, this.viewModelProvider})
      : super(key: key);

  @override
  State<statefulScaffold> createState() => _statefulScaffoldState(this.context);
}

class _statefulScaffoldState extends State<statefulScaffold> {
  late BuildContext context;
  late String name;
  late double deviceWidth;
  late double deviceHeight;

  _statefulScaffoldState(BuildContext context) {
    this.context = context;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    name = globals.MyService().getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DrawerHeader(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.0, color: Colors.black)),
                child: CircleAvatar(
                  radius: 180.0,
                  backgroundColor: Colors.white,
                  child: Image(
                    height: 100.0,
                    image: AssetImage('assets/logo.jpeg'),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              height: 50.0,
              minWidth: 200.0,
              color: Colors.black,
              child: CustomText(
                text: "Logout",
                size: 20.0,
                color: Colors.white,
              ),
              onPressed: () async {
                await widget.viewModelProvider.logout();
              },
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(size: 25.0, color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.door_back_door),
                onPressed: () {
                  widget.viewModelProvider.toggleRstrFound();
                }),
            TabsHook(
              title: "Home",
              route: '/home',
              color: Colors.black,
              underline: true,
            ),
            TabsHook(title: "Menù", route: '/menu', color: Colors.black),
            TabsHook(title: "Summary", route: '/summary', color: Colors.black),
          ],
        ),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://media-cdn.tripadvisor.com/media/photo-s/1d/3e/ab/51/interni-di-uramakao.jpg"),
                fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Welcome to $name",
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 80.0,
                      ),
                    )
                  ]),
            ),
          )),
    );
  }
}
