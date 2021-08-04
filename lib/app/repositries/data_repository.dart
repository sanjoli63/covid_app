import 'package:covid_app/app/repositries/endpoints_data.dart';
import 'package:covid_app/app/services/api.dart';
import 'package:covid_app/app/services/api_services.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({required this.apiService});
  final APIService apiService;
  String? _accessToken;
  Future<int> getEndpointData(Endpoint endpoint) async =>
      await _getDataRefreshingToken<int>(
        onGetData: () => apiService.getEndpointData(
            accessToken: _accessToken, endpoint: endpoint),
      );

  Future<EndpointsData> getAllEndpointData() async =>
      await _getDataRefreshingToken<EndpointsData>(
        onGetData: () => _getAllEndpointData(),
      );

  Future<T> _getDataRefreshingToken<T>(
      {Future<T> Function()? onGetData}) async {
    try {
      _accessToken = await apiService.getAccessToken();
      return await onGetData!();
    } on Response catch (response) {
      // if unauthorized, get access token again
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData!();
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointData() async {
    final values = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);
    return EndpointsData(
      values: {
        Endpoint.cases: values[0],
        Endpoint.casesSuspected: values[1],
        Endpoint.casesConfirmed: values[2],
        Endpoint.deaths: values[3],
        Endpoint.recovered: values[4],
      },
    );
  }
}
