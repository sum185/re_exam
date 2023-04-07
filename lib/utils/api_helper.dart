import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:re_exam/screen/home_page/model/ProductModel.dart';

class Api_Helper
{
  Api_Helper._();
  static Api_Helper api_helper =Api_Helper._();

 Future<List<dynamic>?> productApi()
  async{
    String apiLink = "https://fakestoreapi.com/products";
    var response = await http.get(Uri.parse(apiLink));
    if(response.statusCode==200)
      {
        var json =jsonDecode(response.body);
        List dataList = json.map((e)=> ProductModel.fromJson(e)).toList();
        return  dataList;
      }

  }
}