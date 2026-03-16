import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_facade.dart';
import 'features/shops/data/datasources/shop_remote_data_source.dart';
import 'features/shops/data/repositories/shop_repository_impl.dart';
import 'features/shops/domain/repositories/shop_repository.dart';
import 'features/shops/presentation/bloc/shop_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Core services
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Network
  getIt.registerSingleton<NetworkFacadeInterface>(NetworkFacade());

  // Shops
  getIt.registerLazySingleton<ShopRemoteDataSource>(
    () => ShopRemoteDataSourceImpl(getIt<NetworkFacadeInterface>()));

  getIt.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(remoteDataSource: getIt<ShopRemoteDataSource>()));

  getIt.registerFactory<ShopCubit>(
    () => ShopCubit(getIt<ShopRepository>()));
}