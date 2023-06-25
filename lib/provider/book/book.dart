import 'package:book_selection/data/db/book/book.dart';
import 'package:book_selection/data/model/book/book.dart';
import 'package:book_selection/utils/provider_enum.dart';
import 'package:flutter/widgets.dart';

late ProviderState _state;

String _message = '';

List<BookModel>? _books;

late BookModel _detail;

BookModel? _dataForUpdate;

class BookProvider extends ChangeNotifier {
  final BookDatabase db;

  BookProvider(this.db) {
    fetchBooks();
    clearVariables();
  }

  String category = "Adventure";

  bool isEdit = false;

  bool hardcoverValue = false;

  BookModel? get detail => _detail;

  BookModel? get dataForUpdate => _dataForUpdate;

  ProviderState get state => _state;

  String get message => _message;

  List<BookModel>? get books => _books;

  void setCategory(String value) {
    category = value;
    notifyListeners();
  }

  void setHardcover(bool value) {
    hardcoverValue = value;
    notifyListeners();
  }

  void getDetail(BookModel data) {
    _detail = data;
    notifyListeners();
  }

  Future<void> clearVariables() async {
    category = "Adventure";
    hardcoverValue = false;
    isEdit = false;
    _dataForUpdate = const BookModel(
        code: '', isbn: '', title: '', description: '', price: '');
    notifyListeners();
  }

  Future<void> insertBook(BookModel book) async {
    _state = ProviderState.loading;
    notifyListeners();
    try {
      await db.insertBook(book);
      _state = ProviderState.loaded;
      fetchBooks();
      notifyListeners();
    } catch (e) {
      _message = e.toString();
      _state = ProviderState.error;
      notifyListeners();
    }
  }

  Future<void> fetchBooks() async {
    _state = ProviderState.loading;
    notifyListeners();
    try {
      final books = await db.getBooks();
      if (books.isEmpty || books == []) {
        _state = ProviderState.empty;
        _message = 'Books are empty';
      } else {
        _state = ProviderState.loaded;
        _books = books;
      }
      notifyListeners();
    } catch (e, stacktrace) {
      debugPrint(e.toString());
      debugPrint(stacktrace.toString());
      _message = e.toString();
      _state = ProviderState.error;
      notifyListeners();
    }
  }

  void setUpdate(BookModel data) {
    isEdit = true;
    _dataForUpdate = data;
    notifyListeners();
  }

  Future<void> updateBook(BookModel book) async {
    _state = ProviderState.loading;
    notifyListeners();
    try {
      await db.updateBook(book);
      _state = ProviderState.loaded;
      fetchBooks();
      notifyListeners();
    } catch (e) {
      _message = e.toString();
      _state = ProviderState.error;
      notifyListeners();
    }
  }

  Future<void> deleteBook(String code) async {
    _state = ProviderState.loading;
    notifyListeners();
    try {
      await db.deleteBook(code);
      _state = ProviderState.loaded;
      fetchBooks();
      notifyListeners();
    } catch (e) {
      _message = e.toString();
      _state = ProviderState.error;
      notifyListeners();
    }
  }
}
