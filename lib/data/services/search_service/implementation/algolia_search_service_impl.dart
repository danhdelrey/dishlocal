import 'dart:async';

import 'package:algoliasearch/algoliasearch.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/services/search_service/exception/search_service_exception.dart';
import 'package:dishlocal/data/services/search_service/interface/search_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: SearchService)
class AlgoliaSearchServiceImpl implements SearchService {
  final _log = Logger('AlgoliaSearchServiceImpl');
  final  _searchClient = SearchClient(
    appId: AppEnvironment.algoliaAppId,
    apiKey: AppEnvironment.algoliaApiKey,
  );

  AlgoliaSearchServiceImpl() {
    _log.info('Initializing with App ID: ${AppEnvironment.algoliaAppId}');
  }

  // Helper để chuyển đổi enum sang tên index thực tế
  String _indexName(SearchIndex index) {
    switch (index) {
      case SearchIndex.posts:
        return 'posts'; // Tên index trên dashboard Algolia
      case SearchIndex.profiles:
        return 'profiles'; // Tên index trên dashboard Algolia
    }
  }

  @override
  Future<List<T>> search<T>({
    required String query,
    required SearchIndex index,
    required T Function(Map<String, dynamic> json) fromJson,
    int page = 0,
    int hitsPerPage = 20,
  }) async {
    _log.info('Executing search for "$query" on index "${_indexName(index)}", page: $page, hitsPerPage: $hitsPerPage');

    if (query.trim().isEmpty) {
      _log.warning('Search query is empty or whitespace.');
      throw InvalidSearchQueryException('Truy vấn không được để trống.');
    }

    try {
      final searchRequest = SearchForHits(
        indexName: _indexName(index),
        query: query,
        page: page,
        hitsPerPage: hitsPerPage,
      );

      final response = await _searchClient.searchIndex(request: searchRequest);

      _log.fine('Search successful. Found ${response.nbHits} hits in ${response.processingTimeMS}ms.');

      final hits = response.hits;
      final results = <T>[];
      for (final hit in hits) {
        try {
          results.add(fromJson(hit));
        } on Exception catch (e, stackTrace) {
          _log.severe('Failed to parse a hit object. Error: $e', e, stackTrace);
          throw SearchDataParsingException(
            message: 'Không thể phân tích một đối tượng kết quả: ${e.toString()}',
            originalError: e,
          );
        }
      }
      _log.info('Successfully parsed ${results.length} out of ${hits.length} hits.');
      return results;
    }
    // ---- Bắt đầu khối xử lý lỗi được cập nhật ----

    // 1. Xử lý lỗi API (phổ biến nhất)
    on AlgoliaApiException catch (e, stackTrace) {
      final errorMessage = e.error.toString(); // e.error có thể là Map hoặc String
      final statusCode = e.statusCode;
      _log.severe('Algolia API error: $errorMessage (Status: $statusCode)', e, stackTrace);
      switch (statusCode) {
        case 401:
        case 403:
          throw SearchAuthenticationException(errorMessage);
        case 429:
          throw SearchRateLimitException(errorMessage);
        case 404:
          throw SearchIndexNotFoundException(_indexName(index), errorMessage);
        default:
          throw UnknownSearchApiException(
            message: errorMessage,
            statusCode: statusCode,
          );
      }
    }

    // 2. Xử lý lỗi Timeout
    on AlgoliaTimeoutException catch (e, stackTrace) {
      _log.warning('Algolia request timed out. Error: ${e.error}', e, stackTrace);
      throw SearchConnectionException('Yêu cầu tìm kiếm đã hết hạn.');
    }

    // 3. Xử lý lỗi IO (mạng, kết nối)
    on AlgoliaIOException catch (e, stackTrace) {
      _log.warning('Algolia I/O error (network). Error: ${e.error}', e, stackTrace);
      throw SearchConnectionException('Lỗi kết nối. Vui lòng kiểm tra lại mạng của bạn.');
    }

    // 4. Xử lý lỗi không thể kết nối đến host
    on UnreachableHostsException catch (e, stackTrace) {
      _log.severe('All Algolia hosts are unreachable. Errors: ${e.errors}', e, stackTrace);
      throw SearchConnectionException('Không thể kết nối đến máy chủ tìm kiếm.');
    }

    // 5. Bắt các lỗi khác của Algolia (ít phổ biến hơn)
    on AlgoliaException catch (e, stackTrace) {
      _log.severe('An unhandled Algolia exception occurred.', e, stackTrace);
      throw UnknownSearchApiException(message: 'Đã xảy ra lỗi không xác định từ Algolia: ${e.toString()}');
    }

    // 6. Bắt các lỗi chung của Dart/Flutter
    on Exception catch (e, stackTrace) {
      _log.shout('An unhandled exception occurred during search.', e, stackTrace);
      throw UnknownSearchApiException(message: 'Đã xảy ra lỗi không mong muốn: ${e.toString()}');
    }
  }

  
}
