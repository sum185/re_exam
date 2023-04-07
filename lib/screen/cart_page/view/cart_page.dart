import 'package:flutter/material.dart';
import 'package:re_exam/screen/cart_page/controller/addcart_controller.dart';
import 'package:get/get.dart';
import 'package:re_exam/utils/db_helper.dart';
class Cart_Page extends StatefulWidget {
  const Cart_Page({Key? key}) : super(key: key);

  @override
  State<Cart_Page> createState() => _Cart_PageState();
}

class _Cart_PageState extends State<Cart_Page> {
  Addcart_Contoller addcart_contoller = Get.put(Addcart_Contoller());
  @override
  void initState() {
    addcart_contoller.getData();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text("Cart Page",style: TextStyle(color: Colors.white),),
            centerTitle: true,
          ),
          backgroundColor: Colors.white30,
          body: Obx(
            () => ListView.builder(itemCount: addcart_contoller.dataList.length,itemBuilder: (context, index) {
              return Container(
                height: 100,
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    leading: Container(
                      height: 100,
                      width: 50,
                      color: Colors.white,
                      child: Image.network("${addcart_contoller.dataList[index]['image']}",fit: BoxFit.fill,),
                    ),
                    title: Text("${addcart_contoller.dataList[index]['name']}",maxLines: 2,overflow: TextOverflow.ellipsis),
                    subtitle: Text("${addcart_contoller.dataList[index]['price']}"),
                    trailing: IconButton(onPressed: (){
                      DbHelper.dbHelper.deleteData(id: addcart_contoller.dataList[index]['id']);
                      addcart_contoller.getData();
                    },icon: Icon(Icons.delete,color: Colors.black,)),
                  ),
                )
              );
            },),
          ),
        )
    );
  }
}
