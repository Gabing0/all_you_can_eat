import 'dart:ui';
import 'package:all_you_can_eat/components.dart';
import 'package:all_you_can_eat/view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:all_you_can_eat/library/globals.dart' as globals;

class RestaurantSummarySectionWeb extends HookConsumerWidget {
  RestaurantSummarySectionWeb(
      {Key? key,
      required BuildContext context,
      required ViewModel viewModelProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return statefulSummaryScaffold(
        context: context, viewModelProvider: ref.watch(viewModel));
  }
}

class statefulSummaryScaffold extends StatefulWidget {
  final context;
  final viewModelProvider;

  statefulSummaryScaffold(
      {Key? key, required this.context, this.viewModelProvider})
      : super(key: key);

  @override
  State<statefulSummaryScaffold> createState() =>
      _statefulSummaryScaffoldState(this.context, this.viewModelProvider);
}

class _statefulSummaryScaffoldState extends State<statefulSummaryScaffold> {
  late BuildContext context;
  late double deviceWidth;
  late double deviceHeight;
  late List<String> userOrderList;
  late List<String> userPriceList;
  late double userTotalPrice;
  int index = 0;

  _statefulSummaryScaffoldState(BuildContext context, viewModelProvider) {
    this.context = context;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    userOrderList = globals.MyService().getUserOrderList();
    userPriceList = globals.MyService().getUserPriceList();
    userTotalPrice = globals.MyService().getUserTotalPrice();
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
            SizedBox(
              height: 20.0,
            ),
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
            ),
            TabsHook(title: "Menù", route: '/menu', color: Colors.black),
            TabsHook(
                title: "Summary",
                route: '/summary',
                color: Colors.black,
                underline: true),
          ],
        ),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://media-cdn.tripadvisor.com/media/photo-s/1d/3e/ab/55/interni-di-uramakao.jpg"),
                fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: deviceWidth / 1.3,
                      child: Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                        text: "Summary",
                                        size: 35.0,
                                        color: Colors.white),
                                  ]),
                              SizedBox(height: 20.0),
                              Container(
                                height: deviceHeight / 1.3,
                                width: deviceWidth / 1.1,
                                child: userOrderList.isNotEmpty
                                    ? Column(children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: deviceHeight / 1.1,
                                              minHeight: 100.0),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: userOrderList.length,
                                              itemBuilder: (context, index) {
                                                return ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxHeight: 40.0,
                                                      maxWidth: 250.0),
                                                  child: ListView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: CustomText(
                                                                  text:
                                                                      userPriceList[
                                                                          index],
                                                                  size: 18.0,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ]),
                                                      SizedBox(width: 10.0),
                                                      CustomText(
                                                          text: userOrderList[
                                                              index],
                                                          size: 16.0,
                                                          color: Colors.white),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: CustomText(
                                                          text: userTotalPrice
                                                              .toStringAsFixed(
                                                                  2),
                                                          size: 22.0,
                                                          color: Colors.white),
                                                    ),
                                                  ]),
                                              SizedBox(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: CustomText(
                                                    text: "Total Price",
                                                    size: 20.0,
                                                    color: Colors.white),
                                              ),
                                            ]),
                                        Container(
                                          height: 250,
                                          child: ListView(children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: deviceWidth / 5,
                                                    height: 80,
                                                    child: Card(
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                      child: IconButton(
                                                          icon: Icon(
                                                              Icons.clear,
                                                              color:
                                                                  Colors.black),
                                                          onPressed: () {
                                                            setState(() {
                                                              globals.MyService()
                                                                  .resetUserLists();
                                                              userOrderList =
                                                                  [];
                                                              userPriceList =
                                                                  [];
                                                              userTotalPrice =
                                                                  0.00;
                                                            });
                                                          }),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: deviceWidth / 5,
                                                    height: 80,
                                                    child: Card(
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                      child: IconButton(
                                                          icon: Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.black),
                                                          onPressed: () {
                                                            setState(() {
                                                              DialogueBox(
                                                                  context,
                                                                  "Your order has been submitted");
                                                              widget.viewModelProvider.submitUserOrder(
                                                                  userOrderList
                                                                      .toString(),
                                                                  userTotalPrice
                                                                      .toStringAsFixed(
                                                                          2));
                                                              globals.MyService()
                                                                  .resetUserLists();
                                                              userOrderList =
                                                                  [];
                                                              userPriceList =
                                                                  [];
                                                              userTotalPrice =
                                                                  0.00;
                                                            });
                                                          }),
                                                    ),
                                                  )
                                                ])
                                          ]),
                                        ),
                                      ])
                                    : Center(
                                        child: CustomText(
                                            text:
                                                "You haven't made an order yet",
                                            size: 17.0,
                                            color: Colors.white),
                                      ),
                              ),
                            ]),
                      ),
                    ),
                  ]),
            ),
          )),
    );
  }
}
