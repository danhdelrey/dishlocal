import 'dart:async';

import 'package:algoliasearch/algoliasearch.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/data/services/search_service/exception/search_service_exception.dart';
import 'package:dishlocal/data/services/search_service/interface/search_service.dart';
import 'package:dishlocal/data/services/search_service/model/search_result.dart';
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
    FilterSortParams? filterParams,
    String? latLongForGeoSearch,
  }) async {
    _log.fine(
      'Starting search for query: "$query" in type: ${searchType.name} '
      '| page: $page | hitsPerPage: $hitsPerPage',
    );

    if (query.trim().isEmpty) {
      _log.warning('Search query is empty. Throwing InvalidSearchQueryException.');
      throw InvalidSearchQueryException('Truy vấn tìm kiếm không được để trống.');
    }

    String indexName;
    if (searchType == SearchableItem.posts && filterParams != null) {
      // Logic chọn replica index dựa trên tùy chọn sắp xếp
      switch (filterParams.sortOption.field) {
        case SortField.likes:
          indexName = filterParams.sortOption.direction == SortDirection.desc ? 'posts_like_count_desc' : 'posts_like_count_asc';
          break;
        case SortField.datePosted:
          indexName = filterParams.sortOption.direction == SortDirection.desc ? 'posts' : 'posts_created_at_asc'; // Giả sử index chính sắp xếp theo ngày đăng giảm dần
          break;
        // ... thêm các case khác cho save_count, comment_count
        default:
          indexName = 'posts'; // Fallback về index chính
      }
    } else {
      // Giữ nguyên logic cũ cho tìm kiếm profile hoặc post không có filter
      indexName = (searchType == SearchableItem.posts) ? 'posts' : 'profiles';
    }
    _log.finer('Using Algolia index: "$indexName"');

    // --- XÂY DỰNG BỘ LỌC CHO ALGOLIA ---
    final List<String> filters = [];
    if (filterParams != null) {
      // 1. Lọc giá
      if (filterParams.range != null) {
        filters.add('price >= ${filterParams.range!.minPrice}');
        if (filterParams.range!.maxPrice != double.infinity) {
          filters.add('price < ${filterParams.range!.maxPrice}');
        }
      }
      // 2. Lọc category
      if (filterParams.categories.isNotEmpty) {
        final categoryFilters = filterParams.categories.map((c) => "food_category:'${c.name}'").join(' OR ');
        filters.add('($categoryFilters)');
      }
    }

    try {
      final searchRequest = SearchForHits(
        indexName: indexName,
        query: query,
        page: page,
        hitsPerPage: hitsPerPage,
        // THÊM MỚI: Gắn bộ lọc vào request
        filters: filters.join(' AND '),
        // THÊM MỚI: Lọc theo vị trí
        aroundLatLng: (filterParams?.distance != null)
            ? latLongForGeoSearch
            : null,
        aroundRadius: (filterParams?.distance != null) ? filterParams!.distance!.maxDistance.toInt() : null,
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

  
}
