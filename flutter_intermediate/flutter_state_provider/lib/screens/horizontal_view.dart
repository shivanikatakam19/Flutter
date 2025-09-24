import 'package:flutter/material.dart';
import 'package:flutter_state_provider/screens/vertical_view.dart';
import 'package:flutter_state_provider/shared/providers/list-provider.dart';
import 'package:provider/provider.dart';

class HorizontalView extends StatefulWidget {
  const HorizontalView({super.key});

  @override
  State<HorizontalView> createState() => _HorizontalViewState();
}

class _HorizontalViewState extends State<HorizontalView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NumbersListProvider>(
      builder: (context, numbersProviderModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            numbersProviderModel.add();
          },
        ),
        appBar: AppBar(),
        body: SizedBox(
          child: Column(
            children: [
              Text(
                numbersProviderModel.numbers.last.toString(),
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 80, // 👈 give fixed height for horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: numbersProviderModel.numbers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        numbersProviderModel.numbers[index].toString(),
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => VerticalView()),
                  );
                },
                child: Text('Second'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
