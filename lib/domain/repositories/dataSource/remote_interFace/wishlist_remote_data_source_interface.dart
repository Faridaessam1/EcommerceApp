import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../entities/wishlist_response_entity.dart';

abstract class WishlistRemoteDataSourceInterFace {
  Future<Either<Failures, WishlistResponseEntity>> getWishlist();
  Future<Either<Failures, WishlistResponseEntity>> addToWishlist(String productId);
  Future<Either<Failures, WishlistResponseEntity>> removeFromWishlist(String productId);
}