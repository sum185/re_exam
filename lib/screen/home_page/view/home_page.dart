import 'package:flutter/material.dart';
import 'package:re_exam/screen/cart_page/controller/addcart_controller.dart';
import 'package:re_exam/screen/home_page/model/ProductModel.dart';
import 'package:re_exam/utils/api_helper.dart';
import 'package:re_exam/utils/db_helper.dart';
import 'package:get/get.dart';
class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  Addcart_Contoller addcart_contoller =Get.put(Addcart_Contoller());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Product",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
           DbHelper.dbHelper.readData();
            Get.toNamed('Addcart');
          }, icon: Icon(Icons.shopping_bag,color: Colors.white,))
        ],
      ),
      body: FutureBuilder<List<dynamic>?>(
        future: Api_Helper.api_helper.productApi(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            List? p1 = snapshot.data;
            return ListView.builder(
              itemCount: p1!.length,
              itemBuilder: (context, index) {
                return Container(
                    height: 200,
                    width: 300,
                    color: Colors.blue,
                    margin: EdgeInsets.all(3),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 150,
                            width: 120,
                            color: Colors.blueAccent,
                            child: Image.network(
                              "${p1[index].image}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "${p1[index].title}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                              Text("Rs. ${p1[index].price}",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),),
                              Text("Rating ${p1[index].rating!.rate}",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),),
                              SizedBox(height: 20,),
                              ElevatedButton(onPressed: (){

                                DbHelper.dbHelper.insertData(name: p1[index].title!, price: p1[index].price.toString(), image: p1[index].image!,);
                                addcart_contoller.getData();
                              }, child: Text("Add to cart"))
                            ],
                          ),
                        )
                      ],
                    ));
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
