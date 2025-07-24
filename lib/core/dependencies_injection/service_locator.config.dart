// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../app/config/app_router.dart' as _i584;
import '../../data/categories/address/repository/implementation/address_repository_impl.dart'
    as _i437;
import '../../data/categories/address/repository/interface/address_repository.dart'
    as _i344;
import '../../data/categories/app_user/model/app_user.dart' as _i640;
import '../../data/categories/app_user/repository/implementation/sql_app_user_repository_impl.dart'
    as _i90;
import '../../data/categories/app_user/repository/interface/app_user_repository.dart'
    as _i749;
import '../../data/categories/chat/repository/implementation/chat_repository_impl.dart'
    as _i760;
import '../../data/categories/chat/repository/interface/chat_repository.dart'
    as _i720;
import '../../data/categories/comment/repository/implementation/remote_comment_repository_sql_impl.dart'
    as _i395;
import '../../data/categories/comment/repository/interface/comment_repository.dart'
    as _i557;
import '../../data/categories/direction/repository/implementation/direction_repository_impl.dart'
    as _i116;
import '../../data/categories/direction/repository/interface/direction_repository.dart'
    as _i93;
import '../../data/categories/generated_content/repository/implementation/generated_content_repository_impl.dart'
    as _i964;
import '../../data/categories/generated_content/repository/interface/generated_content_repository.dart'
    as _i808;
import '../../data/categories/moderation/repository/implementation/moderation_repository_impl.dart'
    as _i709;
import '../../data/categories/moderation/repository/interface/moderation_repository.dart'
    as _i886;
import '../../data/categories/post/model/post.dart' as _i1028;
import '../../data/categories/post/repository/implementation/remote_post_repository_sql_impl.dart'
    as _i181;
import '../../data/categories/post/repository/interface/post_repository.dart'
    as _i480;
import '../../data/global/chat_event_bus.dart' as _i429;
import '../../data/services/authentication_service/implementation/supabase_authentication_service_impl.dart'
    as _i103;
import '../../data/services/authentication_service/interface/authentication_service.dart'
    as _i780;
import '../../data/services/database_service/implementation/no_sql_firestore_service_impl.dart'
    as _i959;
import '../../data/services/database_service/implementation/sql_supabase_service_impl.dart'
    as _i876;
import '../../data/services/database_service/interface/no_sql_database_service.dart'
    as _i60;
import '../../data/services/database_service/interface/sql_database_service.dart'
    as _i178;
import '../../data/services/direction_service/implementation/mapbox_direction_service_impl.dart'
    as _i900;
import '../../data/services/direction_service/interface/direction_service.dart'
    as _i882;
import '../../data/services/distance_service/implementation/haversine_distance_service.dart'
    as _i1015;
import '../../data/services/distance_service/interface/distance_service.dart'
    as _i367;
import '../../data/services/generative_ai_service/implementation/gemini_ai_service_impl.dart'
    as _i36;
import '../../data/services/generative_ai_service/interface/generative_ai_service.dart'
    as _i551;
import '../../data/services/geocoding_service/implementation/geocoding_service_nominatim_impl.dart'
    as _i3;
import '../../data/services/geocoding_service/interface/geocoding_service.dart'
    as _i766;
import '../../data/services/location_service/implementation/geolocator_service_impl.dart'
    as _i437;
import '../../data/services/location_service/implementation/geolocator_wrapper.dart'
    as _i258;
import '../../data/services/location_service/interface/location_service.dart'
    as _i473;
import '../../data/services/moderation_service/implementation/hive_ai_moderation_service_impl.dart'
    as _i709;
import '../../data/services/moderation_service/implementation/sightengine_moderation_service_impl.dart'
    as _i28;
import '../../data/services/moderation_service/interface/moderation_service.dart'
    as _i692;
import '../../data/services/search_service/implementation/algolia_search_service_impl.dart'
    as _i324;
import '../../data/services/search_service/interface/search_service.dart'
    as _i310;
import '../../data/services/storage_service/implementation/cloudinary_storage_service_impl.dart'
    as _i1046;
import '../../data/services/storage_service/interface/storage_service.dart'
    as _i1045;
import '../../data/singleton/app_route_observer.dart' as _i251;
import '../../data/singleton/notification_service.dart' as _i463;
import '../../ui/features/account_setup/bloc/account_setup_bloc.dart' as _i658;
import '../../ui/features/auth/bloc/auth_bloc.dart' as _i511;
import '../../ui/features/camera/bloc/camera_bloc.dart' as _i889;
import '../../ui/features/chat/bloc/chat_bloc.dart' as _i976;
import '../../ui/features/comment/bloc/comment_bloc.dart' as _i510;
import '../../ui/features/conversation_list/bloc/conversation_list_bloc.dart'
    as _i376;
import '../../ui/features/create_post/bloc/create_post_bloc.dart' as _i622;
import '../../ui/features/current_address/bloc/current_address_bloc.dart'
    as _i150;
import '../../ui/features/delete_post/bloc/delete_post_bloc.dart' as _i204;
import '../../ui/features/dish_description/bloc/dish_description_bloc.dart'
    as _i196;
import '../../ui/features/filter_sort/bloc/filter_sort_bloc.dart' as _i441;
import '../../ui/features/follow/bloc/follow_bloc.dart' as _i501;
import '../../ui/features/map/bloc/map_bloc.dart' as _i936;
import '../../ui/features/post_reaction_bar/bloc/post_reaction_bar_bloc.dart'
    as _i144;
import '../../ui/features/result_search/bloc/result_search_bloc.dart' as _i531;
import '../../ui/features/review/bloc/review_bloc.dart' as _i994;
import '../../ui/features/select_food_category/bloc/select_food_category_bloc.dart'
    as _i755;
import '../../ui/features/share_post/cubit/share_post_cubit.dart' as _i133;
import '../../ui/features/suggestion_search/bloc/suggestion_search_bloc.dart'
    as _i679;
import '../../ui/features/user_info/bloc/user_info_bloc.dart' as _i973;
import '../../ui/features/view_post/bloc/view_post_bloc.dart' as _i10;
import '../../ui/global/cubits/cubit/unread_badge_cubit.dart' as _i540;
import '../infrastructure/firebase_injectable_module.dart' as _i965;
import '../utils/image_processor.dart' as _i19;
import '../utils/number_formatter.dart' as _i660;
import '../utils/time_formatter.dart' as _i537;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final thirdPartyModule = _$ThirdPartyModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.factory<_i258.GeolocatorWrapper>(() => _i258.GeolocatorWrapper());
  gh.factory<_i441.FilterSortBloc>(() => _i441.FilterSortBloc());
  gh.factory<_i994.ReviewBloc>(() => _i994.ReviewBloc());
  gh.factory<_i755.SelectFoodCategoryBloc>(
      () => _i755.SelectFoodCategoryBloc());
  gh.lazySingleton<_i583.GoRouter>(() => thirdPartyModule.router);
  gh.lazySingleton<_i116.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<_i59.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i457.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.lazySingleton<_i19.ImageProcessor>(() => _i19.ImageProcessor());
  gh.lazySingleton<_i660.NumberFormatter>(() => _i660.NumberFormatter());
  gh.lazySingleton<_i537.TimeFormatter>(() => _i537.TimeFormatter());
  gh.lazySingleton<_i429.ChatEventBus>(() => _i429.ChatEventBus());
  gh.lazySingleton<_i251.AppRouteObserver>(() => _i251.AppRouteObserver());
  gh.lazySingleton<_i692.ModerationService>(
    () => _i709.HiveAiModerationServiceImpl(),
    instanceName: 'hive.ai',
  );
  gh.lazySingleton<_i882.DirectionService>(
      () => _i900.MapboxDirectionServiceImpl());
  gh.lazySingleton<_i310.SearchService>(() => _i324.AlgoliaSearchServiceImpl());
  gh.lazySingleton<_i367.DistanceService>(
      () => _i1015.HaversineDistanceService());
  gh.lazySingleton<_i1045.StorageService>(
      () => _i1046.CloudinaryStorageServiceImpl());
  gh.lazySingleton<_i551.GenerativeAiService>(() => _i36.GeminiAiServiceImpl());
  gh.lazySingleton<_i720.ChatRepository>(
      () => _i760.ChatRepositoryImpl(gh<_i429.ChatEventBus>()));
  gh.lazySingleton<_i780.AuthenticationService>(
      () => _i103.SupabaseAuthenticationServiceImpl());
  gh.lazySingleton<_i692.ModerationService>(
    () => _i28.SightengineModerationServiceImpl(),
    instanceName: 'sightengine',
  );
  gh.lazySingleton<_i766.GeocodingService>(
      () => _i3.GeocodingServiceNominatimImpl());
  gh.lazySingleton<_i178.SqlDatabaseService>(
      () => _i876.SqlSupabaseServiceImpl());
  gh.lazySingleton<_i886.ModerationRepository>(
      () => _i709.ModerationRepositoryImpl(
            gh<_i692.ModerationService>(instanceName: 'hive.ai'),
            gh<_i692.ModerationService>(instanceName: 'sightengine'),
          ));
  gh.lazySingleton<_i473.LocationService>(() => _i437.GeolocatorServiceImpl(
      geolocatorWrapper: gh<_i258.GeolocatorWrapper>()));
  gh.lazySingleton<_i808.GeneratedContentRepository>(() =>
      _i964.GeneratedContentRepositoryImpl(gh<_i551.GenerativeAiService>()));
  gh.factory<_i133.SharePostCubit>(
      () => _i133.SharePostCubit(gh<_i720.ChatRepository>()));
  gh.factory<_i196.DishDescriptionBloc>(
      () => _i196.DishDescriptionBloc(gh<_i808.GeneratedContentRepository>()));
  gh.lazySingleton<_i93.DirectionRepository>(
      () => _i116.DirectionRepositoryImpl(
            gh<_i882.DirectionService>(),
            gh<_i473.LocationService>(),
          ));
  gh.factory<_i936.MapBloc>(
      () => _i936.MapBloc(gh<_i93.DirectionRepository>()));
  gh.lazySingleton<_i749.AppUserRepository>(() => _i90.SqlAppUserRepositoryImpl(
        gh<_i780.AuthenticationService>(),
        gh<_i178.SqlDatabaseService>(),
        gh<_i310.SearchService>(),
      ));
  gh.lazySingleton<_i60.NoSqlDatabaseService>(
      () => _i959.NoSqlFirestoreServiceImpl(gh<_i974.FirebaseFirestore>()));
  gh.factory<_i658.AccountSetupBloc>(() =>
      _i658.AccountSetupBloc(appUserRepository: gh<_i749.AppUserRepository>()));
  gh.lazySingleton<_i480.PostRepository>(
      () => _i181.RemotePostRepositorySqlImpl(
            gh<_i1045.StorageService>(),
            gh<_i178.SqlDatabaseService>(),
            gh<_i367.DistanceService>(),
            gh<_i473.LocationService>(),
            gh<_i780.AuthenticationService>(),
            gh<_i766.GeocodingService>(),
            gh<_i310.SearchService>(),
          ));
  gh.lazySingleton<_i344.AddressRepository>(() => _i437.AddressRepositoryImpl(
        gh<_i473.LocationService>(),
        gh<_i766.GeocodingService>(),
      ));
  gh.lazySingleton<_i540.UnreadBadgeCubit>(() => _i540.UnreadBadgeCubit(
        gh<_i720.ChatRepository>(),
        gh<_i429.ChatEventBus>(),
      ));
  gh.factoryParam<_i501.FollowBloc, _i640.AppUser, dynamic>((
    user,
    _,
  ) =>
      _i501.FollowBloc(
        gh<_i749.AppUserRepository>(),
        user,
      ));
  gh.factory<_i889.CameraBloc>(() => _i889.CameraBloc(
        gh<_i886.ModerationRepository>(),
        gh<_i19.ImageProcessor>(),
      ));
  gh.factory<_i679.SuggestionSearchBloc>(
      () => _i679.SuggestionSearchBloc(gh<_i310.SearchService>()));
  gh.lazySingleton<_i463.NotificationService>(() => _i463.NotificationService(
        gh<_i749.AppUserRepository>(),
        gh<_i251.AppRouteObserver>(),
        gh<_i583.GoRouter>(),
      ));
  gh.factory<_i376.ConversationListBloc>(() => _i376.ConversationListBloc(
        gh<_i540.UnreadBadgeCubit>(),
        gh<_i463.NotificationService>(),
      ));
  gh.factoryParam<_i144.PostReactionBarBloc, _i1028.Post, dynamic>((
    post,
    _,
  ) =>
      _i144.PostReactionBarBloc(
        gh<_i480.PostRepository>(),
        gh<_i749.AppUserRepository>(),
        post,
      ));
  gh.factory<_i973.UserInfoBloc>(
      () => _i973.UserInfoBloc(gh<_i749.AppUserRepository>()));
  gh.lazySingleton<_i557.CommentRepository>(
      () => _i395.RemoteCommentRepositorySqlImpl(
            gh<_i178.SqlDatabaseService>(),
            gh<_i780.AuthenticationService>(),
            gh<_i692.ModerationService>(instanceName: 'hive.ai'),
          ));
  gh.factory<_i976.ChatBloc>(() => _i976.ChatBloc(
        gh<_i720.ChatRepository>(),
        gh<_i749.AppUserRepository>(),
        gh<_i480.PostRepository>(),
      ));
  gh.factory<_i511.AuthBloc>(() => _i511.AuthBloc(
        gh<_i749.AppUserRepository>(),
        gh<_i720.ChatRepository>(),
        gh<_i540.UnreadBadgeCubit>(),
      ));
  gh.factory<_i622.CreatePostBloc>(() => _i622.CreatePostBloc(
        gh<_i480.PostRepository>(),
        gh<_i749.AppUserRepository>(),
        gh<_i886.ModerationRepository>(),
      ));
  gh.factory<_i531.ResultSearchBloc>(() => _i531.ResultSearchBloc(
        gh<_i480.PostRepository>(),
        gh<_i749.AppUserRepository>(),
      ));
  gh.factory<_i10.ViewPostBloc>(() => _i10.ViewPostBloc(
        gh<_i480.PostRepository>(),
        gh<_i749.AppUserRepository>(),
      ));
  gh.factory<_i150.CurrentAddressBloc>(() => _i150.CurrentAddressBloc(
      addressRepository: gh<_i344.AddressRepository>()));
  gh.factory<_i204.DeletePostBloc>(
      () => _i204.DeletePostBloc(gh<_i480.PostRepository>()));
  gh.factory<_i510.CommentBloc>(() => _i510.CommentBloc(
        gh<_i749.AppUserRepository>(),
        gh<_i557.CommentRepository>(),
      ));
  return getIt;
}

class _$ThirdPartyModule extends _i584.ThirdPartyModule {}

class _$FirebaseInjectableModule extends _i965.FirebaseInjectableModule {}
