import 'dart:async';

import 'package:algoliasearch/algoliasearch.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/services/search_service/exception/search_service_exception.dart';
import 'package:dishlocal/data/services/search_service/interface/search_service.dart';
import 'package:dishlocal/data/services/search_service/model/search_result.dart';
import 'package:dishlocal/data/services/search_service/model/suggestion_result.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: SearchService)
class AlgoliaSearchServiceImpl implements SearchService {
  final _log = Logger('AlgoliaSearchServiceImpl');
  final SearchClient _searchClient = SearchClient(
    appId: AppEnvironment.algoliaAppId,
    apiKey: AppEnvironment.algoliaApiKey,
  );

  AlgoliaSearchServiceImpl() {
    _log.info('AlgoliaSearchServiceImpl initialized. App ID: ${AppEnvironment.algoliaAppId}');
  }

  @override
  Future<SearchResult> search({
    required String query,
    required SearchableItem searchType,
    int page = 0,
    int hitsPerPage = 20,
  }) async {
    _log.fine(
      'Starting search for query: "$query" in type: ${searchType.name} '
      '| page: $page | hitsPerPage: $hitsPerPage',
    );

    if (query.trim().isEmpty) {
      _log.warning('Search query is empty. Throwing InvalidSearchQueryException.');
      throw InvalidSearchQueryException('Truy vấn tìm kiếm không được để trống.');
    }

    final String indexName;
    switch (searchType) {
      case SearchableItem.posts:
        indexName = 'posts';
        break;
      case SearchableItem.profiles:
        indexName = 'profiles';
        break;
    }
    _log.finer('Using Algolia index: "$indexName"');

    try {
      // --- THAY ĐỔI QUAN TRỌNG Ở ĐÂY ---
      // 1. Tạo một đối tượng SearchForHits để chứa tất cả các tham số tìm kiếm
      final searchRequest = SearchForHits(
        indexName: indexName,
        query: query,
        page: page,
        hitsPerPage: hitsPerPage,
      );

      // 2. Gọi API và truyền đối tượng vừa tạo vào tham số `request`
      final response = await _searchClient.searchIndex(
        request: searchRequest,
      );
      // ------------------------------------

      _log.info(
        'Search successful. Found ${response.nbHits} hits '
        'in ${response.processingTimeMS}ms.',
      );

      return SearchResult(
          totalPage: response.nbPages,
          totalHits: response.nbHits,
          currentPage: response.page,
          objectIds: response.hits
              .map(
                (hit) => hit.objectID,
              )
              .toList());
    } on AlgoliaApiException catch (e, stackTrace) {
      _log.severe(
        'Algolia API Error! Status: ${e.statusCode}, Message: ${e.error}',
        e,
        stackTrace,
      );
      switch (e.statusCode) {
        case 401:
        case 403:
          throw SearchAuthenticationException(e.error.toString());
        case 404:
          throw SearchIndexNotFoundException(indexName, e.error.toString());
        case 429:
          throw SearchRateLimitException(e.error.toString());
        default:
          throw UnknownSearchApiException(
            message: e.error.toString(),
            statusCode: e.statusCode,
          );
      }
    } on AlgoliaTimeoutException catch (e, stackTrace) {
      _log.severe('Algolia request timed out.', e, stackTrace);
      throw SearchConnectionException('Yêu cầu tìm kiếm đã hết thời gian chờ.');
    } on AlgoliaIOException catch (e, stackTrace) {
      _log.severe('Algolia IO error occurred.', e, stackTrace);
      throw SearchConnectionException('Đã xảy ra lỗi mạng trong khi tìm kiếm.');
    } on UnreachableHostsException catch (e, stackTrace) {
      _log.severe(
        'All Algolia hosts are unreachable. Errors: ${e.errors}',
        e,
        stackTrace,
      );
      throw SearchConnectionException('Không thể kết nối đến máy chủ tìm kiếm.');
    } on AlgoliaException catch (e, stackTrace) {
      _log.severe(
        'An unhandled Algolia exception occurred.',
        e,
        stackTrace,
      );
      throw UnknownSearchApiException(message: e.toString());
    } on Exception catch (e, stackTrace) {
      _log.severe(
        'An unexpected generic error occurred during search.',
        e,
        stackTrace,
      );
      throw UnknownSearchApiException(message: 'Đã có lỗi không mong muốn xảy ra.');
    }
  }

  @override
  Future<SuggestionResult> getSuggestions({
    required String query,
    required SearchableItem searchType,
    int hitsPerPage = 5,
  }) async {
    _log.fine('Starting suggestion search for query: "$query" in type: ${searchType.name}');

    if (query.trim().isEmpty) {
      return const SuggestionResult(); // Trả về danh sách rỗng nếu query trống
    }

    final String indexName;
    // Thuộc tính chúng ta muốn lấy về.
    final List<String> attributesToRetrieve;
    final SuggestionType suggestionType;

    switch (searchType) {
      case SearchableItem.posts:
        indexName = 'posts';
        // Chỉ lấy về trường 'dishName'
        attributesToRetrieve = ['dishName'];
        suggestionType = SuggestionType.post;
        break;
      case SearchableItem.profiles:
        indexName = 'profiles';
        // Chỉ lấy về 'username' và 'displayName'
        attributesToRetrieve = ['username', 'displayName'];
        suggestionType = SuggestionType.profile;
        break;
    }

    try {
      final searchRequest = SearchForHits(
        indexName: indexName,
        query: query,
        page: 0, // Gợi ý luôn là trang đầu tiên
        hitsPerPage: hitsPerPage,
        // --- TỐI ƯU HÓA QUAN TRỌNG ---
        // Yêu cầu Algolia chỉ trả về các thuộc tính này.
        attributesToRetrieve: attributesToRetrieve,
        // Không cần lấy các thuộc tính highlight hoặc snippet.
        attributesToHighlight: [],
        attributesToSnippet: [],
      );

      final response = await _searchClient.searchIndex(request: searchRequest);

      // Xử lý kết quả trả về
      final suggestions = response.hits
          .map((hit) {
            String displayText = '';
            if (suggestionType == SuggestionType.post) {
              displayText = hit['dishName'] as String? ?? '';
            } else if (suggestionType == SuggestionType.profile) {
              // Ưu tiên displayName, nếu không có thì dùng username
              displayText = hit['displayName'] as String? ?? hit['username'] as String? ?? '';
            }

            return Suggestion(
              displayText: displayText,
              type: suggestionType,
            );
          })
          .where((s) => s.displayText.isNotEmpty)
          .toList(); // Lọc ra các gợi ý rỗng

      return SuggestionResult(suggestions: suggestions);
    } on Exception catch (e, st) {
      // Bọc lỗi để không làm crash app, chỉ đơn giản là không hiển thị gợi ý.
      _log.severe('Error fetching suggestions for query "$query". Error: $e', e, st);
      // Trả về kết quả rỗng khi có lỗi.
      return const SuggestionResult();
    }
  }
}
