import 'package:book_selection/data/db/book/book.dart';
import 'package:book_selection/provider/book/book.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  //Database
  locator.registerLazySingleton<BookDatabase>(() => BookDatabase());

  //Provider
  locator.registerLazySingleton<BookProvider>(() => BookProvider(locator()));

  //External
}
