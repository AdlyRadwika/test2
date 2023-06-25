import 'package:book_selection/data/model/book/book.dart';
import 'package:book_selection/provider/book/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_selection/screens/route.dart' as route;

class BookItem extends StatelessWidget {
  const BookItem({
    super.key,
    required this.data,
  });

  final BookModel data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<BookProvider>().getDetail(data);
        Navigator.pushNamed(context, route.detailScreen);
      },
      leading: const Icon(Icons.book),
      title: Text(data.title.toString()),
      subtitle: Text(data.description.toString()),
      isThreeLine: true,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.read<BookProvider>().setUpdate(data);
              Navigator.pushNamed(context, route.inputBookScreen);
            },
            child: const Icon(
              Icons.edit,
              color: Colors.blue,
              size: 20.0,
            ),
          ),
          GestureDetector(
            onTap: () => context.read<BookProvider>().deleteBook(data.code),
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
