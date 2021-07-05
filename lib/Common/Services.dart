import 'dart:developer';

import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:the_national_dawn/Common/ClassList.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:http/http.dart' as http;

Dio dio = new Dio();

class Services {
  static Future<List> PostForList({api_name, body}) async {
    String url = API_URL + '$api_name';
    print("$api_name url : " + url);
    print(body);
    Response response = null;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }
      //log("->>>" + response.data.toString());
      if (response.statusCode == 200) {
        List list = [];
        //print("$api_name Response: " + response.data.toString());
        var responseData = response.data;

        if (responseData["IsSuccess"] == true &&
            responseData["Data"].length > 0) {
          //print(responseData["Data"]);
          list = responseData["Data"];
          print("56565656566");
          print(responseData);
          print("56565656566");
        }
        return list;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> PostForList1({api_name, body}) async {
    String url = API_URL1 + '$api_name';
    print("$api_name url : " + url);
    Response response = null;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }
      if (response.statusCode == 200) {
        List list = [];
        print("$api_name Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true &&
            responseData["Data"].length > 0) {
          print(responseData["Data"]);
          list = responseData["Data"];
        }
        return list;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> PostForList2({api_name, body}) async {
    String url = API_URL2 + '$api_name';
    print("$api_name url : " + url);
    Response response = null;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }
      if (response.statusCode == 200) {
        List list = [];
        print("$api_name Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true &&
            responseData["Data"].length > 0) {
          print(responseData["Data"]);
          list = responseData["Data"];
        }
        return list;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> Login(body) async {
    var url = API_URL + "api/login";
    try {
      Response response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        List list = [];
        print("login Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true &&
            responseData["Data"].length > 0) {
          print(responseData["Data"]);
          list = responseData["Data"];
        }
        return list;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> GetEventData(String sdate, edate) async {
    String url = API_URL + 'admin/getEvents?fromDate=${sdate}&toDate=${edate}';
    print("GetEventDetailByDate URL: " + url);
    try {
      Response response = await dio.post(url);
      if (response.statusCode == 200) {
        List list = [];
        print("GetEventDetailByDate Response: " + response.data.toString());
        var regionalData = response.data;
        if (regionalData["IsSuccess"] == true &&
            regionalData["Data"].length > 0) {
          list = regionalData["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("GetEventDetailByDate Error : " + e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<SaveDataClass> postForSave({apiname, body}) async {
    print(body.toString());
    String url = API_URL + '$apiname';
    print("$apiname url : " + url);
    var response;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }

      log("->>> ${response.data}");

      if (response.statusCode == 200) {
        SaveDataClass savedata =
            new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: null);
        print("$apiname Response: " + response.data.toString());
        var responseData = response.data;
        savedata.Message = responseData["Message"];
        savedata.IsSuccess = responseData["IsSuccess"];
        savedata.Data = responseData["Data"].toString();

        return savedata;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<SaveDataClass> postForSave2({apiname, body}) async {
    print(body.toString());
    String url = API_URL2 + '$apiname';
    print("$apiname url : " + url);
    var response;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }
      if (response.statusCode == 200) {
        SaveDataClass savedata =
            new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: null);
        print("$apiname Response: " + response.data.toString());
        var responseData = response.data;
        savedata.Message = responseData["Message"];
        savedata.IsSuccess = responseData["IsSuccess"];
        savedata.Data = responseData["Data"].toString();

        return savedata;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List<OfferClass>> getState() async {
    String url = API_URL + 'admin/businessCategory';
    try {
      Response response = await dio.post(url);
      if (response.statusCode == 200) {
        OfferClassData offerClassData =
            new OfferClassData.fromJson(response.data);
        return offerClassData.Data;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List<OfferClass>> getState1() async {
    String url = API_URL + 'admin/getallMasterCategory';
    try {
      Response response = await dio.post(url);
      if (response.statusCode == 200) {
        OfferClassData offerClassData =
            new OfferClassData.fromJson(response.data);
        return offerClassData.Data;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List<CategoryData>> GetMemberType() async {
    String url = API_URL + 'admin/getAllMemberCategory';
    try {
      Response response = await dio.post(url);
      if (response.statusCode == 200) {
        MemberCategoryData categoryData =
            new MemberCategoryData.fromJson(response.data);
        return categoryData.Data;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> memberCount(body) async {
    var url = API_URL + "admin/updatecount";
    try {
      Response response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        List list = [];
        print("login Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true &&
            responseData["Data"].length > 0) {
          print(responseData["Data"]);
          list = responseData["Data"];
        }
        return list;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
