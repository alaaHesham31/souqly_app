import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/data/model/GetCartResponseDm.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/cart_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/secure_storage/secure_storage_utils.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  ApiManager apiManager;

  CartRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, GetCartResponseDm>> getCartItems() async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();

    try {
      if (connectivityResults.contains(ConnectivityResult.mobile) ||
          connectivityResults.contains(ConnectivityResult.wifi)) {
        final token = await SecureStorageUtils.read('token');
        if (token == null) {
          return Left(
              ServerError(errorMessage: 'Missing authentication token'));
        }
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

  @override
  Future<Either<Failures, GetCartResponseDm>> deleteCartItems(
      String productId) async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();

    try {
      if (connectivityResults.contains(ConnectivityResult.mobile) ||
          connectivityResults.contains(ConnectivityResult.wifi)) {
        final token = await SecureStorageUtils.read('token');
        if (token == null) {
          return Left(
              ServerError(errorMessage: 'Missing authentication token'));
        }
        var response = await apiManager.deleteData(
            endPoint: "${EndPoints.addProductToCart}/$productId",
            headers: {'token': token});
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
