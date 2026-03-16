import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_facade.dart';
import 'features/shops/data/data_sources/shop_remote_data_source.dart';
import 'features/shops/data/repositories/shop_repository_impl.dart';
import 'features/shops/domain/repositories/shop_repository.dart';
import 'features/shops/domain/use_cases/filter_shops.dart';
import 'features/shops/domain/use_cases/sort_shops.dart';
import 'features/shops/presentation/bloc/shop_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Core services
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Network
  getIt.registerSingleton<NetworkFacadeInterface>(NetworkFacade());

  // Shops — data layer
  getIt.registerLazySingleton<ShopRemoteDataSource>(
    () => ShopRemoteDataSourceImpl(getIt<NetworkFacadeInterface>()));

  getIt.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(remoteDataSource: getIt<ShopRemoteDataSource>()));

  // Shops — domain use cases (stateless, safe as singletons)
  getIt.registerLazySingleton<FilterShopsUseCase>(() => const FilterShopsUseCase());
  getIt.registerLazySingleton<SortShopsUseCase>(() => const SortShopsUseCase());

  // Shops — BLoC (factory: fresh instance per screen)
  getIt.registerFactory<ShopBloc>(
    () => ShopBloc(
      repository: getIt<ShopRepository>(),
      filterShops: getIt<FilterShopsUseCase>(),
      sortShops: getIt<SortShopsUseCase>(),
    ));
}
