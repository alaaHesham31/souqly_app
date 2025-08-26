import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/shared_prefrences/shared_preferences_utils.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/data/model/GetCartResponseDm.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/cart_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  ApiManager apiManager;

  CartRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, GetCartResponseDm>> getCartItems() async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    var token = SharedPreferencesUtils.getString('token');

    try {
      if (connectivityResults.contains(ConnectivityResult.mobile) ||
          connectivityResults.contains(ConnectivityResult.wifi)) {
        var response = await apiManager.getData(
            endPoint: EndPoints.addProductToCart, headers: {'token': token});
        var cartItemsResponse = GetCartResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 || response.statusCode! < 300) {
          return Right(cartItemsResponse);
        } else {
          return Left(ServerError(errorMessage: cartItemsResponse.message!));
        }
      } else {
        return Left(
            NetworkError(errorMessage: 'Check your Internet Connection'));
      }
    } catch (e) {
      return Left(Failures(errorMessage: e.toString()));
    }
  }
}
