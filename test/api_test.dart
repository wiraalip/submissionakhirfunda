import 'package:flutter_test/flutter_test.dart';

import 'package:submission2/apiservice/apiservice.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:submission2/models/detailclass.dart' as detail;
import 'package:submission2/models/listclass.dart' as list;

class ApiTest extends Mock implements http.Client {}

main() {
  ApiTest client;
  Service apiService;

  final dummyListJsonInString = list.Welcome(
      error: false,
      message: "message",
      count: 1,
      restaurants: <list.Restaurant>[]);

  client = ApiTest();
  apiService = Service(client);

  setUp(() {
    client = ApiTest();
    apiService = Service(client);
  });

  group("fetchAllRestaurant", () {
    test("should request complate", () async {
      when(
        client.get(Uri.parse("https://restaurant-api.dicoding.dev/list")),
      ).thenAnswer(
        (_) async => http.Response(dummyListJsonInString.toString(), 200),
      );

      final result = await apiService.getAllData();
      expect(result, isA<list.Welcome>());
    });

    test("should request failed", () async {
      when(
        client.get(Uri.parse("https://restaurant-api.dicoding.dev/list")),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      final call = apiService.getAllData();
      expect(() => call, throwsA(isInstanceOf<Exception>()));
    });
  });

  group("fetchDetailRestaurant", () {
    test("should request complate", () async {
      when(
        client.get(Uri.parse(
            "https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867")),
      ).thenAnswer(
        (_) async => http.Response(dummyListJsonInString.toString(), 200),
      );

      expect(await apiService.getAllDetail("rqdv5juczeskfw1e867"),
          isA<detail.DetailRestaurantResult>());
    });

    test("should request failed", () async {
      when(
        client.get(Uri.parse(
            "https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867")),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      final call = apiService.getAllDetail("rqdv5juczeskfw1e867");
      expect(() => call, throwsA(isInstanceOf<Exception>()));
    });
  });
}
