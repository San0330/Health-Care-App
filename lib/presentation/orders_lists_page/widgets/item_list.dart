import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../application/orders_cubit/orders_cubit.dart';
import '../../../domain/order/order.dart';
import '../../../infrastructure/core/api_constants.dart';

class ExpandableItemList extends StatelessWidget {
  final Order order;

  const ExpandableItemList({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double grandTotal =
        order.items.fold(0, (initalValue, item) => item.price * item.quantity);

    return ExpandableNotifier(
      child: Column(
        children: [
          ListTile(
            title:
                Text("${order.items.length} items,\t\tstatus: ${order.status}"),
            subtitle: Text(
                "${DateFormat.yMd().format(DateTime.parse(order.date))}\nTotal: Rs $grandTotal"),
            isThreeLine: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ExpandableButton(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.remove_red_eye_rounded, color: Colors.blue),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "View Items",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              // OutlineButton.icon(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.create,
              //     color: Colors.green,
              //   ),
              //   label: const Text(
              //     "Edit",
              //     style: TextStyle(color: Colors.green),
              //   ),
              // ),
              OutlineButton.icon(
                onPressed: () {
                  context.read<OrdersCubit>().deleteOrder(order.id);
                },
                icon: const Icon(
                  Icons.clear_sharp,
                  color: Colors.red,
                ),
                label: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          ScrollOnExpand(
            child: Expandable(
              expanded: Container(
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = order.items[index];
                    final pname = item.name;
                    final quantity = item.quantity;
                    final cost = item.price;
                    final total = cost * quantity;
                    final image = item.image;

                    return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            ApiConstants.imageUrl(image),
                          ),
                        ),
                        title: Text(pname),
                        subtitle: Text("$quantity X Rs $cost = Rs $total"));
                  },
                  itemCount: order.items.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemListWidget extends StatefulWidget {
  final Order myorder;

  const ItemListWidget({Key key, this.myorder}) : super(key: key);

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  bool _show = false;

  void changeState() {
    setState(() {
      _show = !_show;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Order order = widget.myorder;

    final double grandTotal =
        order.items.fold(0, (initalValue, item) => item.price * item.quantity);

    return Column(children: [
      ListTile(
        title: Text("${order.items.length} items,\t\tstatus: ${order.status}"),
        subtitle: Text(
            "${DateFormat.yMd().format(DateTime.parse(order.date))}\nTotal: Rs $grandTotal"),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(_show ? Icons.expand_less : Icons.expand_more),
          onPressed: changeState,
        ),
      ),
      if (!_show)
        const SizedBox()
      else
        Container(
          height: 90.0 * order.items.length,
          decoration: BoxDecoration(color: Colors.grey[300]),
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = order.items[index];
              final pname = item.name;
              final quantity = item.quantity;
              final cost = item.price;
              final total = cost * quantity;
              final image = item.image;

              return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      ApiConstants.imageUrl(image),
                    ),
                  ),
                  title: Text(pname),
                  subtitle: Text("$quantity X Rs $cost = Rs $total"));
            },
            itemCount: order.items.length,
          ),
        ),
    ]);
  }
}
