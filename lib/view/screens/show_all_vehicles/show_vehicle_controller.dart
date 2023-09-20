import 'package:dartz/dartz.dart';
import 'package:future_code_task/view/screens/show_all_vehicles/show_vehicle_service.dart';
import 'package:get/get.dart';
import '../../../constant/status_request.dart';
import '../../../data/Models/vehicle_model.dart';
import '../../../general_controller/statuse_request_controller.dart';
import '../../../main.dart';
import '../../widget/no_internet_page.dart';

class ShowAllVehicleController extends GetxController  implements StatuseRequestController{
   ShowAllVehiclesService service = ShowAllVehiclesService();
   List<VehicleModel> finalListData=[];
  @override
  StatuseRequest? statuseRequest = (StatuseRequest.init);
  @override
  void onInit() async {
    finalListData = await sendingARequestAndHandlingData();
    // statuseRequest = await checkIfTheInternetIsConectedBeforGoingToThePage();

    super.onInit();
  }

  Future<List<VehicleModel>> sendingARequestAndHandlingData() async {
    statuseRequest = StatuseRequest.loading;
    update();
    dynamic response =await getdata(); // check if the return data is statuseRequest or real data
    statuseRequest = handlingData(response); //return the statuseResponse
    if (statuseRequest == StatuseRequest.success) {
      return whenGetDataSuccess(response);
    } else if (statuseRequest == StatuseRequest.authfailuer) {
      //  snackBarForErrors("Auth error","Please login again");
        Get.offAllNamed('LoginPage');
    } else {
      // when happen a mestake we handel it here
      [];
    }
    update();
    return [];
  }

  
  getdata() async {
    String token = await prefService.readString('token');

    Either<StatuseRequest, Map<dynamic, dynamic>> response =
        await service.getVehicles(token);

    return response.fold((l) => l, (r) => r);
  }

  handlingData(response) {
    if (response is StatuseRequest) {
      return response;
    } else {
      return StatuseRequest.success;
    }
  }

  Future<List<VehicleModel>>whenGetDataSuccess(response) async {
    List responsedata = response['data'];
   for (int i = 0; i < responsedata.length; i++) {
      finalListData.add(VehicleModel.fromJson(responsedata[i]));
    }
   
    update();
    return finalListData;
    
  }
 
  }
