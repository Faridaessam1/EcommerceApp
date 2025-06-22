
import '../../../../../domain/entities/wishlist_response_entity.dart';

abstract class WishlistStates {}

class WishlistInitialState extends WishlistStates {}

class WishlistLoadingState extends WishlistStates {}

class WishlistSuccessState extends WishlistStates {
  final WishlistResponseEntity wishlistResponse;
  WishlistSuccessState({required this.wishlistResponse});
}

class WishlistErrorState extends WishlistStates {
  final String errorMsg;
  WishlistErrorState({required this.errorMsg});
}

// Add to wishlist states
class AddToWishlistLoadingState extends WishlistStates {}

class AddToWishlistSuccessState extends WishlistStates {
  final WishlistResponseEntity wishlistResponse;
  AddToWishlistSuccessState({required this.wishlistResponse});
}

class AddToWishlistErrorState extends WishlistStates {
  final String errorMsg;
  AddToWishlistErrorState({required this.errorMsg});
}

// Remove from wishlist states
class RemoveFromWishlistLoadingState extends WishlistStates {}

class RemoveFromWishlistSuccessState extends WishlistStates {
  final WishlistResponseEntity wishlistResponse;
  RemoveFromWishlistSuccessState({required this.wishlistResponse});
}

class RemoveFromWishlistErrorState extends WishlistStates {
  final String errorMsg;
  RemoveFromWishlistErrorState({required this.errorMsg});
}