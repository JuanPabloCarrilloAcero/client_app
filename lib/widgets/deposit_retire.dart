import 'package:flutter/cupertino.dart';

class DepositRetireWidget extends StatelessWidget{
  const DepositRetireWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text('Deposit/Retire'),
      ),
    );
  }

}