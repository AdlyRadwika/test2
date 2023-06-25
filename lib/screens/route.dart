import 'package:book_selection/screens/detail/detail.dart';
import 'package:book_selection/screens/input_book/input_book.dart';
import 'package:flutter/material.dart';
import 'package:book_selection/screens/home/home.dart';

const homeScreen = 'home_screen';
const detailScreen = 'detail_screen';
const inputBookScreen = 'input_book_screen';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homeScreen:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case detailScreen:
      return MaterialPageRoute(
        builder: (context) => const DetailScreen(),
      );
    case inputBookScreen:
      return MaterialPageRoute(
        builder: (context) => const InputBookScreen(),
      );
    default:
      throw ('Page is not found!');
  }
}
