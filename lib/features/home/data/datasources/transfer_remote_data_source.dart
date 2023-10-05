import 'package:cifo_flutter/core/constants/api.dart';
import 'package:cifo_flutter/core/secure_storage/secure_storage.dart';
import 'package:cifo_flutter/features/home/data/models/transfer_params_model.dart';
import 'package:dio/dio.dart';
import 'package:cifo_flutter/features/home/domain/entities/transfer_params.dart';
import 'package:cifo_flutter/core/http/custom_http_client.dart';

abstract class TransferRemoteDataSource {
  Future<Response> transferUser({required TransferParams transferParams});
}

class TransferRemoteDataSourceImpl extends TransferRemoteDataSource {
  final CustomHttpClient client;
  final SecureStorage secureStorage;

  TransferRemoteDataSourceImpl(
      {required this.client, required this.secureStorage});

  @override
  Future<Response> transferUser(
      {required TransferParams transferParams}) async {
    int operatorId = transferParams.transferID;
    final jsonData = await client.post(
      path: API.apiTransfer,
      body: getBodyInfo(operatorId),
    );

    return jsonData;
  }

  dynamic getBodyInfo(int id) {
    int cedula = int.parse(secureStorage.getCedula());
    String operatorName = "";
    String url = "";
    switch (id) {
      case 2:
        operatorName = "Operador 2";
        url = "http://ac39d19f7b1e644d3b66902a683a57ab-328135341.us-west-2.elb.amazonaws.com/api/TransferCitizen";
        break;
      case 3:
        operatorName = "Operador 3";
        url = "";
        break;
      case 4:
        operatorName = "Operador 4";
        url = "";
        break;
      default:
    }
    return {
      "Operator": {"id": cedula, "operatorId": id, "operatorName": operatorName},
      "UrlOperatorToChange": url
    };
  }
}
