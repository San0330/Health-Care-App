import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../application/products_cubit/products_cubit.dart';
import '../../../application/products_cud_cubit/product_cud_cubit.dart';
import '../../../domain/core/category.dart';
import '../../../domain/core/product.dart';
import '../../../infrastructure/core/api_constants.dart';
import '../../../injection.dart';
import '../widgets/image_input.dart';
import 'add_or_edit_provider.dart';

class AddEditProduct extends StatelessWidget {
  final Product product;

  const AddEditProduct({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddEditProvider(
        id: product?.id,
        name: product?.name,
        price: product?.price?.toString(),
        description: product?.description,
        categoryId: product?.category?.id,
        discountRate: product?.discountRate?.toString(),
        featured: product?.featured ?? false,
        image: product?.image,
      ),
      child: BlocProvider(
        create: (context) => getIt<ProductCudCubit>(),
        child: const ProductAddEditForm(),
      ),
    );
  }
}

class ProductAddEditForm extends StatelessWidget {
  const ProductAddEditForm();
  @override
  Widget build(BuildContext context) {
    final AddEditProvider provider = Provider.of<AddEditProvider>(context);
    final String title = "${provider.id == null ? 'Add' : 'Edit'} product";

    return BlocListener<ProductCudCubit, ProductCudState>(
      listener: (context, state) {
        state.failure.fold(
          () async {
            // Reload the updated data if success
            await context.read<ProductsCubit>().loadData();
            Navigator.pop(context);
          },
          (failure) {
            FlushbarHelper.createError(message: failure.message).show(context);
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            if (provider.id != null)
              IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: () {
                  context.read<ProductCudCubit>().deleteProduct(provider.id);
                },
              )
            else
              const SizedBox(),
          ],
        ),
        body: const BuildFormContent(),
      ),
    );
  }
}

//90% of device width is used to show the main list in vertical view.
class BuildFormContent extends StatefulWidget {
  const BuildFormContent({
    Key key,
  }) : super(key: key);

  @override
  _BuildFormContentState createState() => _BuildFormContentState();
}

class _BuildFormContentState extends State<BuildFormContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AddEditProvider provider = Provider.of<AddEditProvider>(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : 0.9 * deviceWidth;
    final double targetPadding = deviceWidth - targetWidth;

    void _submitform(BuildContext context) {
      if (!_formKey.currentState.validate() || provider.categoryId == null) {
        return;
      }

      if (provider.id == null) {
        context.read<ProductCudCubit>().createProduct(
              name: provider.name,
              price: double.parse(provider.price),
              discountRate: int.parse(provider.discountRate),
              catId: provider.categoryId,
              description: provider.description,
              featured: provider.featured,
              image: provider.imageFilePath,
              // on creating product we will always have imageUrl -> null
            );
      } else {
        context.read<ProductCudCubit>().updateProduct(
              id: provider.id,
              name: provider.name,
              price: double.parse(provider.price),
              discountRate: int.parse(provider.discountRate),
              catId: provider.categoryId,
              description: provider.description,
              featured: provider.featured,
              image: provider.imageFilePath,
              // on updating image, we will obviously have filepath if it is updated
              // and `null` if it isn't updated.
            );
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 10),
              const NameTF(),
              const SizedBox(height: 10),
              const DescTF(),
              const SizedBox(height: 10),
              const PriceTF(),
              const SizedBox(height: 10),
              const DiscountTF(),
              const SizedBox(height: 10),
              const FeatSwitch(),
              const SizedBox(height: 10),
              const CategoryField(),
              const SizedBox(height: 10),
              RaisedButton(
                onPressed: provider.getImage,
                child: const Text("Pick Image"),
              ),
              ImageInput(
                imageURL: provider.image != null
                    ? ApiConstants.imageUrl(provider.image)
                    : null,
                imageFilePath: provider.imageFilePath,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5.0),
                child: RaisedButton(
                  onPressed: () => _submitform(context),
                  color: Colors.blue,
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryField extends StatelessWidget {
  const CategoryField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddEditProvider provider = Provider.of<AddEditProvider>(context);
    final state = context.watch<ProductsCubit>().state;

    if (state is! ProductsLoaded) {
      return const Center(child: CircularProgressIndicator());
    } else {
      final loadedState = state as ProductsLoaded;

      // dropdown items that selects the id of category, and
      // display corresponding category name to the user
      final List<DropdownMenuItem<String>> dropdownItems = loadedState.categorys
          .map(
            (Category c) => DropdownMenuItem(
              value: c.id,
              child: Text(c.name),
            ),
          )
          .toList();

      return Row(
        children: [
          DropdownButton<String>(
            hint: const Text("Choose Category"),
            value: provider.categoryId,
            onChanged: (String newvalue) {
              provider.update(newcategoryId: newvalue);
            },
            items: dropdownItems,
          )
        ],
      );
    }
  }
}

class FeatSwitch extends StatelessWidget {
  const FeatSwitch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddEditProvider provider = Provider.of<AddEditProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text('Featured'),
        Switch(
          value: provider.featured,
          onChanged: (bool value) {
            provider.update(newfeatured: !provider.featured);
          },
        ),
      ],
    );
  }
}

class DiscountTF extends StatelessWidget {
  const DiscountTF({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddEditProvider provider = Provider.of<AddEditProvider>(context);

    return TextFormField(
      decoration: const InputDecoration(labelText: 'Discount Percentage'),
      keyboardType: TextInputType.number,
      initialValue: provider.discountRate,
      maxLength: 3,
      validator: (String value) {
        value = value.trim();
        if (value.isEmpty) return "Can't be empty !!!";
        if (!RegExp(r"(\d{1,2}\.?\d{0,2})").hasMatch(value)) {
          return 'Invalid value';
        }
        return null;
      },
      onChanged: (value) => provider.update(newdiscountRate: value),
    );
  }
}

class PriceTF extends StatelessWidget {
  const PriceTF({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddEditProvider provider = Provider.of<AddEditProvider>(context);

    return TextFormField(
      initialValue: provider.price,
      decoration: const InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      onChanged: (value) => provider.update(newprice: value),
      validator: (String value) {
        value = value.trim();
        if (value.isEmpty) return "Can't be empty !!!";
        // if (!RegExp(r"^\d{1,5}\.?\d{0,2}\$").hasMatch(value)) return 'Invalid value';
        return null;
      },
    );
  }
}

class DescTF extends StatelessWidget {
  const DescTF({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddEditProvider provider = Provider.of<AddEditProvider>(context);

    return TextFormField(
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 5,
      maxLength: 250,
      keyboardType: TextInputType.multiline,
      validator: (String value) {
        if (value.isEmpty) return "Can't be empty !!!";
        return null;
      },
      initialValue: provider.description,
      onChanged: (value) => provider.update(newdescription: value),
    );
  }
}

class NameTF extends StatelessWidget {
  const NameTF({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddEditProvider provider = Provider.of<AddEditProvider>(context);

    return TextFormField(
      decoration: const InputDecoration(labelText: 'Title'),
      validator: (String value) {
        if (value.isEmpty) return "Can't be empty !!!";
        return null;
      },
      initialValue: provider.name,
      onChanged: (value) => provider.update(newname: value),
    );
  }
}
