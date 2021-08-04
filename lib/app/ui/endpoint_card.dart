import 'package:covid_app/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int? value;

  const EndpointCard({Key? key, required this.endpoint, required this.value})
      : super(key: key);

  static Map<Endpoint, String> _cardsTitles = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'casesSuspected',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _cardsTitles[endpoint],
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                value != null ? value.toString() : '',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
