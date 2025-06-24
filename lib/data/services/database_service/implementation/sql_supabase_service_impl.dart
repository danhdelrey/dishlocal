import 'dart:io';

import 'package:dishlocal/data/services/database_service/exception/sql_database_service_exception.dart';
import 'package:dishlocal/data/services/database_service/interface/sql_database_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: SqlDatabaseService)
class SqlSupabaseServiceImpl implements SqlDatabaseService {
  final _log = Logger('SqlSupabaseServiceImpl');
  final _supabase = Supabase.instance.client;

  /// Bọc một thao tác cơ sở dữ liệu để xử lý và chuyển đổi lỗi một cách nhất quán.
  Future<T> _wrapDbOperation<T>(String operationName, Future<T> Function() operation) async {
    try {
      // 🚀 Bắt đầu thực thi, không có lỗi nào được ghi nhận tại thời điểm này.
      return await operation();
    } on PostgrestException catch (e, st) {
      _log.severe('_wrapDbOperation(): 🚨 PostgrestException trong [$operationName]', e, st);
      _handlePostgrestException(e); // Sẽ luôn ném ra lỗi, không bao giờ trả về
    } on SocketException catch (e, st) {
      _log.severe('_wrapDbOperation(): 🕸️ Lỗi mạng (SocketException) trong [$operationName]', e, st);
      throw DatabaseConnectionException();
    } on TypeError catch (e, st) {
      _log.severe('_wrapDbOperation(): 🧩 Lỗi phân tích dữ liệu (TypeError) trong [$operationName]', e, st);
      throw DataParsingException(e.toString());
    } catch (e, st) {
      _log.severe('_wrapDbOperation(): ❓ Lỗi không xác định trong [$operationName]', e, st);
      throw UnknownDatabaseException(e.toString());
    }
  }

  @override
  Future<T> create<T>({
    required String tableName,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    final operationName = 'CREATE in "$tableName"';
    return _wrapDbOperation(operationName, () async {
      _log.info('create(): ➡️ $operationName: Bắt đầu tạo bản ghi mới.');
      final result = await _supabase.from(tableName).insert(data).select().single();

      _log.info('create(): ✅ $operationName: Tạo bản ghi thành công!');
      return fromJson(result);
    });
  }

  @override
  Future<List<T>> readList<T>({
    required String tableName,
    required T Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic>? filters,
    OrderBy? orderBy,
  }) {
    final operationName = 'READ LIST from "$tableName"';
    return _wrapDbOperation(operationName, () async {
      _log.info('readList(): ➡️ $operationName: Bắt đầu truy vấn danh sách. Filters: $filters, OrderBy: ${orderBy?.column}');

      // [FIXED] Bắt đầu với kiểu 'PostgrestFilterBuilder' cụ thể.
      // Sử dụng 'var' để Dart tự suy luận kiểu này.
      var query = _supabase.from(tableName).select();

      // 1. Áp dụng tất cả các bộ lọc.
      // Tại đây, 'query' vẫn luôn là 'PostgrestFilterBuilder'.
      if (filters != null) {
        _log.info('readList(): 🔍 $operationName: Áp dụng bộ lọc...');
        for (var filter in filters.entries) {
          query = query.eq(filter.key, filter.value);
        }
      }

      // 2. Tại thời điểm await, quyết định xem có cần sắp xếp hay không.
      // Cách này đảm bảo kiểu dữ liệu luôn đúng ở mọi bước.
      final result = await (orderBy != null
          ? query.order(orderBy.column, ascending: orderBy.ascending) // Nếu có, kết quả của biểu thức này là PostgrestTransformBuilder
          : query); // Nếu không, chính là PostgrestFilterBuilder

      _log.info('readList(): ✅ $operationName: Truy vấn thành công, tìm thấy ${result.length} bản ghi.');
      return result.map((json) => fromJson(json)).toList();
    });
  }

  @override
  Future<T> readSingleById<T>({
    required String tableName,
    required String id,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    final operationName = 'READ SINGLE from "$tableName"';
    return _wrapDbOperation(operationName, () async {
      _log.info('readSingleById(): ➡️ $operationName: Bắt đầu truy vấn bản ghi với ID: $id');
      final result = await _supabase.from(tableName).select().eq('id', id).single();

      _log.info('readSingleById():✅ $operationName: Truy vấn bản ghi ID $id thành công!');
      return fromJson(result);
    });
  }

  @override
  Future<T> update<T>({
    required String tableName,
    required String id,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    return _wrapDbOperation('UPDATE in "$tableName"', () async {
      _log.info('update(): ➡️ UPDATE in "$tableName": Bắt đầu cập nhật bản ghi ID: $id');
      try {
        final response = await _supabase
            .from(tableName)
            .update(data)
            .eq('id', id)
            // 🔥 THAY ĐỔI QUAN TRỌNG:
            // Yêu cầu Supabase trả về bản ghi MỚI NHẤT sau khi update.
            .select()
            .single(); // .single() sẽ đảm bảo chỉ có 1 dòng và trả về dưới dạng Map

        _log.info('update(): ✅ UPDATE in "$tableName": Cập nhật và lấy lại bản ghi ID $id thành công!');
        return fromJson(response); // Chuyển đổi dữ liệu mới nhất và trả về
      } catch (e) {
        // Bắt lỗi và ném lại để _wrapDbOperation xử lý
        throw _handlePostgrestException(e as PostgrestException);
      }
    });
  }

  @override
  Future<void> delete({required String tableName, required String id}) {
    final operationName = 'DELETE from "$tableName"';
    return _wrapDbOperation(operationName, () async {
      _log.info('delete(): ➡️ $operationName: Bắt đầu xóa bản ghi ID: $id');
      await _supabase.from(tableName).delete().eq('id', id);
      _log.info('delete(): ✅ $operationName: Xóa bản ghi ID $id thành công!');
    });
  }

  // --- Helper để phân tích lỗi ---
  Never _handlePostgrestException(PostgrestException e) {
    _log.severe('💥 Bắt đầu phân tích PostgrestException: code=${e.code}, message=${e.message}, details=${e.details}');

    if (e.code == 'PGRST116') {
      _log.info('_handlePostgrestException(): 🗺️ Mapping [PGRST116] to RecordNotFoundException.');
      throw RecordNotFoundException(recordType: 'unknown', recordId: 'unknown');
    }
    if (e.code == '23505') {
      final fieldName = _extractFieldNameFromDetail(e.details.toString()) ?? 'unknown';
      _log.info('_handlePostgrestException(): 🗺️ Mapping [23505] to UniqueConstraintViolationException for field "$fieldName".');
      throw UniqueConstraintViolationException(fieldName: fieldName, value: 'đã tồn tại');
    }
    if (e.code == '23503') {
      final fieldName = _extractFieldNameFromDetail(e.details.toString()) ?? 'unknown';
      _log.info('_handlePostgrestException(): 🗺️ Mapping [23503] to ForeignKeyConstraintViolationException for field "$fieldName".');
      throw ForeignKeyConstraintViolationException(fieldName: fieldName, referenceTable: 'unknown');
    }
    if (e.code == '23514') {
      final constraintName = _extractConstraintNameFromDetail(e.details.toString()) ?? 'unknown';
      _log.info('_handlePostgrestException(): 🗺️ Mapping [23514] to CheckConstraintViolationException for constraint "$constraintName".');
      throw CheckConstraintViolationException(fieldName: 'unknown', constraintName: constraintName);
    }
    if (e.message.contains('violates row-level security policy')) {
      _log.info('_handlePostgrestException(): 🗺️ Mapping RLS violation message to PermissionDeniedException.');
      throw PermissionDeniedException();
    }

    _log.severe('_handlePostgrestException(): ❓ Không thể map PostgrestException. Ném ra lỗi UnknownDatabaseException.');
    throw UnknownDatabaseException(e.message);
  }

  String? _extractFieldNameFromDetail(String detail) {
    final match = RegExp(r'\((.*?)\)').firstMatch(detail);
    return match?.group(1);
  }

  String? _extractConstraintNameFromDetail(String detail) {
    final match = RegExp(r'violates check constraint "(.*?)"').firstMatch(detail);
    return match?.group(1);
  }

  @override
  Future<void> rpc(String functionName, {Map<String, dynamic>? params}) async {
    await _supabase.rpc(functionName, params: params);
  }
}
