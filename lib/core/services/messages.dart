import 'dart:async';

import 'package:campus_mobile_experimental/app_networking.dart';
import 'package:campus_mobile_experimental/core/models/notifications.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MessageService {
  final String myMessagesApiUrl =
      dotenv.env['myMessagesApiUrl']!;
  final String topicsApiUrl =
      dotenv.env['topicsApiUrl']!;

  bool _isLoading = false;
  DateTime? _lastUpdated;
  String? _error;
  Messages? _data;

  final NetworkHelper _networkHelper = NetworkHelper();

  Future<bool> fetchMyMessagesData(
      int? timestamp, Map<String, String> authHeaders) async {
    _error = null;
    _isLoading = true;

    try {
      /// fetch data
      String _response = await _networkHelper.authorizedFetch(
          myMessagesApiUrl + timestamp.toString(), authHeaders);

      /// parse data
      final data = messagesFromJson(_response);
      _isLoading = false;
      _data = data;
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      return false;
    }
  }

  Future<bool> fetchTopicData(int? timestamp, List<String?> topics) async {
    _error = null;
    _isLoading = true;

    String topicsEndpoint = 'topics=' + topics.join(',');
    String timestampEndpoint = '&start=' + timestamp.toString();

    try {
      /// fetch data
      String _response = await _networkHelper
          .fetchData(topicsApiUrl + topicsEndpoint + timestampEndpoint);

      /// parse data
      final data = messagesFromJson(_response);
      _isLoading = false;
      _data = data;
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      return false;
    }
  }

  String? get error => _error;
  Messages? get messagingModels => _data;
  bool get isLoading => _isLoading;
  DateTime? get lastUpdated => _lastUpdated;
}
