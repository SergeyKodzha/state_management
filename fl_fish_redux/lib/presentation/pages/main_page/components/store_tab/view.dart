
import 'package:fish_redux/fish_redux.dart';
import 'package:fl_fish_redux/business/entities/cart_item.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/store_tab/actions.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/store_tab/state.dart';
import 'package:fl_fish_redux/presentation/pages/main_page/components/store_tab/widgets/store_item.dart';
import 'package:flutter/material.dart';

Widget buildView(StoreState state, Dispatch dispatch, ViewService viewService) {
  if (state.status==StoreStatus.loading){
    return const Center(child: CircularProgressIndicator(),);
  } else {
    final products=state.products;
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 40 / 56,
        ),
        itemBuilder: (context, index) {
          return StoreItem(
            product: products[index],
            onTap: (product) {
              dispatch(StoreActions.productTap(product));
            },
          );
        });

  }
}