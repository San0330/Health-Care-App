import 'package:flutter/widgets.dart';

import '../../../infrastructure/services/media_service.dart';
import '../../../injection.dart';

class AddEditProvider with ChangeNotifier {
  String id;
  String name;
  String price;
  String description;
  String discountRate;
  String categoryId;
  bool featured;
  String image;
  String imageFilePath;

  AddEditProvider({
    this.id,
    this.name,
    this.price = "0",
    this.description,
    this.discountRate = "0",
    this.categoryId,
    this.featured,
    this.image,
  });

  void update({
    String newname,
    String newprice,
    String newdescription,
    String newdiscountRate,
    String newcategoryId,
    bool newfeatured,
    String newimage,
  }) {
    name = newname ?? name;
    price = newprice ?? price;
    description = newdescription ?? description;
    featured = newfeatured ?? featured;
    image = newimage ?? image;
    categoryId = newcategoryId ?? categoryId;
    discountRate = newdiscountRate ?? discountRate;

    notifyListeners();
  }

  Future getImage() async {
    imageFilePath = (await getIt<IMediaService>().getImage(fromGallery: true)).path;
    image = null;
    notifyListeners();
  }
}
