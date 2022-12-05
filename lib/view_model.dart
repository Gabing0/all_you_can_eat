import 'package:all_you_can_eat/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:all_you_can_eat/library/globals.dart' as globals;
/*import 'package:google_sign_in/google_sign_in.dart';*/

final viewModel =
    ChangeNotifierProvider.autoDispose<ViewModel>((ref) => ViewModel());

class ViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  String _userEmail = '';
  bool isSignedIn = false;
  bool isObscure = true;
  bool isRstrFound = false;
  String tab = '';
  var logger = Logger();
  /*List<String> userOrderList = [];
  List<String> userPriceList = [];
  double userTotalPrice = 0.00;*/

  //Check if Signed In
  Future<void> isLoggedIn() async {
    await _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isSignedIn = false;
      } else {
        isSignedIn = true;
        _userEmail = user.email!;
      }
    });
    notifyListeners();
  }

  toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  toggleRstrFound() {
    isRstrFound = !isRstrFound;
    notifyListeners();
  }

  goHome() {
    tab = '/home';
    notifyListeners();
    print("goHome():$tab");
  }

  goMenu() {
    tab = '/menu';
    notifyListeners();
    print("goMenu():$tab");
  }

  goSummary() {
    tab = '/summary';
    notifyListeners();
    print("goSummary():$tab");
  }

  //Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  //Authentication
  Future<void> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => logger.d("Registration successful"))
        .onError((error, stackTrace) {
      logger.d("Registration error $error");
      DialogueBox(
          context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
    });
  }

  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => logger.d("Login Successful"))
        .onError((error, stackTrace) {
      logger.d("Login error $error");
      DialogueBox(
          context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
    });
  }

  setDocs(query) async {
    var ids = await initRstrBody(query);
    globals.MyService().setIds(ids);
    notifyListeners();
  }

  setName(query) {
    globals.MyService().setName(query);
    notifyListeners();
  }

  setOrderList(field, ids) async {
    var listRef = await getListRef(field, ids);
    listRef.get().then((value) {
      var map = value.data();
      List<dynamic> list = map!['order'];
      List<String> newList = (list ?? []).map((e) => e.toString()).toList();
      print("Orders:$newList");
      globals.MyService().setOrderList(field, newList);
    });
  }

  setPriceList(field, ids) async {
    var listRef = await getListRef(field, ids);
    listRef.get().then((value) {
      var map = value.data();
      List<dynamic> list = map!['price'];
      List<String> newList = (list ?? []).map((e) => e.toString()).toList();
      print("Prices:$newList");
      globals.MyService().setPriceList(field, newList);
    });
  }

  submitUserOrder(String userOrderList, String userTotalPrice) async {
    String user_doc = await getUserDocId('email', _userEmail);
    CollectionReference userRef =
        userCollection.doc(user_doc).collection('orders');
    Map<String, String> data = {
      'restaurant': globals.MyService().getName(),
      'order_items': userOrderList,
      'order_total': userTotalPrice
    };

    userRef.add(data);
    print("user_doc: $user_doc");
  }
  /*getUserOrderList() {
    return userOrderList;
  }

  getUserPriceList() {
    return userPriceList;
  }

  getUserTotalPrice() {
    return userTotalPrice;
  }*/

}
