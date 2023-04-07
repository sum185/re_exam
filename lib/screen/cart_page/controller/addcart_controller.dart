import 'package:get/get.dart';
import 'package:re_exam/utils/db_helper.dart';

class Addcart_Contoller extends GetxController
{
  RxList<Map> dataList= <Map>[].obs;
  Future<void> getData()
  async {
    dataList.value = await DbHelper.dbHelper.readData();
  }
}