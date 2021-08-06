import 'package:covid_app/app/repositries/data_repository.dart';
import 'package:covid_app/app/repositries/endpoints_data.dart';
import 'package:covid_app/app/services/api.dart';
import 'package:covid_app/app/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData? _endpointsData;
  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository.getAllEndpointData();
    setState(() => _endpointsData = endpointsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coronavirus Tracker"),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData!.values[endpoint]!,
              ),
          ],
        ),
      ),
    );
  }
}
