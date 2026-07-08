import 'package:dio/dio.dart';
import 'package:momentum/features/sync/data/models/sync_record_model.dart';

class SyncRemoteDatasource {
  SyncRemoteDatasource(this._dio);

  final Dio _dio;

  Future<PushResponse> push(List<SyncRecordModel> records) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/sync/push',
      data: {'records': records.map((r) => r.toJson()).toList()},
    );
    return PushResponse.fromJson(res.data!);
  }

  Future<PullResponse> pull({String? since}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/sync/pull',
      queryParameters: {'since': since}..removeWhere((_, v) => v == null),
    );
    return PullResponse.fromJson(res.data!);
  }
}
