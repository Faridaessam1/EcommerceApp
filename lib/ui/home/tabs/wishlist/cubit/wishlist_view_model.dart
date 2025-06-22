import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../domain/entities/wishlist_response_entity.dart';
import '../../../../../domain/useCases/wishlist_use_case.dart';
import 'wishlist_states.dart';

@injectable
class WishlistCubit extends Cubit<WishlistStates> {
  final GetWishlistUseCase getWishlistUseCase;
  final AddToWishlistUseCase addToWishlistUseCase;
  final RemoveFromWishlistUseCase removeFromWishlistUseCase;

  WishlistCubit({
    required this.getWishlistUseCase,
    required this.addToWishlistUseCase,
    required this.removeFromWishlistUseCase,
  }) : super(WishlistInitialState());

  static WishlistCubit get(context) => BlocProvider.of(context);

  List<WishlistDataEntity> wishlistItems = [];
  Set<String> wishlistProductIds = <String>{};

  void getWishlist() async {
    emit(WishlistLoadingState());

    var result = await getWishlistUseCase.call();

    result.fold(
          (error) {
        emit(WishlistErrorState(errorMsg: error.errorMsg));
      },
          (response) {
        wishlistItems = response.data ?? [];
        wishlistProductIds = wishlistItems
            .where((item) => item.sId != null)
            .map((item) => item.sId!)
            .toSet();
        emit(WishlistSuccessState(wishlistResponse: response));
      },
    );
  }

  void addToWishlist(String productId) async {
    emit(AddToWishlistLoadingState());

    var result = await addToWishlistUseCase.call(productId);

    result.fold(
          (error) {
        emit(AddToWishlistErrorState(errorMsg: error.errorMsg));
      },
          (response) {
            wishlistItems = response.data ?? [];
          wishlistProductIds = wishlistItems
              .where((item) => item.sId != null)
              .map((item) => item.sId!)
              .toSet();

          emit(AddToWishlistSuccessState(wishlistResponse: response));
          },
    );
  }

  void removeFromWishlist(String productId) async {
    emit(RemoveFromWishlistLoadingState());

    var result = await removeFromWishlistUseCase.call(productId);

    result.fold(
          (error) {
        emit(RemoveFromWishlistErrorState(errorMsg: error.errorMsg));
      },
          (response) {
        wishlistProductIds.remove(productId);
        wishlistItems.removeWhere((item) => item.sId == productId);
        emit(RemoveFromWishlistSuccessState(wishlistResponse: response));
        // Refresh wishlist to get updated data
        getWishlist();
      },
    );
  }

  bool isProductInWishlist(String productId) {
    return wishlistProductIds.contains(productId);
  }

  void toggleWishlist(String productId) {
    if (isProductInWishlist(productId)) {
      removeFromWishlist(productId);
    } else {
      addToWishlist(productId);
    }
  }
}