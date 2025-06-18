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
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/categories/address/repository/implementation/address_repository_impl.dart'
    as _i437;
import '../../data/categories/address/repository/interface/address_repository.dart'
    as _i344;
import '../../data/categories/app_user/repository/implementation/app_user_repository_impl.dart'
    as _i904;
import '../../data/categories/app_user/repository/interface/app_user_repository.dart'
    as _i749;
import '../../data/categories/post/repository/implementation/remote_post_repository_impl.dart'
    as _i95;
import '../../data/categories/post/repository/interface/post_repository.dart'
    as _i480;
import '../../data/services/authentication_service/implementation/firebase_authentication_service_impl.dart'
    as _i80;
import '../../data/services/authentication_service/interface/authentication_service.dart'
    as _i780;
import '../../data/services/database_service/implementation/firestore_service_impl.dart'
    as _i85;
import '../../data/services/database_service/interface/database_service.dart'
    as _i4;
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
import '../../ui/features/account_setup/bloc/account_setup_bloc.dart' as _i658;
import '../../ui/features/auth/bloc/auth_bloc.dart' as _i511;
import '../../ui/features/camera/bloc/camera_bloc.dart' as _i889;
import '../../ui/features/current_address/bloc/current_address_bloc.dart'
    as _i150;
import '../../ui/features/dining_info_input/bloc/dining_info_input_bloc.dart'
    as _i592;
import '../../ui/features/user_info/bloc/user_info_bloc.dart' as _i973;
import '../../utils/image_processor.dart' as _i1028;
import '../infrastructure/firebase_injectable_module.dart' as _i965;

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
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.factory<_i258.GeolocatorWrapper>(() => _i258.GeolocatorWrapper());
  gh.factory<_i592.DiningInfoInputBloc>(() => _i592.DiningInfoInputBloc());
  gh.lazySingleton<_i116.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<_i59.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i1028.ImageProcessor>(() => _i1028.ImageProcessor());
  gh.lazySingleton<_i480.PostRepository>(() => _i95.RemotePostRepositoryImpl());
  gh.factory<_i889.CameraBloc>(
      () => _i889.CameraBloc(imageProcessor: gh<_i1028.ImageProcessor>()));
  gh.lazySingleton<_i780.AuthenticationService>(
      () => _i80.FirebaseAuthenticationService(
            gh<_i116.GoogleSignIn>(),
            gh<_i59.FirebaseAuth>(),
          ));
  gh.lazySingleton<_i766.GeocodingService>(
      () => _i3.GeocodingServiceNominatimImpl());
  gh.lazySingleton<_i4.DatabaseService>(
      () => _i85.FirestoreServiceImpl(gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i473.LocationService>(() => _i437.GeolocatorServiceImpl(
      geolocatorWrapper: gh<_i258.GeolocatorWrapper>()));
  gh.lazySingleton<_i344.AddressRepository>(() => _i437.AddressRepositoryImpl(
        locationService: gh<_i473.LocationService>(),
        geocodingService: gh<_i766.GeocodingService>(),
      ));
  gh.factory<_i150.CurrentAddressBloc>(() => _i150.CurrentAddressBloc(
      addressRepository: gh<_i344.AddressRepository>()));
  gh.lazySingleton<_i749.AppUserRepository>(() => _i904.UserRepositoryImpl(
        gh<_i780.AuthenticationService>(),
        gh<_i4.DatabaseService>(),
      ));
  gh.factory<_i973.UserInfoBloc>(
      () => _i973.UserInfoBloc(gh<_i749.AppUserRepository>()));
  gh.factory<_i658.AccountSetupBloc>(() =>
      _i658.AccountSetupBloc(appUserRepository: gh<_i749.AppUserRepository>()));
  gh.factory<_i511.AuthBloc>(
      () => _i511.AuthBloc(userRepository: gh<_i749.AppUserRepository>()));
  return getIt;
}

class _$FirebaseInjectableModule extends _i965.FirebaseInjectableModule {}
