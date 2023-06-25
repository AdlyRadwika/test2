import 'package:book_selection/provider/book/book.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:book_selection/utils/injection.dart' as di;

List<SingleChildWidget> providers = [
  ...independentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (_) => di.locator<BookProvider>()),
];
