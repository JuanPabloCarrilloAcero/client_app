import 'package:client_app/services/graphql_service.dart';
import 'package:flutter/material.dart';

import '../../custom/custom_currency_input.dart';

class DepositRetireFormWidget extends StatefulWidget {
  const DepositRetireFormWidget({Key? key}) : super(key: key);

  @override
  State<DepositRetireFormWidget> createState() =>
      _DepositRetireFormWidgetState();
}

class _DepositRetireFormWidgetState extends State<DepositRetireFormWidget> {
  bool _isRetire = false;
  String _amount = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Deposit'),
              Switch(
                value: _isRetire,
                onChanged: (value) {
                  setState(() {
                    _isRetire = value;
                  });
                },
              ),
              //TODO: Add real balance by user
              const Text('Retire (Balance: \$0.00)'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: TextFormField(
                inputFormatters: [CurrencyInputFormatter()],
                // Use the custom formatter
                decoration: const InputDecoration(
                  labelText: 'Amount (USD)',
                  hintText:
                      '\$0.00', // Display a default value or an initial format
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _amount = value;
                  });
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              GraphQLService()
                  .depositRetire(_isRetire, _amount)
                  .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(
                                Icons.check,
                                color: Colors
                                    .white, // Change the checkmark color to blue
                              ),
                              const SizedBox(width: 10), // Some spacing
                              Text(
                                'The transaction was successful with ID: $value',
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
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
