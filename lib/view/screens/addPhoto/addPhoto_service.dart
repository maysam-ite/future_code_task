// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../../../constant/server_const.dart';
import '../../../constant/status_request.dart';
import '../../../data/checkInternet/check_internet.dart';

class AddPhotoService {
  Future<Either<StatuseRequest, Map>> register(
      Map<String, String> data,Uint8List image, String imageName) async {
    //Either for return two data type in the same time
    try {
      if (await checkInternet()) {
        Uri url = Uri.parse(ServerConstApis.register);
        print(" start service");
        print(data);
         Map<String, String> headers = {
           
          "Accept":"application/json"
         };
       var request = http.MultipartRequest("POST", url);
        var multipartFile =
            http.MultipartFile.fromBytes("image", image, filename: imageName);
        request.files.add(multipartFile);
        request.fields.addAll(data);
        request.headers.addAll(headers);
        
        var myrequest = await request.send();
        var response = await http.Response.fromStream(myrequest);
        print(response.body);
        print(response.statusCode);
         if (response.statusCode == 200 || response.statusCode == 201) {
          final responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else if (response.statusCode == 400) {
          return const Left(StatuseRequest.validationfailuer);
        } else if (response.statusCode == 422) {
          return const Left(StatuseRequest.validationfailuer);
        } else if (response.statusCode == 401) {
          return const Left(StatuseRequest.authfailuer);
        } else {
          return const Left(StatuseRequest.serverfailure);
        }
      } else {
        return const Left(StatuseRequest
            .offlinefailure); //left return the left data type =>StatuseRequest
      }
    } catch (e) {
      print(e);
      return const Left(StatuseRequest.serverfailure);
    }
  }
}
