import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:intl/intl.dart';

import '../../../application/orders_cubit/orders_cubit.dart';
import '../../../domain/order/order.dart';
import '../../../domain/order/order_item.dart';
import '../../../infrastructure/core/api_constants.dart';

class ViewAllOrders extends StatefulWidget {
  static const routeName = './view-all-orders';

  const ViewAllOrders();

  @override
  _ViewAllOrdersState createState() => _ViewAllOrdersState();
}

class _ViewAllOrdersState extends State<ViewAllOrders> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User orders")),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoaded) {
            return ListView.builder(
              itemBuilder: (_, index) {
                return OrderTile(order: state.orders[index]);
              },
              itemCount: state.orders.length,
            );
          } else if (state is OrdersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Text("ERROR");
          }
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({Key key, @required this.order}) : super(key: key);

  void showOrderList(BuildContext context) {
    final double grandTotal = order.items.fold(
      0,
      (double sum, OrderItem item) => sum + (item.price * item.quantity),
    );

    showDialog(
      context: context,
      builder: (context) {
        return Builder(
          builder: (_) {
            return AlertDialog(
              title: const Text("Orders"),
              content: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == order.items.length) {
                    return Text("Total : Rs $grandTotal");
                  }

                  final OrderItem item = order.items[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        ApiConstants.imageUrl(item.image),
                      ),
                    ),
                    title: Text(item.name),
                    subtitle: Text(
                      "${item.quantity} X Rs ${item.price}\nRs ${item.price * item.quantity}",
                    ),
                  );
                },
                itemCount: order.items.length + 1,
              ),
              actions: <Widget>[
                OutlineButton(
                  textColor: order.status != "Pending"
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (order.status != "Pending") {
                      context
                          .read<OrdersCubit>()
                          .updateStatus(order.id, "Pending");
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Pending",
                  ),
                ),
                OutlineButton(
                  textColor: order.status != "Processing"
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (order.status != "Processing") {
                      context
                          .read<OrdersCubit>()
                          .updateStatus(order.id, "Processing");
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Processing"),
                ),
                OutlineButton(
                  textColor: order.status != "Delievered"
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if (order.status != "Delievered") {
                      context
                          .read<OrdersCubit>()
                          .updateStatus(order.id, "Delievered");
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Delievered"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showMap(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(children: [
            const Text("Address"),
            SizedBox(
              height: 380,
              width: 380,
              child: Container()
              // GoogleMap(
              //   minZoom: 12,
              //   initialPosition: GeoCoord(
              //     order.user.location.coordinates[1],
              //     order.user.location.coordinates[0],
              //   ),
              //   markers: {
              //     Marker(
              //       GeoCoord(
              //         order.user.location.coordinates[1],
              //         order.user.location.coordinates[0],
              //       ),
              //       label: 'initial Position',
              //     ),
              //   },
              // ),
            ),
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = Colors.white;
    if (order.status == 'Processing') {
      cardColor = Colors.red[100];
    } else if (order.status == 'Delievered') {
      cardColor = Colors.green[100];
    }

    return Card(
      color: cardColor,
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  ApiConstants.imageUrl(order.user.image),
                ),
                radius: 30,
              ),
              Column(children: [
                const Text(
                  "Ordered by:",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  order.user.name,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(
                  "Ordered Date: ${DateFormat.yMd().format(DateTime.parse(order.date))}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ])
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  showOrderList(context);
                },
                color: Colors.blue,
                child: const Text(
                  "View Items",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  // showMap(context);
                },
                color: Colors.green,
                child: const Text(
                  "Show Location",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
