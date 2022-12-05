import 'dart:ui';
import 'package:all_you_can_eat/components.dart';
import 'package:all_you_can_eat/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:all_you_can_eat/library/globals.dart' as globals;

class RestaurantMenuSectionMobile extends HookConsumerWidget {
  RestaurantMenuSectionMobile(
      {Key? key,
      required BuildContext context,
      required ViewModel viewModelProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return statefulMenuScaffold(
        context: context, viewModelProvider: ref.watch(viewModel));
  }
}

class statefulMenuScaffold extends StatefulWidget {
  final context;
  final viewModelProvider;

  statefulMenuScaffold(
      {Key? key, required this.context, this.viewModelProvider})
      : super(key: key);

  @override
  State<statefulMenuScaffold> createState() =>
      _statefulMenuScaffoldState(this.context);
}

class _statefulMenuScaffoldState extends State<statefulMenuScaffold> {
  late BuildContext context;
  late List<String> ids;
  late double deviceWidth;
  late double deviceHeight;
  late List<String> orderList;
  late List<String> priceList;
  List<String> listName = ["Main Menu", "Hot Dishes", "Drinks", "Sweets"];
  int index = 0;

  _statefulMenuScaffoldState(BuildContext context) {
    this.context = context;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    ids = globals.MyService().getIds();
    orderList = globals.MyService().getOrderList("formula_add");
    priceList = globals.MyService().getPriceList("formula_add");
    print("menu docs:$ids");
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
            TabsHook(
                title: "Menù",
                route: '/menu',
                color: Colors.black,
                underline: true),
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
                      width: deviceWidth / 1.05,
                      child: Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    CustomText(
                                        text: listName[index],
                                        size: 35.0,
                                        color: Colors.white),
                                    IconButton(
                                        icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white),
                                        onPressed: () {
                                          setState(() {
                                            if (index < 3) {
                                              index++;
                                              switch (index) {
                                                case 1:
                                                  {
                                                    orderList =
                                                        globals.MyService()
                                                            .getOrderList(
                                                                "hot_dishes");
                                                    priceList =
                                                        globals.MyService()
                                                            .getPriceList(
                                                                "hot_dishes");
                                                  }
                                                  break;

                                                case 2:
                                                  {
                                                    orderList =
                                                        globals.MyService()
                                                            .getOrderList(
                                                                "drinks");
                                                    priceList =
                                                        globals.MyService()
                                                            .getPriceList(
                                                                "drinks");
                                                  }
                                                  break;

                                                case 3:
                                                  {
                                                    orderList =
                                                        globals.MyService()
                                                            .getOrderList(
                                                                "sweets");
                                                    priceList =
                                                        globals.MyService()
                                                            .getPriceList(
                                                                "sweets");
                                                  }
                                                  break;
                                              }
                                            } else {
                                              index = 0;
                                              orderList = globals.MyService()
                                                  .getOrderList("formula_add");
                                              priceList = globals.MyService()
                                                  .getPriceList("formula_add");
                                            }
                                          });
                                        }),
                                  ]),
                              SizedBox(height: 20.0),
                              Container(
                                height: deviceHeight / 1.3,
                                width: deviceWidth / 1.05,
                                child: ListView.builder(
                                    itemCount: orderList.length,
                                    itemBuilder: (context, index) {
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: 40.0, maxWidth: 250.0),
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: CustomText(
                                                        text: priceList[index],
                                                        size: 18.0,
                                                        color: Colors.white),
                                                  ),
                                                  IconButton(
                                                      icon: Icon(
                                                          Icons
                                                              .add_box_outlined,
                                                          color: Colors.white,
                                                          size: 18.0),
                                                      onPressed: () {
                                                        setState(() {
                                                          globals.MyService()
                                                              .addUserOrder(
                                                                  orderList[
                                                                      index],
                                                                  priceList[
                                                                      index]);
                                                        });
                                                      }),
                                                ]),
                                            SizedBox(width: 10.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: CustomText(
                                                  text: orderList[index],
                                                  size: 16.0,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
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
