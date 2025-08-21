import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/data/model/CategoryOrBrandDm.dart';
import 'package:e_commerce_app/data/model/ProductsResponseDm.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  ApiManager apiManager;

  HomeRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, CategoryOrBrandDm>> getAllCategories() async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResults.contains(ConnectivityResult.wifi) ||
          connectivityResults.contains(ConnectivityResult.mobile)) {
        var response =
            await apiManager.getData(endPoint: EndPoints.getAllCategories);

        var allCategories = CategoryOrBrandDm.fromJson(response.data);

        if (response.statusCode == 200) {
          return Right(allCategories);
        } else {
          return Left(ServerError(errorMessage: allCategories.statusMsg!));
        }
      } else {
        return Left(
          NetworkError(errorMessage: 'Check your Internet Connection'),
        );
      }
    } catch (e) {
      return Left(Failures(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, CategoryOrBrandDm>> getAllBrands() async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResults.contains(ConnectivityResult.wifi) ||
          connectivityResults.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(endPoint: EndPoints.getAllBrands);
       var  allBrands = CategoryOrBrandDm.fromJson(response.data);
        if(response.statusCode == 200){
          return Right(allBrands);
        }else {
          return Left(ServerError(errorMessage: allBrands.statusMsg!));
        }
      }else{
        return Left(
          NetworkError(errorMessage: 'Check your Internet Connection'),
        );
      }
    } catch (e) {
      return Left(Failures(errorMessage: e.toString()));

    }
  }

  @override
  Future<Either<Failures, ProductsResponseDm>> getAllProducts() async{
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResults.contains(ConnectivityResult.wifi) ||
          connectivityResults.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(endPoint: EndPoints.getAllProducts);
        var  allProducts = ProductsResponseDm.fromJson(response.data);
        if(response.statusCode == 200){

          return Right(allProducts);
        }else {
          return Left(ServerError(errorMessage: allProducts.statusMsg!));
        }
      }else{
        return Left(
          NetworkError(errorMessage: 'Check your Internet Connection'),
        );
      }
    } catch (e) {
      return Left(Failures(errorMessage: e.toString()));

    }
  }
}
