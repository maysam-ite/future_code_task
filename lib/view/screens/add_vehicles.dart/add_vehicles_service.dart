// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../../../constant/server_const.dart';
import '../../../constant/status_request.dart';
import '../../../data/checkInternet/check_internet.dart';

class AddVehiclesService {
  Future<Either<StatuseRequest, Map>> getVehicleTypes(String token) async {
    //Either for return two data type in the same time
    try {
      if (await checkInternet()) {
        Uri url = Uri.parse(ServerConstApis.showVehicleTypes);
        print("start service");
        Map<String, String> headers = {
          'Authorization': 'Bearer $token',
          "Accept": "application/json"
        };

        var response = await http.get(url, headers: headers);
        print(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final responsebody = jsonDecode(response.body);

          return Right(responsebody);
        } else if (response.statusCode == 403) {
          return const Left(StatuseRequest.authfailuer);
        } else {
          return const Left(StatuseRequest.serverfailure);
        }
      } else {
        return const Left(StatuseRequest
            .offlinefailure); //left return the left data type =>StatuseRequest
      }
    } catch (e) {
      return const Left(StatuseRequest.offlinefailure);
    }
  }

  Future<Either<StatuseRequest, Map>> addvehicle(Map<String, String> data,
      List<Map<String, dynamic>> imagesData, String token) async {
    //Either for return two data type in the same time
    try {
      // image.path.split('/').last
      if (await checkInternet()) {
        print("starting in service");
        Uri url = Uri.parse(ServerConstApis.addVehicle);

        Map<String, String> headers = {
           'Authorization': 'Bearer $token',
          "Accept":"application/json"
         };

        var request = http.MultipartRequest("POST", url);
      
        for (var data in imagesData) {
          String key = data["key"];
          List<int> inBytes = data["inBytes"];
          String imageName = data["imageName"];

          // Create a MultipartFile from inBytes
          request.files.add(http.MultipartFile.fromBytes(
            key,
            Uint8List.fromList(inBytes),
            filename: imageName,
          ));
        }
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
          return const Left(StatuseRequest.missingimage);
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
