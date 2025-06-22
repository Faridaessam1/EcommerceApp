import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_network.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/data/model/wishlist/wishlist_response_data_model.dart';
import 'package:e_commerce_app/domain/repositories/dataSource/remote_interFace/wishlist_remote_data_source_interface.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/wishlist_response_entity.dart';

@Injectable(as: WishlistRemoteDataSourceInterFace)
class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSourceInterFace {
  final ApiNetwork apiNetwork;

  WishlistRemoteDataSourceImpl({required this.apiNetwork});

  @override
  Future<Either<Failures, WishlistResponseEntity>> getWishlist() async {
    try {
      final response = await apiNetwork.getData(
        endPoint: EndPoints.wishlistEndPoint,
        options: Options(
          headers: {
            'token': await _getToken(),
          },
        ),
      );

      if (response.statusCode == 200) {
        final wishlistResponse = WishlistResponseDM.fromJson(response.data);
        return Right(wishlistResponse);
      } else {
        return Left(ServerError(
          errorMsg: response.data['message'] ?? 'Failed to get wishlist',
        ));
      }
    } on DioException catch (e) {
      return Left(NetworkError(
        errorMsg: e.response?.data['message'] ?? 'Network error occurred',
      ));
    } catch (e) {
      return Left(ServerError(errorMsg: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failures, WishlistResponseEntity>> addToWishlist(String productId) async {
    try {
      final response = await apiNetwork.postData(
        endPoint: EndPoints.wishlistEndPoint,
        data: {'productId': productId},
        headers: {
          'token': await _getToken(),
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final wishlistResponse = WishlistResponseDM.fromJson(response.data);
        return Right(wishlistResponse);
      } else {
        return Left(ServerError(
          errorMsg: response.data['message'] ?? 'Failed to add to wishlist',
        ));
      }
    } on DioException catch (e) {
      return Left(NetworkError(
        errorMsg: e.response?.data['message'] ?? 'Network error occurred',
      ));
    } catch (e) {
      return Left(ServerError(errorMsg: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failures, WishlistResponseEntity>> removeFromWishlist(String productId) async {
    try {
      final response = await apiNetwork.deleteData(
        endPoint: '${EndPoints.wishlistEndPoint}/$productId',
        headers: {
          'token': await _getToken(),
        },
      );

      if (response.statusCode == 200) {
        final wishlistResponse = WishlistResponseDM.fromJson(response.data);
        return Right(wishlistResponse);
      } else {
        return Left(ServerError(
          errorMsg: response.data['message'] ?? 'Failed to remove from wishlist',
        ));
      }
    } on DioException catch (e) {
      return Left(NetworkError(
        errorMsg: e.response?.data['message'] ?? 'Network error occurred',
      ));
    } catch (e) {
      return Left(ServerError(errorMsg: 'An unexpected error occurred'));
    }
  }

  Future<String> _getToken() async {
    // Replace this with your actual token retrieval logic
    // You might want to use SharedPreferences, Secure Storage, or another method
    return '';
  }
}