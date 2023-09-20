// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../../../constant/server_const.dart';
import '../../../constant/status_request.dart';

class LoginService {
  Future<Either<StatuseRequest, Map>> login(Map<String, String> data) async {
    
    //Either for return two data type in the same time
    try {
        Uri url = Uri.parse(ServerConstApis.signIn);
        print(data);
        http.Response response = await http.post(
          url,
          body: data,
         );
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else if (response.statusCode == 400) {
          return const Left(StatuseRequest.validationfailuer);
        } else if (response.statusCode == 422) {
          return const Left(StatuseRequest.authfailuer);
        } else {
          return const Left(StatuseRequest.serverfailure);
        }
      
    } catch (e) {
      print(e);
      return const Left(StatuseRequest.serverfailure);
    }
  }
}
