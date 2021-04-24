import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:injectable/injectable.dart';

import '../../utils/logger.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: INetworkInfo)
class NetworkInfoImpl extends INetworkInfo {
  final logger = getLogger("NetworkInfoImpl");

  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected {
    logger.i("isConnected getter");
    return connectionChecker.hasConnection;
  }
}
