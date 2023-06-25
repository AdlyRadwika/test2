const String tableBook = 'books';

class BookFields {
  static const String code = 'code';
  static const String isbn = 'isbn';
  static const String title = 'title';
  static const String description = 'description';
  static const String category = 'category';
  static const String publishDate = 'publish_date';
  static const String price = 'price';
  static const String hardCover = 'hard_cover';
}

class BookModel {
  final String code;
  final String isbn;
  final String title;
  final String description;
  final String? category;
  final String? publishDate;
  final String price;
  final String? hardCover;

  const BookModel({
    required this.code,
    required this.isbn,
    required this.title,
    required this.description,
    this.category,
    this.publishDate,
    required this.price,
    this.hardCover,
  });

  Map<String, dynamic> toMap() {
    return {
      BookFields.code: code,
      BookFields.isbn: isbn,
      BookFields.title: title,
      BookFields.description: description,
      BookFields.category: category,
      BookFields.publishDate: publishDate,
      BookFields.price: price,
      BookFields.hardCover: hardCover,
    };
  }

  @override
  String toString() {
    return 'Book{code: $code, isbn: $isbn, title: $title, description: $description, category: $category, publishDate: $publishDate, price: $price}';
  }
}
