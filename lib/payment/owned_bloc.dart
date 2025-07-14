import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lpp/payment/ad_free_state.dart';

const adFreeId = "adfree";

class OwnedCubit extends Cubit<AdFreeState> {
  OwnedCubit(super.initialState) {
    checkPurchases();
  }

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  void enableAds() {
    emit(state.copyWith(hasAdFree: false));
  }

  Future<void> checkPurchases() async {
    if (kDebugMode) {
      return;
    }
    final bool available = await InAppPurchase.instance.isAvailable();
    if (available) {
      final Stream<List<PurchaseDetails>> purchaseUpdated =
          InAppPurchase.instance.purchaseStream;
      _subscription = purchaseUpdated.listen((purchaseDetailsList) {
        checkPurchaseList(purchaseDetailsList);
      }, onDone: () {
        _subscription.cancel();
      }, onError: (error) {
        // handle error here.
      });
      await InAppPurchase.instance.restorePurchases();

      var products =
          await InAppPurchase.instance.queryProductDetails({'adfree'});
      if (products.error == null && products.productDetails.isNotEmpty) {
        var details = products.productDetails.first;
        emit(state.copyWith(price: details.price));
      }
    }
  }

  checkPurchaseList(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchase in purchaseDetailsList) {
      if (purchase.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchase);
      }
      if ((purchase.status == PurchaseStatus.purchased ||
              purchase.status == PurchaseStatus.restored) &&
          purchase.productID == adFreeId) {
        emit(state.copyWith(hasAdFree: true));
      }
    }
  }
}
