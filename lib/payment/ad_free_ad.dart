import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lpp/payment/owned_bloc.dart';

class AdFreeAd extends StatelessWidget {
  const AdFreeAd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnedCubit, bool>(
      builder: (context, state) {
        if (state) {
          return const SizedBox(height: 0.0);
        }
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 90.0,
                child: GestureDetector(
                  onTap: () async {
                    const Set<String> kIds = <String>{'adfree'};

                    final bool available =
                        await InAppPurchase.instance.isAvailable();

                    if (available) {
                      final ProductDetailsResponse response =
                          await InAppPurchase.instance
                              .queryProductDetails(kIds);
                      if (response.notFoundIDs.isNotEmpty) {
                        // Handle the error.
                      }
                      List<ProductDetails> products = response.productDetails;
                      var productDetails = products
                          .where((element) => element.id == 'adfree')
                          .firstOrNull;
                      if (productDetails != null) {
                        final PurchaseParam purchaseParam =
                            PurchaseParam(productDetails: productDetails);
                        await InAppPurchase.instance
                            .buyNonConsumable(purchaseParam: purchaseParam);
                      }
                    }
                  },
                  child: const Card(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Træt af reklamer?"),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
