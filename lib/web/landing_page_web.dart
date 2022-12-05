import 'package:all_you_can_eat/view_model.dart';
import 'package:flutter/material.dart';
import 'package:all_you_can_eat/components.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:all_you_can_eat/library/globals.dart' as globals;

class LandingPageWeb extends HookConsumerWidget {
  const LandingPageWeb(
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
  final viewModelProvider;
  final context;
  const statefulScaffold({Key? key, this.viewModelProvider, this.context})
      : super(key: key);

  @override
  State<statefulScaffold> createState() =>
      _statefulScaffoldState(this.context, this.viewModelProvider);
}

class _statefulScaffoldState extends State<statefulScaffold> {
  late BuildContext context;
  late double deviceWidth;
  late double deviceHeight;
  late var Rstr;
  var result;
  bool found = false;

  _statefulScaffoldState(context, viewModelProvider) {
    this.context = context;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
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
        iconTheme: IconThemeData(color: Colors.black, size: 25.0),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () async {
                var ids;
                var result = await showSearch(
                    context: context, delegate: MySearchDelegate());
                if (result != null) {
                  setState(() {
                    found = true;
                    print("query 1:$result");
                  });

                  await widget.viewModelProvider.setDocs(result);
                  await widget.viewModelProvider.setName(result);
                  ids = globals.MyService().getIds();

                  await widget.viewModelProvider
                      .setOrderList("formula_add", ids);
                  await widget.viewModelProvider
                      .setOrderList("hot_dishes", ids);
                  await widget.viewModelProvider.setOrderList("drinks", ids);
                  await widget.viewModelProvider.setOrderList("sweets", ids);

                  await widget.viewModelProvider
                      .setPriceList("formula_add", ids);
                  await widget.viewModelProvider
                      .setPriceList("hot_dishes", ids);
                  await widget.viewModelProvider.setPriceList("drinks", ids);
                  await widget.viewModelProvider.setPriceList("sweets", ids);

                  await widget.viewModelProvider.toggleRstrFound();
                }
              })
        ],
      ),
      body: found
          ? LinearProgressIndicator(
              color: Colors.grey, backgroundColor: Colors.black)
          : SizedBox(),
    );
  }
}
