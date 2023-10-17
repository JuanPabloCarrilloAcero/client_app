import 'package:client_app/methods/formatCurrency.dart';
import 'package:client_app/services/graphql_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom/custom_thousands_input.dart';

class StockDTO {
  final String ticker;
  final String name;
  final String description;
  final String id;
  final String price;

  StockDTO({
    required this.ticker,
    required this.name,
    required this.description,
    required this.id,
    required this.price,
  });
}

class DataCardStockModalWidget extends StatelessWidget {
  const DataCardStockModalWidget({Key? key, required this.data})
      : super(key: key);

  final List<StockDTO> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stocks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.map((value) {
                return InkWell(
                  onTap: () {
                    // Handle the tap event, e.g., open a modal
                    _showModal(context, value);
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          '${value.ticker} - ${value.name} (${formatCurrency(double.parse(value.price))})',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      // Border below the item
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ));
  }

  void _showModal(BuildContext context, StockDTO value) {
    // Implement your modal dialog here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          content: Text(
            value.description,
            style: const TextStyle(
              fontSize: 16,
              height: 2.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add code to handle the "Close" button action here
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                _showValueInputDialog(context, value, 'buy');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                // Change background color
                foregroundColor: MaterialStateProperty.all(
                    Colors.white), // Change text color
              ),
              child: const Text('BUY'),
            ),
            TextButton(
              onPressed: () {
                _showValueInputDialog(context, value, 'sell');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                // Change background color
                foregroundColor: MaterialStateProperty.all(
                    Colors.white), // Change text color
              ),
              child: const Text('SELL'),
            ),
          ],
        );
      },
    );
  }

  void _showValueInputDialog(BuildContext context, StockDTO stock, String action) {
    String amount = '';

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (newValue) {
                  amount = newValue;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsSeparatorInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                decoration:
                  InputDecoration(labelText: 'Enter amount of stocks to $action (Price: ${formatCurrency(double.parse(stock.price))}) '),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  GraphQLService()
                      .buyStock(stock, amount, action)
                      .then((r) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors
                                        .white, // Change the checkmark color to blue
                                  ),
                                  const SizedBox(width: 10),
                                  // Some spacing
                                  Text(
                                    'The transaction was successful with ID: $r',
                                    style: const TextStyle(
                                        color: Colors
                                            .white), // Change text color to white
                                  ),
                                ],
                              ),
                              backgroundColor: Colors
                                  .green, // Change the background color to green
                            ),
                          ))
                      .catchError((error) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.error, color: Colors.red),
                                // Error icon
                                const SizedBox(width: 10),
                                // Some spacing
                                Text(
                                    'An error occurred while saving the transaction: $error'),
                              ],
                            ), // Set the background color to red for error messages
                          )));
                },
                child: const Text('Complete'),
              ),
            ],
          ),
        );
      },
    );
  }
}
