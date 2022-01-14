import 'package:firebase_auth/firebase_auth.dart';

const productUrl='https://test-33476-default-rtdb.firebaseio.com/products.json';
const ordersUrl='https://test-33476-default-rtdb.firebaseio.com/orders.json';
final String cartUrl='https://test-33476-default-rtdb.firebaseio.com/cart/${FirebaseAuth.instance.currentUser!.uid}.json';
const String register='/';
const String addProduct='add_product';
const String buyProducts='AllProducts';
const String productDetails='product_details';
const String favoritesPage='favorites';
const String productInfo='product_info';
const String cartPage='cart_screen';

const transactionApi="https://secure-egypt.paytabs.com/payment/request";
const serverKey="STJNBMB99W-J2R22GZ2N9-996W6TTNG9";


List sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL', '4XL', '5XL'];
List genders = ['Male', 'Female', 'unisex'];
List categories = [
  'top',
  'bottoms',
  'underWears',
  'footWear',
  'fullBody',
  'accessories',
  'jewelry',
  'bags'
];
List allCategories = [
  top,
  bottoms,
  underWears,
  footWear,
  fullBody,
  accessories,
  jewelry,
  bags
];
List<String> top = [
  'shirt',
  'T-shirt',
  'sweater',
  'jacket',
  'coat',
  'vest',
  'tanktop',
  'blouse',
];
List<String> bottoms = [
  'jeans',
  'shorts',
  'skirt',
];
List<String> underWears = ['panties', 'stockings', 'bra', 'boxers', 'undershirts'];
List<String> footWear = [
  'sneakers',
  'shoes',
  'socks',
  'heels'
];
List<String> fullBody = ['suit', 'tracksuit', 'pajamas', 'swimsuit', 'dress'];
List<String> accessories = [
  'tie',
  'bow-tie',
  'hat',
  'sun hat',
  'Ice cap',
  'cap',
  'scarf',
  'glasses',
  'sunglasses',
  'belt',
  'wallet',
  'watch'
];
List<String> jewelry = ['earrings', 'bracelet', 'ring', 'necklace'];
List<String> bags = ['bagpack', 'handpack', 'purse'];
