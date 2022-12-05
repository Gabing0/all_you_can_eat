library globals;

class MyService {
  static final MyService _instance = MyService._internal();
  late String _query;
  late List<String> _ids;
  late List<String> _formulaOrderList;
  late List<String> _formulaPriceList;
  late List<String> _hotdishesOrderList;
  late List<String> _hotdishesPriceList;
  late List<String> _drinksOrderList;
  late List<String> _drinksPriceList;
  late List<String> _sweetsOrderList;
  late List<String> _sweetsPriceList;
  late List<String> _userOrderList;
  late List<String> _userPriceList;
  late double _userTotalPrice;

  // passes the instantiation to the _instance object
  factory MyService() => _instance;

  //initialize variables in here
  MyService._internal() {
    _query = '';
    _ids = [];
    _userOrderList = [];
    _userPriceList = [];
    _userTotalPrice = 0.00;
  }

  setName(String value) {
    _query = value;
  }

  setIds(List<String> value) {
    _ids = value;
  }

  setOrderList(String listname, List<String> list) {
    switch (listname) {
      case 'formula_add':
        {
          _formulaOrderList = list;
        }
        break;
      case 'hot_dishes':
        {
          _hotdishesOrderList = list;
        }
        break;
      case 'drinks':
        {
          _drinksOrderList = list;
        }
        break;
      case 'sweets':
        {
          _sweetsOrderList = list;
        }
    }
  }

  setPriceList(String listname, List<String> list) {
    switch (listname) {
      case 'formula_add':
        {
          _formulaPriceList = list;
        }
        break;
      case 'hot_dishes':
        {
          _hotdishesPriceList = list;
        }
        break;
      case 'drinks':
        {
          _drinksPriceList = list;
        }
        break;
      case 'sweets':
        {
          _sweetsPriceList = list;
        }
    }
  }

  addUserOrder(String userOrder, String userOrderPrice) {
    double _price = double.parse(userOrderPrice);
    _userOrderList.add(userOrder);
    _userPriceList.add(userOrderPrice);
    _userTotalPrice = _userTotalPrice + _price;

    print("_userOrderList:$_userOrderList");
    print("_userPriceList:$_userPriceList");
    print("_userTotalList:$_userTotalPrice");
  }

  String getName() {
    return _query;
  }

  List<String> getIds() {
    return _ids;
  }

  List<String> getOrderList(String listname) {
    switch (listname) {
      case 'formula_add':
        {
          return _formulaOrderList;
        }
      case 'hot_dishes':
        {
          return _hotdishesOrderList;
        }
      case 'drinks':
        {
          return _drinksOrderList;
        }
      case 'sweets':
        {
          return _sweetsOrderList;
        }
      default:
        {
          return ['NULL'];
        }
    }
  }

  List<String> getPriceList(String listname) {
    switch (listname) {
      case 'formula_add':
        {
          return _formulaPriceList;
        }
      case 'hot_dishes':
        {
          return _hotdishesPriceList;
        }
      case 'drinks':
        {
          return _drinksPriceList;
        }
      case 'sweets':
        {
          return _sweetsPriceList;
        }
      default:
        {
          return ['NULL'];
        }
    }
  }

  getUserOrderList() {
    return _userOrderList;
  }

  getUserPriceList() {
    return _userPriceList;
  }

  getUserTotalPrice() {
    return _userTotalPrice;
  }

  void resetUserLists() {
    _userOrderList = [];
    _userPriceList = [];
    _userTotalPrice = 0.00;
  }
}
