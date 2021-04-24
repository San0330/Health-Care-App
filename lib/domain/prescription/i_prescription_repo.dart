import 'package:dartz/dartz.dart';

import '../core/failures.dart';

abstract class IPrescriptionRepo {
  
  Future<Option<Failure>> uploadPrescriptions({
    bool fromGallery = true,
  });

}