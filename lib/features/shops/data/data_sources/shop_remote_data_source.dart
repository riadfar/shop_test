import '../../../../core/config/env_config.dart';
import '../../../../core/network/network_facade.dart';
import '../models/shop_model.dart';

abstract class ShopRemoteDataSource {
  Future<List<ShopModel>> getShops();
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {
  final NetworkFacadeInterface networkFacade;

  const ShopRemoteDataSourceImpl(this.networkFacade);

  static const _url = 'https://api.orianosy.com/shop/test/find/all/shop';

  @override
  Future<List<ShopModel>> getShops() async {
    final data = await networkFacade.get<Map<String, dynamic>>(
      _url,
      queryParameters: {'deviceKind': 'android'},
      headers: {'secretKey': EnvConfig.secretKey},
    );

    final result = data['result'] as List<dynamic>? ?? [];
    return result.cast<Map<String, dynamic>>().map(ShopModel.fromJson).toList();
  }
}