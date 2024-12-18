import "dart:convert";
import "dart:developer";
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

class Api {
  static List<dynamic> CategoryList_data = [];
  static List<dynamic> Sub_CategoryList_data = [];
  static List<dynamic> state_list = [];
  static List<dynamic> city_list = [];
  static var User_info;
  static Map<String, dynamic> H_Questions={};
  static late SharedPreferences prefs ;
  static Future<void> local_dataBase()async{
    prefs= await SharedPreferences.getInstance();
  }
  // -------------------------------------------------------------------------------------------  (send OTP)
  static Future<void> send_otp(String mob_no) async {
    // String url='https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo":'"'$mob_no'"',"ApiAdd":"MobileOTP","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MobileOtp';
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo":'
        "'$mob_no'"
        ',"ApiAdd":"MobileOTP","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MobileOTP';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      print(res.body);
      // var data= jsonDecode(res.body);
      // log("Done Send OTP API");
      // return data["Table1"][0]["OTPNo"];
    } else {
      log("Error........ on Send OTP API");
      // return 0;
    }
  }

  // -------------------------------------------------------------------------------------------  (phone number check )
  static Future<bool> mob_check(String mob_no) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo":'
        "'$mob_no'"
        ',"ApiAdd":"MerchantMobileNoCheck","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchantMobileNoCheck';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("check mobile number regesterd or not");
      print(res);
      print(res.body);
      var data = jsonDecode(res.body);
      if (data["Table1"][0]["IsRegister"] == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      log("Error........check mobile number regesterd or not API ");
      return false;
    }
  }

  // -------------------------------------------------------------------------------------------  (OTP insert)
  static Future<bool> otp_insert(
      {required String mob_no, required String Otp}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo": '
        "'$mob_no'"
        ',"OTP":'
        "'$Otp'"
        ',"ApiAdd":"MOTPVerify","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MOTPVerify';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("otp_insert Api Call.............");
      print(res);
      print(res.body);
      var data = jsonDecode(res.body);
      if (data["Table"][0]["ResultCode"] == "R100") {
        return true;
      } else {
        return false;
      }
    } else {
      log("Error........ otp_insert Api ");
      return false;
    }
  }

  // -------------------------------------------------------------------------------------------  (Mpin check)
  static Future<String> Mpin_check(
      {required String mob_no, required String Mpin}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MPin":'
        "'$Mpin'"
        ',"MobileNo":'
        "'$mob_no'"
        ',"ApiAdd":"MpinCheck","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MpinCheck';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("Check Mpin Api Call.............");
      print(res);
      print(res.body);
      
      var data = jsonDecode(res.body);
      User_info=data;
      await prefs.setInt('is_Hindi',0);
      await prefs.setBool('login',true);
      return data["Table"][0]["ResultCode"];
    } else {
      log("Error........ Check_Mpin Api ");
      return " ";
    }
  }

  // -------------------------------------------------------------------------------------------  (Change Password)
  static Future<String> change_password(
      {required String mob_no, required String Mpin}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo": '
        "'$mob_no'"
        ',"UserPass":'
        "'$Mpin'"
        ',"ApiAdd":"ChangePass","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ChangePass';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("change_password Api Call.............");
      print(res);
      print(res.body);
      var data = jsonDecode(res.body);
      return data["Table"][0]["ResultCode"];
    } else {
      log("Error........ change_password Api ");
      return " ";
    }
  }

  // -------------------------------------------------------------------------------------------  (CategoryList)
  static Future<void> CategoryList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ApiAdd":"CategoryList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=CategoryList';
    var res = await http.get(Uri.parse(url));
    Map<String, dynamic> data;
    if (res.statusCode == 200) {
      log("change_password Api Call.............");
      // print(res);
      // print(res.body);
      data = jsonDecode(res.body);
      // print(data["Table1"]);
      CategoryList_data.clear();
      CategoryList_data = data["Table1"];
      // return ;
    } else {
      log("Error........ change_password Api ");
      // return [];
    }
  }

  // -------------------------------------------------------------------------------------------  (SubServiceCategoryList)
  static Future<void> Sub_CategoryList({required String id}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"F_MerchentCategory":'
        "'$id'"
        ',"ApiAdd":"ServiceCategoryList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ServiceCategoryList';
    var res = await http.get(Uri.parse(url));
    Map<String, dynamic> data;
    if (res.statusCode == 200) {
      log("SubServiceCategoryList Api Call.............");
      data = jsonDecode(res.body);
      Sub_CategoryList_data.clear();
      Sub_CategoryList_data = data["Table1"];
    } else {
      log("Error........ SubServiceCategoryList Api ");
    }
  }

  // -------------------------------------------------------------------------------------------  (StateList)
  static Future<void> StateList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ApiAdd":"StateList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=StateList';
    var res = await http.get(Uri.parse(url));
    Map<String, dynamic> data;
    if (res.statusCode == 200) {
      log("StateList Api Call.............");
      data = jsonDecode(res.body);
      state_list.clear();
      state_list = data["Table1"];
    } else {
      log("Error........ StateList Api ");
    }
  }

  // -------------------------------------------------------------------------------------------  (CityList)
  static Future<void> CityList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"StateId": "1","ApiAdd":"CityList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=CityList';
    var res = await http.get(Uri.parse(url));
    Map<String, dynamic> data;
    if (res.statusCode == 200) {
      log("CityList Api Call.............");
      data = jsonDecode(res.body);
      city_list.clear();
      city_list = data["Table1"];
    } else {
      log("Error........ CityList Api ");
    }
  }

  static Future<Position> get_loc() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      Geolocator.openLocationSettings();
      return Future.error("Location services are disabled.");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location Permission are permanently denied, we cannot request");
    }
    return await Geolocator.getCurrentPosition();
  }

  // -------------------------------------------------------------------------------------------  (MerchantRegistration)
  static Future<String> MerchantRegistration({
    required String MName,
    required String BName,
    required String mobile,
    required String othermobileno,
    required String email,
    required String ServiceId,
    required String F_SubServiceCategory,
    required String OrgAddress,
    required String StateId,
    required String CityId,
    required String AreaId,
    required String MPin,
    required String Longitude,
    required String Latitude,
    required String IsMasterReferCode,
  }) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MName":"$MName","BName":"$BName","Mobile":"$mobile","OtherMobileNo":"$othermobileno","Email":"$email","ServiceId":"$ServiceId","F_SubServiceCategory":"$F_SubServiceCategory","OrgAddress":"$OrgAddress","StateId":"$StateId","CityId":"$CityId","AreaId":"$AreaId","MPin":"$MPin","Longitude":"$Longitude","Latitude":"$Latitude","IsMasterReferCode":"$IsMasterReferCode","ApiAdd":"MerchantRegistration","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=YourOrgID&ApiAdd=MerchantRegistration';
    print(url);
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("MerchantRegistration Api Call.............");
      print(res);
      print(res.body);
      var data = jsonDecode(res.body);
      return data["Table"][0]["ResultCode"];
    } else {
      log("Error........ MerchantRegistration Api ");
      return " ";
    }
  }
  // ____________________________________________________________________   (Service Question List  )
  static Future<void> Service_Question_List() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MemberMasterId":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"ServiceId":'"'${User_info["Table"][0]["ServiceID"]}'"',"IsHindi":"${prefs.getInt("is_Hindi")}","ApiAdd":"ServiceQuestionList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ServiceQuestionList';
   print(url);
    var res = await http.get(Uri.parse(url));
    
    if (res.statusCode == 200) {
      log("Service_Question_List Api Call.............");
      H_Questions.clear();
      H_Questions = jsonDecode(res.body);
      // city_list = data["Table1"];
      print(H_Questions);
    } else {
      log("Error........ Service_Question_List Api ");
    }
  }
  // ____________________________________________________________________   (MerchantAnswareInsert )
  static Future<void> MerchantAnswareInsert({required int Q_id,required String Question,String Answer1 ="",String Answer2="",String Answer3="",String Answer4="",String Answer5="",String Answer6="",String Answer7=""}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"F_MemberMaster":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"F_ServiceCatagory":'"\"${User_info["Table"][0]["ServiceID"]}\""',"F_ServiceQuestionMaster":'"\"$Q_id\""',"Question":'"\"$Question\""',"Answer1":'"\"$Answer1\""',"Answer2":'"\"$Answer2\""',"Answer3":'"\"$Answer3\""',"Answer4":'"\"$Answer4\""',"Answer5":'"\"$Answer5\""',"Answer6":'"\"$Answer6\""',"Answer7":'"\"$Answer7\""',"ApiAdd":"MerchantAnswareInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchantAnswareInsert';
   print(url);
    var res = await http.get(Uri.parse(url));
    
    if (res.statusCode == 200) {
      log("MerchantAnswareInsert Api Call.............");
      var data = jsonDecode(res.body);
     await Service_Question_List();
      print(data);
    } else {
      log("Error........ MerchantAnswareInsert Api ");
    }
  }

}
