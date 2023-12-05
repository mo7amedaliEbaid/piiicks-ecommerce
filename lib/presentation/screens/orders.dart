import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/space.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';

import '../../application/order_fetch_cubit/order_fetch_cubit.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar("MY ORDERS", context, automaticallyImplyLeading: true),
      body: Padding(
        padding: Space.all(1, .5),
        child: BlocBuilder<OrderFetchCubit, OrderFetchState>(
          builder: (context, state) {
            if (state is! OrderFetchLoading && state.orders.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Orders are Empty!"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  )
                ],
              );
            }
            if (state is OrderFetchSuccess) {
              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: state.orders.length,
                itemBuilder: (context, index) => OrderItemWidget(
                  orderDetails: state.orders[index],
                ),
              );
            } else {
              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: 6,
                padding: Space.all(),
                itemBuilder: (context, index) =>
                    LoadingShimmer(isSquare: false),
              );
            }
          },
        ),
      ),
    );
  }
}
