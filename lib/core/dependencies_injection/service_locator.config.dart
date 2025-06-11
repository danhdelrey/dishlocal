// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/categories/address/repository/implementation/address_repository_impl.dart'
    as _i437;
import '../../data/categories/address/repository/interface/address_repository.dart'
    as _i344;
import '../../data/services/geocoding_service/implementation/geocoding_service_impl.dart'
    as _i900;
import '../../data/services/geocoding_service/interface/geocoding_service.dart'
    as _i766;
import '../../data/services/location_service/implementation/geolocator_service_impl.dart'
    as _i437;
import '../../data/services/location_service/interface/location_service.dart'
    as _i473;
import '../../ui/features/camera/bloc/camera_bloc.dart' as _i889;
import '../../ui/features/current_address/bloc/current_address_bloc.dart'
    as _i150;
import '../../utils/image_processor.dart' as _i1028;

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
  gh.factory<_i889.CameraBloc>(() => _i889.CameraBloc());
  gh.lazySingleton<_i1028.ImageProcessor>(() => _i1028.ImageProcessor());
  gh.lazySingleton<_i473.LocationService>(() => _i437.GeolocatorServiceImpl());
  gh.lazySingleton<_i766.GeocodingService>(() => _i900.GeocodingServiceImpl());
  gh.lazySingleton<_i344.AddressRepository>(() => _i437.AddressRepositoryImpl(
        locationService: gh<_i473.LocationService>(),
        geocodingService: gh<_i766.GeocodingService>(),
      ));
  gh.factory<_i150.CurrentAddressBloc>(() => _i150.CurrentAddressBloc(
      addressRepository: gh<_i344.AddressRepository>()));
  return getIt;
}
