import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/shared_prefrences/shared_preferences_utils.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/data/model/LoginResponseDm.dart';
import 'package:e_commerce_app/data/model/RgisterResponseDm.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apiManager;

  AuthRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, RegisterResponseDm>> register(
    String name,
    String phone,
    String email,
    String password,
    String rePassword,
  ) async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();

    if (connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.mobile)) {
      try {
        var response =
            await apiManager.postData(endPoint: EndPoints.signUp, body: {
          "name": name,
          "email": email,
          "password": password,
          "rePassword": rePassword,
          "phone": phone
        });

        var registerResponse = RegisterResponseDm.fromJson(response.data);

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(registerResponse);
        } else {
          return Left(ServerError(
              errorMessage: registerResponse.message ?? "Unknown error"));
        }
      } catch (e) {
        return Left(ServerError(errorMessage: e.toString()));
      }
    } else {
      return Left(
        NetworkError(errorMessage: 'Check your Internet Connection'),
      );
    }
  }

  @override
  Future<Either<Failures, LoginResponseDm>> login(
      String email, String password) async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();

    if (connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.mobile)) {
      try {
        var response = await apiManager.postData(
            endPoint: EndPoints.signIn,
            body: {"email": email, "password": password});
        var loginResponse = LoginResponseDm.fromJson(response.data);

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          SharedPreferencesUtils.saveData(key: 'token', value: loginResponse.token);
          return Right(loginResponse);
        } else {
          return Left(ServerError(
              errorMessage: loginResponse.message ?? 'Unknown Error'));
        }
      } catch (e) {
        return Left(ServerError(errorMessage: e.toString()));
      }
    } else {
      return Left(NetworkError(errorMessage: 'Check your Internet Connection'));
    }
  }
}
