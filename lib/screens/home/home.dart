import 'package:book_selection/provider/book/book.dart';
import 'package:book_selection/screens/home/widgets/book_item.dart';
import 'package:book_selection/utils/constants.dart';
import 'package:book_selection/utils/provider_enum.dart';
import 'package:book_selection/screens/route.dart' as route;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Collection'),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.normalPadding),
        child: Consumer<BookProvider>(builder: (context, provider, _) {
          if (provider.state == ProviderState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == ProviderState.empty ||
              provider.state == ProviderState.error) {
            return Center(
                child: Text(
              provider.message,
              textAlign: TextAlign.center,
            ));
          } else {
            return RefreshIndicator(
              onRefresh: () => provider.fetchBooks(),
              child: ListView.builder(
                itemCount: provider.books?.length,
                itemBuilder: (context, index) {
                  final data = provider.books![index];
                  return BookItem(data: data);
                },
              ),
            );
          }
        }),
      ),
      floatingActionButton: Container(
        color: theme.primaryColor,
        child: IconButton(
          tooltip: 'Add Book',
          onPressed: () {
            context.read<BookProvider>().clearVariables();
            Navigator.pushNamed(context, route.inputBookScreen);
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
