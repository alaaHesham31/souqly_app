import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/shared_prefrences/shared_preferences_utils.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/data/model/AddToWishListResponseDm.dart';
import 'package:e_commerce_app/data/model/GetWishListResponseDm.dart';
import 'package:e_commerce_app/data/model/RemoveFromWishListDm.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/wish_list_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WishListRemoteDataSource)
class WishListRemoteDataSourceImpl
    implements WishListRemoteDataSource {
  ApiManager apiManager;

  WishListRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, AddToWishListResponseDm>> addToWishList(
      String productId) async {
    List<ConnectivityResult> connectivityResults =
    await Connectivity().checkConnectivity();
    var token = SharedPreferencesUtils.getString('token');

    try {
      if (connectivityResults.contains(ConnectivityResult.mobile) ||
          connectivityResults.contains(ConnectivityResult.wifi)) {
        var response = await apiManager.postData(
            endPoint: EndPoints.addToWishList,
            headers: {'token': token},
            body: {"productId": productId});
        var addToWishListResponse = AddToWishListResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 || response.statusCode! < 300) {
          return Right(addToWishListResponse);
        } else {
          return Left(ServerError(errorMessage: addToWishListResponse.message!));
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
  Future<Either<Failures, GetWishListResponseDm>> getWishList() async{
    List<ConnectivityResult> connectivityResults =
    await Connectivity().checkConnectivity();
    var token = SharedPreferencesUtils.getString('token');

    try {
      if (connectivityResults.contains(ConnectivityResult.mobile) ||
          connectivityResults.contains(ConnectivityResult.wifi)) {
        var response = await apiManager.getData(
            endPoint: EndPoints.addToWishList,
            headers: {'token': token},
        );
        var getWishListResponse = GetWishListResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 || response.statusCode! < 300) {
          return Right(getWishListResponse);
        } else {
          return Left(ServerError(errorMessage: getWishListResponse.message!));
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
  Future<Either<Failures, RemoveFromWishListDm>> removeFromWishList(String productId) async{
    List<ConnectivityResult> connectivityResults =
    await Connectivity().checkConnectivity();
    var token = SharedPreferencesUtils.getString('token');

    try {
      if (connectivityResults.contains(ConnectivityResult.mobile) ||
          connectivityResults.contains(ConnectivityResult.wifi)) {
        var response = await apiManager.deleteData(
          endPoint: '${EndPoints.addToWishList}/$productId',
          headers: {'token': token},
        );
        var removeFromWishListResponse = RemoveFromWishListDm.fromJson(response.data);
        if (response.statusCode! >= 200 || response.statusCode! < 300) {
          return Right(removeFromWishListResponse);
        } else {
          return Left(ServerError(errorMessage: removeFromWishListResponse.message!));
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

