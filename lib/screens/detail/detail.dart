import 'package:book_selection/data/model/book/book.dart';
import 'package:book_selection/provider/book/book.dart';
import 'package:book_selection/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Detail'),
        ),
        body: Padding(
          padding: EdgeInsets.all(Constants.normalPadding),
          child: Consumer<BookProvider>(builder: (context, provider, _) {
            final BookModel? data = provider.detail;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Book Title: ${data?.code ?? "..."}'),
                  Text('Description: ${data?.description ?? "..."}'),
                  Text('ISBN: ${data?.isbn ?? "..."}'),
                  Text('Category: ${data?.category ?? "..."}'),
                  Text('Publish Date: ${data?.publishDate ?? "..."}'),
                  Text('Price: ${data?.price ?? "..."}'),
                  Text('Hard Cover: ${data?.hardCover ?? "..."}'),
                ],
              ),
            );
          }),
        ));
  }
}
