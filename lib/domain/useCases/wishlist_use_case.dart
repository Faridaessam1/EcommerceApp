
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/domain/repositories/wishlist/wishlist_repository_interface.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/failures.dart';
import '../entities/wishlist_response_entity.dart';

@injectable
class GetWishlistUseCase {
  final WishlistRepositoryInterface repository;

  GetWishlistUseCase({required this.repository});

  Future<Either<Failures, WishlistResponseEntity>> call() async {
    return await repository.getWishlist();
  }
}



@injectable
class AddToWishlistUseCase {
  final WishlistRepositoryInterface repository;

  AddToWishlistUseCase({required this.repository});

  Future<Either<Failures, WishlistResponseEntity>> call(String productId) async {
    return await repository.addToWishlist(productId);
  }
}


@injectable
class RemoveFromWishlistUseCase {
  final WishlistRepositoryInterface repository;

  RemoveFromWishlistUseCase({required this.repository});

  Future<Either<Failures, WishlistResponseEntity>> call(String productId) async {
    return await repository.removeFromWishlist(productId);
  }
}