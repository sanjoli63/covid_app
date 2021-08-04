import 'package:covid_app/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int? value;

  const EndpointCard({Key? key, required this.endpoint, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Text(
            'cases',
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            value.toString(),
          ),
        ],
      ),
    );
  }
}
