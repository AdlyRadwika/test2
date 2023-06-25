import 'package:book_selection/data/model/book/book.dart';
import 'package:book_selection/provider/book/book.dart';
import 'package:book_selection/screens/input_book/widgets/input_text.dart';
import 'package:book_selection/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputBookScreen extends StatefulWidget {
  const InputBookScreen({super.key});

  @override
  State<InputBookScreen> createState() => _InputBookScreenState();
}

class _InputBookScreenState extends State<InputBookScreen> {
  late TextEditingController codeC;

  late TextEditingController isbnC;

  late TextEditingController titleC;

  late TextEditingController? descriptionC;

  late TextEditingController? dateC;

  late TextEditingController priceC;

  final List<String> list = <String>['Adventure', 'Comedy', 'Horror'];

  @override
  void initState() {
    final provider = context.read<BookProvider>();
    final data = provider.dataForUpdate;
    codeC = TextEditingController(text: data?.code);
    isbnC = TextEditingController(text: data?.isbn);
    titleC = TextEditingController(text: data?.title);
    descriptionC = TextEditingController(text: data?.description);
    dateC = TextEditingController(text: data?.publishDate);
    priceC = TextEditingController(text: data?.price);
    provider.category = data?.category ?? "Adventure";
    provider.hardcoverValue = data?.hardCover == "1" ? true : false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.watch<BookProvider>().isEdit ? 'Edit Book' : 'Input Book',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Constants.normalPadding),
          child: Column(
            children: [
              InputText(
                controller: codeC,
                hint: 'AUI001',
                label: 'Book Code',
                length: 6,
                enabled: context.read<BookProvider>().isEdit ? false : true,
              ),
              InputText(
                controller: isbnC,
                hint: 'ISBN-9992300',
                label: 'ISBN',
                allowSpecialChars: true,
              ),
              InputText(
                controller: titleC,
                hint: 'Star Wars I',
                label: 'Title',
              ),
              InputText(
                controller: descriptionC!,
                hint: 'Lorem Ipsum...',
                label: 'Description',
              ),
              const SizedBox(
                height: 25,
              ),
              const Text('Category'),
              DropdownButton(
                value: context.watch<BookProvider>().category,
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  context.read<BookProvider>().setCategory(value!);
                },
              ),
              InkWell(
                onTap: () => _chooseDatePicker(context),
                child: InputText(
                  controller: dateC!,
                  hint: '23 June 2023',
                  label: 'Publish Date',
                  enabled: false,
                ),
              ),
              InputText(
                controller: priceC,
                hint: '10000',
                label: 'Price',
                keyboardType: TextInputType.number,
              ),
              CheckboxListTile(
                value: context.watch<BookProvider>().hardcoverValue,
                onChanged: (value) =>
                    context.read<BookProvider>().setHardcover(value!),
                title: const Text('Hardcover'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(Constants.normalPadding),
        child: ElevatedButton(
          onPressed: () => submit(context),
          child: const Text('Input'),
        ),
      ),
    );
  }

  void _chooseDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      final dateText = value.toIso8601String();
      dateC?.text = dateText;
    });
  }

  void submit(BuildContext context) {
    final provider = context.read<BookProvider>();

    final String code = codeC.text.trim();
    final String isbn = isbnC.text.trim();
    final String title = titleC.text.trim();
    final String description = descriptionC?.text.trim() ?? "-";
    final String date = dateC?.text.trim() ?? "-";
    final String price = priceC.text.trim();
    final String hardcover = provider.hardcoverValue == false ? "0" : "1";
    final String category = provider.category;

    if (code.isEmpty || isbn.isEmpty || title.isEmpty || price.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Pastikan jangan ada yang kosong!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final result = BookModel(
        code: code,
        isbn: isbn,
        title: title,
        description: description,
        price: price,
        publishDate: date,
        category: category,
        hardCover: hardcover,
      );

      provider.isEdit
          ? provider.updateBook(result)
          : provider.insertBook(result);
      Navigator.pop(context);
    }
  }
}
