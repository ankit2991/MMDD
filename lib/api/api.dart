import "dart:convert";
import "dart:developer";
import "dart:io";
import "dart:ui";
import 'dart:ui' as ui;
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import 'package:geolocator/geolocator.dart';
import "package:image_picker/image_picker.dart";
import "package:open_filex/open_filex.dart";
import "package:path_provider/path_provider.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import "package:url_launcher/url_launcher.dart";
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Api {
  static List<dynamic> CategoryList_data = [];
  static List<dynamic> Sub_CategoryList_data = [];
  static List<dynamic> state_list = [];
  static List<dynamic> city_list = [];
  static var User_info;
  static Map<String, dynamic> H_Questions = {};
  static late SharedPreferences prefs;
  static bool loading = false;
  static Future<void> local_dataBase() async {
    prefs = await SharedPreferences.getInstance();
  }

  // -------------------------------------------------------------------------------------------  (send OTP)
  static Future<void> send_otp(String mob_no,context) async {
    // String url='https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo":'"'$mob_no'"',"ApiAdd":"MobileOTP","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MobileOtp';
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo":'
        "'$mob_no'"
        ',"ApiAdd":"MobileOTP","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MobileOTP';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      print(res.body);
      var data= jsonDecode(res.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Duplicate data")));
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
      User_info = data;

      await prefs.setBool('login', true);
      await prefs.setString("mpin", Mpin);
      await prefs.setString("mobile_no", mob_no);
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

  static Future<Position> get_loc(context,Function loader)async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      Geolocator.openLocationSettings();
      // Geolocator.openAppSettings();
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(SnackBar(content: Text("turn on Location")));
      loader(false);
      return Future.error("Location services are disabled.");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        loader(false);
         ScaffoldMessenger.maybeOf(context)!.showSnackBar(SnackBar(content: Text("Location permissions are denied")));
        return Future.error("Location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
       loader(false);
       ScaffoldMessenger.maybeOf(context)!.showSnackBar(SnackBar(content: Text("Location Permission are permanently denied")));
      return Future.error(
          "Location Permission are permanently denied, we cannot request");
    }
    //  loader(false);
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
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MemberMasterId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"ServiceId":'
        "'${User_info["Table"][0]["ServiceID"]}'"
        ',"IsHindi":"${prefs.getInt("is_Hindi")}","ApiAdd":"ServiceQuestionList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ServiceQuestionList';
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
  static Future<void> MerchantAnswareInsert(
      {required int Q_id,
      required String Question,
      String Answer1 = "",
      String Answer2 = "",
      String Answer3 = "",
      String Answer4 = "",
      String Answer5 = "",
      String Answer6 = "",
      String Answer7 = ""}) async {
    //   Uint8List  ab =Uint8List.fromList(utf8.encode(Question));
    //  String encodedQuestion= utf8.decode(ab);
    // String encodedQuestion = URLEncoder.encode(Question, "UTF-8");
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"F_MemberMaster":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"F_ServiceCatagory":'
        "\"${User_info["Table"][0]["ServiceID"]}\""
        ',"F_ServiceQuestionMaster":'
        "\"$Q_id\""
        ',"Question":'
        "\"$Question\""
        ',"Answer1":'
        "\"$Answer1\""
        ',"Answer2":'
        "\"$Answer2\""
        ',"Answer3":'
        "\"$Answer3\""
        ',"Answer4":'
        "\"$Answer4\""
        ',"Answer5":'
        "\"$Answer5\""
        ',"Answer6":'
        "\"$Answer6\""
        ',"Answer7":'
        "\"$Answer7\""
        ',"ApiAdd":"MerchantAnswareInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchantAnswareInsert';
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

  // ____________________________________________________________________   ( Event Booking Details List  )
  static Future<List<dynamic>> EventBookingDetailsList(
      {required String Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent,
      required String Is_booking}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"EventList":'
        "'$Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent'"
        ',"MerchantId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"IsBooking":'
        "'$Is_booking'"
        ',"MerchantId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"ApiAdd":"EventBookingDetailsList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=EventBookingDetailsList';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("EventBookingDetailsList Api Call.............");
      var data = jsonDecode(res.body);
      // city_list = data["Table1"];
      log("EventBookingDetailsList Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ EventBookingDetailsList Api ");
      throw ("Error........ EventBookingDetailsList Api ");
    }
  }

  // ____________________________________________________________________   ( Event Booking Details List  )
  static Future<void> RecipitInsert(
      {required String Amount,
      required String Event_id,
      required String Remark}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Amount":\"$Amount\","EventId":\"$Event_id\","F_VoucherTypeMaster":"1","F_LedgerDr":\"$Event_id\","F_LedgerCr":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"Remarks":\"$Remark\","ApiAdd":"RecipitInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=RecipitInsert';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("RecipitInsert Api Call.............");
      var data = jsonDecode(res.body);
      // city_list = data["Table1"];
      log("RecipitInsert Api DATA .............");
      // print(data);
      // return data["Table1"];
    } else {
      log("Error........ RecipitInsert Api ");
      throw ("Error........ RecipitInsert Api ");
    }
  }

  // ____________________________________________________________________   (Show service in event )
  static Future<List<dynamic>> FacilityReport() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MerchantId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"ApiAdd":"FacilityReport","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=FacilityReport';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("FacilityReport Api Call.............");
      var data = jsonDecode(res.body);
      log("FacilityReport Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ FacilityReport Api ");
      throw ("Error........ FacilityReport Api ");
    }
  }

  // ____________________________________________________________________   (All images )
  static Future<List<dynamic>> AccountDocument() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"AccountId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"ApiAdd":"AccountDocument","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=AccountDocument';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("AccountDocument Api Call.............");
      var data = jsonDecode(res.body);
      log("AccountDocument Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ AccountDocument Api ");
      throw ("Error........ AccountDocument Api ");
    }
  }

  // ____________________________________________________________________   (ImageInsert )
  static Future<void> ImageInsert(
      {required File? img,
      required String DocType,
      required String ext,
      required String MemberAgreementUpload_UploadFile2,context}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/$MemberAgreementUpload_UploadFile2';
    print(
        "=================================================================================");
    print(url);
    final headers = {
      'Content-Type': 'application/json',
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        "base64", // Field name expected by the API
        img!.path,
      ),
    );
    request.fields["AccountId"] = "${User_info["Table"][0]["Id"].toInt()}";
    request.fields["DocType"] = DocType;
    request.fields["fileExtention"] = ext;
    var res = await request.send();
    if (res.statusCode == 200) {

      log("ImageInsert Api Call.............");
      var data = await res.stream.bytesToString();
      log("ImageInsert Api DATA .............");
      print(data);
      if(data.contains("R200")){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Duplicate pdf")));
      }else{
        if(ext==".pdf"){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("PDF upload Done")));
        }else if(ext==".mp4"){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Video upload Done")));
        }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image upload Done")));

        }
      }
      // return data["Table1"];
    } else {
      log("Error........ ImageInsert Api ");
      throw ("Error........ ImageInsert Api ");
    }
  }

  // ____________________________________________________________________   (add service in event )
  static Future<bool> RecipitFacilityInsert(
      {required List<Map> serviceAdd,
      required String EventId,
      required String Amount,
      required String Remarks}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Amount":"${double.parse(Amount).toInt()}","EventId":"${double.parse(EventId).toInt()}","F_VoucherTypeMaster":"1","F_LedgerDr":\"${double.parse(EventId).toInt()}\","F_LedgerCr":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"RequestJson":{"Services":$serviceAdd},"Remarks":"$Remarks","ApiAdd":"RecipitFacilityInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=RecipitFacilityInsert';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("RecipitFacilityInsert Api Call.............");
      // H_Questions.clear();
      // H_Questions = jsonDecode(res.body);
      // print(H_Questions);
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ RecipitFacilityInsert Api ");
      throw ("Error........ RecipitFacilityInsert Api ");
    }
  }

  // ____________________________________________________________________   (MerchentLicanceDetail  )
  static Future<bool> MerchentLicanceDetail(
      {required String FassiLicNo,
      required String Gst,
      required String nigamlicanceNo}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"FassiLicNo":\"$FassiLicNo\","nigamlicanceNo":\"$nigamlicanceNo\","GSTNo":\"$Gst\","MemberId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"ApiAdd":"MerchentLicanceDetail","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchentLicanceDetail';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("MerchentLicanceDetail Api Call.............");

      var data = jsonDecode(res.body);
      print(data);
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ MerchentLicanceDetail Api ");
      throw ("Error........ MerchentLicanceDetail Api ");
    }
  }

  // ____________________________________________________________________   (Merchent Bank Detail  )
  static Future<bool> MerchentBankDetail(
      {required String Mer_AcHolderName,
      required String Mer_bankAcc,
      required String Mer_IFSCCode,
      required String Mer_bankName}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Mer_AcHolderName":\"$Mer_AcHolderName\","Mer_bankAcc":\"$Mer_bankAcc\","Mer_IFSCCode":\"$Mer_IFSCCode\","Mer_bankName":\"$Mer_bankName\","ApiAdd":"MerchentBankDetail","MemberId":"242","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchentBankDetail';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("MerchentBankDetail Api Call.............");

      var data = jsonDecode(res.body);
      print(data);
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ MerchentBankDetail Api ");
      throw ("Error........ MerchentBankDetail Api ");
    }
  }

  // ____________________________________________________________________   (add service in event )
  static Future<bool> CustomerRegistration({
    required String Mobile,
    required String CName,
    required String Email,
    required String Remarks,
    required String EventName,
    required String Longitude,
    required String Latitude,
    required String EventAddress,
    required String EventEndDate,
    required String Isbooking,
    required String EventStartDate,
    required String EventStartTime,
    required String EventEndTime,
    required String TotalAmount,
    required String BookingAmount,
    required String DueAmount,context
  }) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Mobile":"$Mobile","CName":"$CName","Email":"$Email","ServiceId":"0","MerchantId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"Isbooking":"$Isbooking","EventName":"$EventName","Longitude":"$Longitude","Latitude":"$Latitude","EventAddress":"$EventAddress","EventStartDate":"$EventStartDate","EventEndDate":"$EventEndDate","EventStartTime":"$EventStartTime","EventEndTime":"$EventEndTime","TotalAmount":"$TotalAmount","BookingAmount":"$BookingAmount","DueAmount":"$DueAmount","Remarks":"$Remarks","F_VoucherTypeMaster":"1","ApiAdd":"CustomerRegistration","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=CustomerRegistration';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(data);
      if (data["Table"][0]["ResultCode"]=="R200") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Duplicate User")));
        return false;
      }
      log("RecipitFacilityInsert Api Call.............");
      return true;
    } else {
      log("Error........ RecipitFacilityInsert Api ");
      throw ("Error........ RecipitFacilityInsert Api ");
    }
  }

  // -------------------------------------------------------------- (send Image )
  static Future<Map<String, dynamic>> pickImage(
      {required ImageSource source, required bool img}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = img
        ? await _picker.pickImage(source: source)
        : await _picker.pickVideo(source: source);
    if (pickedFile != null) {
      print(pickedFile.path);
      String ext = pickedFile.path.split(".").last;
      return {
        "file": File(pickedFile.path),
        "ext": ext,
      };
    }
    return {"file": "", "ext": ""};
  }

  static Future<String> img_convert(File? img) async {
    final File imageFile = File(img!.path);
    final bytes = await imageFile.readAsBytes();
    final String base64Image = base64Encode(bytes);
    print(base64Image);
    return base64Image;
  }

  // __________________________________________________________________   ( download PDF )
  static Future<File?> downloadPdf(
      {required String url, required String fileName}) async {
    try {
      // Send HTTP request to get the file
      final response = await http.get(Uri.parse(url));
      String? directorys;
      if (response.statusCode == 200) {
        // Get the app's directory for storing files
        if (Platform.isAndroid) {
          // Use the external storage directory for Android
          final directory = Directory('/storage/emulated/0/Download');
          if (await directory.exists()) {
            directorys = directory.path;
          } else {
            var temp = await getDownloadsDirectory();
            directorys = temp!.path;
          }
        } else if (Platform.isIOS) {
          // Use the app's documents directory for iOS (iOS doesn't have a shared Downloads folder)
          final directory = await getApplicationDocumentsDirectory();
          directorys = directory.path;
        } else {
          // return null; // Unsupported platform
        }
        // final directory = await getDownloadsDirectory();
        final filePath = '$directorys/$fileName';

        // Save the file locally
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        print("File downloaded successfully to: $filePath");
        return file;
        // OpenFilex.open(filePath);
      } else {
        print("Failed to download file. HTTP Status: ${response.statusCode}");
        // return null;
        throw ("Failed to download file. HTTP Status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

  // _________________________________________________________________________________________
  static Future<File?> widget_to_img(final GlobalKey _globalKey) async {
    final RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Convert the boundary to an image
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Save the image to a file
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/widget_image.png');
    await file.writeAsBytes(pngBytes);
    print("Image saved to: ${file.path}");
    return file;
  }

  // _________________________________________________________________________________________________________
  static Future<void> moveFileToLocalStorage() async {
    try {
      // Load the file from the assets folder
      final byteData =
          await rootBundle.load('assets/images/main/downloadedFile.pdf');

      // Get the local directory path
      String? directorys;
      if (Platform.isAndroid) {
        // Use the external storage directory for Android
        final directory = Directory('/storage/emulated/0/Download');
        if (await directory.exists()) {
          directorys = directory.path;
        } else {
          var temp = await getDownloadsDirectory();
          directorys = temp!.path;
        }
      } else if (Platform.isIOS) {
        // Use the app's documents directory for iOS (iOS doesn't have a shared Downloads folder)
        final directory = await getApplicationDocumentsDirectory();
        directorys = directory.path;
      }
      // Create the file in the local storage
      final file = File('${directorys}/sample.pdf');

      // Write the byte data to the file
      await file.writeAsBytes(byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ));

      print('File moved to: ${file.path}');
    } catch (e) {
      print('Error moving file: $e');
    }
  }

  // _______________________________________________________________
  static Future<String?> pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final filePath = result.files.single.path;
      print('Selected PDF path: $filePath');
      return filePath;
    } else {
      print('No file selected');
    }
  }

// ________________________________________________________________________ (banner images)
  static Future<List<dynamic>> BannerReport() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"BannerReport","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=BannerReport';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("BannerReport Api Call.............");
      var data = jsonDecode(res.body);
      log("BannerReport Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ BannerReport Api ");
      throw ("Error........ BannerReport Api ");
    }
  }

// ________________________________________________________________________ (service)
  static Future<List<dynamic>> service(String service_id) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"F_ServiceCategory":\"$service_id\","ApiAdd":"SubServiceCategoryList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=SubServiceCategoryList';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("service Api Call.............");
      var data = jsonDecode(res.body);
      log("service Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ service Api ");
      throw ("Error........ service Api ");
    }
  }

  // ____________________________________________________________________   (FacilityInsert_nonimg )
  static Future<bool> FacilityInsert_nonimg({
    required String FacilityName,
    required String F_SubServiceCategory,
    required String Amount,
    required String Description,
  }) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"FacilityName":"$FacilityName","MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","F_SubServiceCategory":"$F_SubServiceCategory","Amount":"$Amount","Description":"$Description","FacilityImg":"","ApiAdd":"FacilityInsert_nonimg","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=FacilityInsert_nonimg';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("FacilityInsert_nonimg Api Call.............");
      return true;
    } else {
      log("Error........ FacilityInsert_nonimg Api ");
      throw ("Error........ FacilityInsert_nonimg Api ");
    }
  }

// ________________________________________________________________________ (service)
  static Future<List<dynamic>> ServiceList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ApiAdd":"ServiceList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ServiceList';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("ServiceList Api Call.............");
      var data = jsonDecode(res.body);
      log("ServiceList Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ service Api ");
      throw ("Error........ service Api ");
    }
  }

  // ____________________________________________________________________   (ServiceEnquiryInsert )
  static Future<bool> ServiceEnquiryInsert({
    required String personName,
    required String serviceName,
    required String mobile,
  }) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"personName":"$personName","serviceName":"$serviceName","mobile":"$mobile","MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"ServiceEnquiryInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ServiceEnquiryInsert';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("ServiceEnquiryInsert Api Call.............");
      return true;
    } else {
      log("Error........ ServiceEnquiryInsert Api ");
      return false;
      // throw("Error........ ServiceEnquiryInsert Api ");
    }
  }

  // ____________________________________________________________________   (Add_Merchant_TremAndCond )
  static Future<bool> Add_Merchant_TremAndCond(
      {required String TermsAndConditions}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MemberMasterId":\"${User_info["Table"][0]["Id"].toInt()}\","TermsAndConditions":"$TermsAndConditions","ApiAdd":"MemberAddTremAndCond","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MemberAddTremAndCond';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("Add_Merchant_TremAndCond Api Call.............");
      return true;
    } else {
      log("Error........ Add_Merchant_TremAndCond Api ");
      return false;
      // throw("Error........ ServiceEnquiryInsert Api ");
    }
  }

// ________________________________________________________________________ (Merchentwisecustomer)
  static Future<List<dynamic>> Merchentwisecustomer() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MemberId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"Merchentwisecustomer","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=Merchentwisecustomer';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("Merchentwisecustomer Api Call.............");
      var data = jsonDecode(res.body);
      log("Merchentwisecustomer Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ Merchentwisecustomer Api ");
      throw ("Error........ Merchentwisecustomer Api ");
    }
  }

// ________________________________________________________________________ (GetMerchentcustomerReview)
  static Future<List<dynamic>> GetMerchentcustomerReview() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"F_MemberMaster":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"GetMerchentcustomerReview","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=GetMerchentcustomerReview';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("GetMerchentcustomerReview Api Call.............");
      var data = jsonDecode(res.body);
      log("GetMerchentcustomerReview Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ GetMerchentcustomerReview Api ");
      throw ("Error........ GetMerchentcustomerReview Api ");
    }
  }

  // ___________________________________________________________________    (open phone dailer)
  static Future<void> launchDialer(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // ____________________________________________________________   (add service pdf)
  static Future<void> createPdf(
      {required String now_Date,
      required String event_name,
      required String event_date,
      required String compny_name,
      required String comp_mob_no,
      required String cust_mob_no,
      required String cust_name,
      required String Total,
      required List<Map> data,required bool add_service,String Amount="",String Advance_Amount="",String Du_Amount=""}  ) async {
    // Create a PDF document
    final pdf = pw.Document();
     final fontData = await rootBundle.load('assets/fonts/Poppins/Poppins-SemiBold.ttf');
    final ttf = pw.Font.ttf(fontData);
    List<pw.TableRow> Rows = [
      pw.TableRow(
        decoration: pw.BoxDecoration(color: PdfColors.grey300),
        children: [
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('S.No.',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('Service Name',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('Quantity',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('Price',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('Total',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
        ],
      ),
    ];
if(add_service){
  
    for (var i = 0; i < data.length; i++) {
      try {
         Rows.add(pw.TableRow(
                      children: [
                        pw.Padding(
                            padding: pw.EdgeInsets.symmetric(vertical: 10),
                            child: pw.Text(
                             "${i+1}",
                              textAlign: pw.TextAlign.center,
                            )),
                        pw.Padding(
                            padding: pw.EdgeInsets.symmetric(vertical: 10),
                            child: pw.Text(
                              data[i]["\"Name\""].substring(1, data[i]["\"Name\""].length - 1),
                              textAlign: pw.TextAlign.center,
                            )),
                        pw.Padding(
                            padding: pw.EdgeInsets.symmetric(vertical: 10),
                            child: pw.Text(
                              data[i]["\"Quantity\""].substring(1, data[i]["\"Quantity\""].length - 1),
                              textAlign: pw.TextAlign.center,
                            )),
                        pw.Padding(
                            padding: pw.EdgeInsets.symmetric(vertical: 10),
                            child: pw.Text(
                              data[i]["\"Price\""].substring(1, data[i]["\"Price\""].length - 1),
                              textAlign: pw.TextAlign.center,
                            )),
                        pw.Padding(
                            padding: pw.EdgeInsets.symmetric(vertical: 10),
                            child: pw.Text(
                              data[i]["\"Total\""].substring(1, data[i]["\"Total\""].length - 1),
                              textAlign: pw.TextAlign.center,
                            )),
                      ],
                    ),);
 
      } catch (e) {
        continue;
      }
        }
}
    // Add a page
    pdf.addPage(pw.Page(
        // pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(top: 20, left: 10, right: 10),
        build: (pw.Context context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Left Corner Heading

                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'MMDD',
                        style: pw.TextStyle(
                          fontSize: 15,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Container(
                          padding: pw.EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          color: PdfColors.blue,
                          child: pw.Text("INVOICE",
                              style: pw.TextStyle(color: PdfColors.white)))
                    ]),

                // Main content
                pw.SizedBox(height: 5),
                pw.Divider(
                  thickness: 0.5, // Thickness of the divider
                  color: PdfColors.black, // Color of the divider
                ),
                pw.Container(
                    height: 50,
                    // color: PdfColors.amber,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                        children: [
                          pw.Row(children: [
                            pw.Text("Invoice Date: ",
                                style: pw.TextStyle(
                                    color: PdfColor(0.5, 0.5, 0.5))),
                            pw.Text(now_Date,
                                style: pw.TextStyle(color: PdfColors.black))
                          ]),
                          pw.Row(children: [
                            pw.Text("Event Name: ",
                                style: pw.TextStyle(
                                    color: PdfColor(0.5, 0.5, 0.5))),
                            pw.Text(event_name,
                                style: pw.TextStyle(color: PdfColors.black))
                          ]),
                          pw.Row(children: [
                            pw.Text("Event Date:",
                                style: pw.TextStyle(
                                    color: PdfColor(0.5, 0.5, 0.5))),
                            pw.Text(event_date,
                                style: pw.TextStyle(color: PdfColors.black))
                          ]),
                        ])),
                pw.SizedBox(height: 5),
                pw.Row(children: [
                  pw.Container(
                      width: 350,
                      height: 50,
                      // color: PdfColors.amber,
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Company"),
                            pw.Text(compny_name,
                                style: pw.TextStyle(
                                    color: PdfColor(0.5, 0.5, 0.5))),
                            pw.Text("Phone: $comp_mob_no",
                                style: pw.TextStyle(
                                    color: PdfColor(0.5, 0.5, 0.5))),
                          ])),
                  pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        pw.Text("Customer"),
                        pw.Text(cust_name,
                            style:
                                pw.TextStyle(color: PdfColor(0.5, 0.5, 0.5))),
                        pw.Text("Phone: $cust_mob_no ",
                            style:
                                pw.TextStyle(color: PdfColor(0.5, 0.5, 0.5))),
                      ])),
                ]),
                pw.SizedBox(height: 5),
                if(add_service==false)
                pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  height: 60,width: double.infinity,child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [pw.Text("Total Amount"),pw.Text("₹${Total}",style: pw.TextStyle(fontWeight: pw.FontWeight.bold,font: ttf)),]),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [pw.Text("Today Amount",),pw.Text("₹${Amount}",style: pw.TextStyle(fontWeight: pw.FontWeight.bold,font: ttf)),]),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [pw.Text("Advance Amount"),pw.Text("${Advance_Amount}",style: pw.TextStyle(fontWeight: pw.FontWeight.bold,font: ttf)),])
                ],)),
                if(add_service==false)
                pw.Container(
                  margin: pw.EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  height: 40,
                  width: double.maxFinite,
                  alignment: pw.Alignment.center,
                  color:  PdfColors.blue,
                  child: pw.Text("Due Amount: ₹${Du_Amount}",style: pw.TextStyle(color: PdfColors.white,fontSize: 20,font: ttf))
                ),
                if(add_service)
                pw.Table(
                  border: pw.TableBorder.all(
                      color: PdfColor(.5, .5, .5)), // Add border to the table
                  // defaultColumnWidth: pw.FixedColumnWidth(20),
                  columnWidths: {
                    0: pw.FixedColumnWidth(100), // Fixed width for column 1
                    1: pw.FlexColumnWidth(2), // Flexible width for column 2
                    2: pw.FlexColumnWidth(1), // Flexible width for column 3
                    3: pw.FlexColumnWidth(1), // Flexible width for column 3
                    4: pw.FlexColumnWidth(1), // Flexible width for column 3
                  },
                  children: Rows,    ),
                if(add_service)
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Total",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(Total,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ]),
                
                pw.Text("Terms & Conditions:"),
                pw.Text(cust_name,
                    style: pw.TextStyle(color: PdfColor(0.5, 0.5, 0.5))),
              ],
            )));
    final directory = Directory('/storage/emulated/0/Download');
    final file = File("${directory!.path}/${DateTime.now().millisecondsSinceEpoch}.pdf");
    
    await file.writeAsBytes(await pdf.save());
    OpenFilex.open(file.path);
    log("Save done");
  }
   // ____________________________________________________________________   (FacilityDiscountInsert )
  static Future<bool> FacilityDiscountInsert(
      {
      required String FacilityId,
      required String DiscountAmount,
      required String IsDiscount}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"FacilityId":"$FacilityId","IsDiscount":"$IsDiscount","DiscountAmount":"$DiscountAmount","ApiAdd":"FacilityDiscountInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=FacilityDiscountInsert';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("RecipitFacilityInsert Api Call.............");
      var data = jsonDecode(res.body);
      print(data);
      // H_Questions.clear();
      // H_Questions = jsonDecode(res.body);
      // print(H_Questions);
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ RecipitFacilityInsert Api ");
      throw ("Error........ RecipitFacilityInsert Api ");
    }
}

static Future<List<dynamic>> SubscriptionList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ApiAdd":"SubscriptionList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=SubscriptionList';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("SubscriptionList Api Call.............");
      var data = jsonDecode(res.body);
      // city_list = data["Table1"];
      log("SubscriptionList Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ SubscriptionList Api ");
      throw ("Error........ SubscriptionList Api ");
    }
  }
  static Future<Map> get_Merchent_Trem_And_Condition()async{
      String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"MerchentTNC","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchentTNC';
    print(url);
    var res = await http.get(Uri.parse(url));
    if(res.statusCode==200){
      log("get_Merchent_Trem_And_Condition Api call.....");
       var data = jsonDecode(res.body);
       return data;
    }else{
      throw "Error:- get_Merchent_Trem_And_Condition";
    }
  }
}
