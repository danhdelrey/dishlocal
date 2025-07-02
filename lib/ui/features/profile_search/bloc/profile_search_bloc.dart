import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

part 'profile_search_event.dart';
part 'profile_search_bloc.freezed.dart';

// State của BLoC này chính là PagingState
typedef ProfileSearchState = PagingState<int, AppUser>;

@injectable
class ProfileSearchBloc extends Bloc<ProfileSearchEvent, ProfileSearchState> {
  final _log = Logger('ProfileSearchBloc');
  final AppUserRepository _appUserRepository;
  static const int _hitsPerPage = 15;

  String _currentQuery = '';

  ProfileSearchBloc(this._appUserRepository) : super(ProfileSearchState()) {
    on<_SearchStarted>((event, emit) {
      _log.info('🚀 Bắt đầu tìm kiếm profile với query: "${event.query}"');
      _currentQuery = event.query;
      emit(ProfileSearchState());
      add(const ProfileSearchEvent.nextPageRequested());
    });

    on<_NextPageRequested>((event, emit) async {
      if (_currentQuery.isEmpty || !state.hasNextPage || state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      final pageToFetch = state.pages?.length ?? 0;
      _log.info('📥 Đang tải trang profile số $pageToFetch...');

      final result = await _appUserRepository.searchProfiles(
        query: _currentQuery,
        page: pageToFetch,
        hitsPerPage: _hitsPerPage,
      );

      result.fold(
        (failure) {
          _log.severe('❌ Lỗi khi tìm kiếm profile: $failure');
          emit(state.copyWith(error: failure, isLoading: false));
        },
        (newProfiles) {
          final isLastPage = newProfiles.length < _hitsPerPage;
          _log.info('✅ Tải được ${newProfiles.length} profile. isLastPage=$isLastPage');

          emit(state.copyWith(
            pages: [...?state.pages, newProfiles],
            hasNextPage: !isLastPage,
            isLoading: false,
          ));
        },
      );
    }, transformer: (events, mapper) => events.throttleTime(const Duration(milliseconds: 300)).asyncExpand(mapper));
  }
}
