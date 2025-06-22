import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/domain/repositories/dataSource/remote_interFace/wishlist_remote_data_source_interface.dart';
import 'package:injectable/injectable.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/wishlist_response_entity.dart';
import '../../domain/repositories/wishlist/wishlist_repository_interface.dart';

@Injectable(as: WishlistRepositoryInterface)
class WishlistRepositoryImpl implements WishlistRepositoryInterface {
  final WishlistRemoteDataSourceInterFace remoteDataSource;

  WishlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, WishlistResponseEntity>> getWishlist() async {
    final result = await remoteDataSource.getWishlist();
    return result.fold(
          (exception) => Left(Failures(errorMsg: exception.toString())),
          (wishlistResponse) => Right(wishlistResponse),
    );
  }

  @override
  Future<Either<Failures, WishlistResponseEntity>> addToWishlist(String productId) async {
    final result = await remoteDataSource.addToWishlist(productId);
    return result.fold(
          (exception) => Left(Failures(errorMsg: exception.toString())),
          (wishlistResponse) => Right(wishlistResponse),
    );
  }

  @override
  Future<Either<Failures, WishlistResponseEntity>> removeFromWishlist(String productId) async {
    final result = await remoteDataSource.removeFromWishlist(productId);
    return result.fold(
          (exception) => Left(Failures(errorMsg: exception.toString())),
          (wishlistResponse) => Right(wishlistResponse),
    );
  }
}