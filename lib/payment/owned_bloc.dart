import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

const adFreeId = "adfree";

class OwnedCubit extends Cubit<bool> {
  OwnedCubit(super.initialState) {
    checkPurchases();
  }

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  Future<void> checkPurchases() async {
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
    }
  }

  checkPurchaseList(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchase in purchaseDetailsList) {
      if (purchase.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchase);
      }
      if (purchase.status == PurchaseStatus.purchased &&
          purchase.productID == adFreeId) {
        debugPrint("is purchased now");
        emit(true);
      }
    }
  }
}
