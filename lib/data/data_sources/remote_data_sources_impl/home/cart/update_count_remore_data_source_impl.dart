import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/shared_prefrences/shared_preferences_utils.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/data/model/UpdateCountResponseDm.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/update_count_remore_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdateCountRemoteDataSource)
class UpdateCountRemoteDataSourceImpl extends UpdateCountRemoteDataSource {
  ApiManager apiManager;

  UpdateCountRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, UpdateCountResponseDm>> updateProductCountInCart(
      int count, String productId) async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    var token = SharedPreferencesUtils.getString('token');

    try {
      if (connectivityResults.contains(ConnectivityResult.mobile) ||
          connectivityResults.contains(ConnectivityResult.wifi)) {
        var response = await apiManager.updateData(
            endPoint: "${EndPoints.addProductToCart}/$productId",
            headers: {'token': token},
            body: {"count": count});
        var updateCountResponse = UpdateCountResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 || response.statusCode! < 300) {
          return Right(updateCountResponse);
        } else {
          return Left(ServerError(errorMessage: updateCountResponse.message!));
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
