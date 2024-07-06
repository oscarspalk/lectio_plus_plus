import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lpp/payment/ad_free_state.dart';
import 'package:lpp/payment/art.dart';
import 'package:lpp/payment/owned_bloc.dart';
import 'package:lpp/widgets/layout/appbar.dart';

class BuyAdFreeScreen extends StatelessWidget {
  const BuyAdFreeScreen({super.key});

  void buyAdFree() async {
    const Set<String> kIds = <String>{'adfree'};

    final bool available = await InAppPurchase.instance.isAvailable();

    if (available) {
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails(kIds);
      if (response.notFoundIDs.isNotEmpty) {
        // Handle the error.
      }
      List<ProductDetails> products = response.productDetails;
      var productDetails =
          products.where((element) => element.id == 'adfree').firstOrNull;
      if (productDetails != null) {
        final PurchaseParam purchaseParam =
            PurchaseParam(productDetails: productDetails);
        await InAppPurchase.instance
            .buyNonConsumable(purchaseParam: purchaseParam);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LppAppbar(title: "Reklame Fri"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
              child: AdFreeArt(
                  scale: 1.4,
                  child: SizedBox(
                      height: 250.0,
                      child: Center(
                          child: Text("Reklame fri",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontSize: 36.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary))))),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Reklame Fri",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  RichText(
                      text: TextSpan(
                          text:
                              """Hvis du er ved at være træt af at kigge på reklamer, så kan du nu fjerne dem permanent fra din app.
                    """
                                  .trim())),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<OwnedCubit, AdFreeState>(
                          builder: (context, state) {
                        return FilledButton.icon(
                          iconAlignment: IconAlignment.end,
                          onPressed: state.price != null
                              ? state.hasAdFree
                                  ? null
                                  : buyAdFree
                              : null,
                          label: Text(state.price != null
                              ? state.hasAdFree
                                  ? "Allerede købt"
                                  : "Køb for ${state.price}"
                              : "Fejl"),
                          icon: const Icon(EvaIcons.shoppingCartOutline),
                        );
                      }),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
