import 'package:flutter/material.dart';
import 'package:flutter_state_provider/shared/providers/list-provider.dart';
import 'package:provider/provider.dart';

class VerticalView extends StatefulWidget {
  const VerticalView({super.key});

  @override
  State<VerticalView> createState() => _VerticalViewState();
}

class _VerticalViewState extends State<VerticalView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NumbersListProvider>(
      builder: (context, numbersProviderModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Provider.of<NumbersListProvider>(context, listen: false).add();
          },
        ),
        body: SizedBox(
          child: SizedBox(
            child: Column(
              children: [
                Text(
                  numbersProviderModel.numbers.last.toString(),
                  style: TextStyle(fontSize: 30),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: numbersProviderModel.numbers.length,
                    itemBuilder: (context, index) {
                      return Text(
                        numbersProviderModel.numbers[index].toString(),
                        style: TextStyle(fontSize: 30),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
