import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/post_model.dart';
import '../servise/http_servise.dart';

class ProductPage extends StatefulWidget {
  static const route="product_page";

  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  var isloading = false;


  @override
  void initState() {
    super.initState();

  }

  void _apiPostList(Post post) async {
    setState(() {
      isloading = true;
    });
    var response = await Network.GET(Network.API_LISTN+post.id.toString(), Network.paramsEmpty());
    if (response != null) {
      setState(() {
        isloading = false;

      });
    }
  }




  @override
  Widget build(BuildContext context) {
    final product=ModalRoute.of(context)!.settings.arguments as Map<String,Post>;
    Post? pr=product["post"];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((pr!.employee_name).toString(),style: TextStyle(fontSize: 22,color: Colors.black87,fontWeight: FontWeight.bold),),
                SizedBox(width: 8,),
                Text("(${pr.employee_age.toString()})",style: TextStyle(fontSize: 22),)
              ],
            ),
            SizedBox(height: 8,),
            Text(pr.employee_salary.toString(),style: TextStyle(fontSize: 22),)
          ],
        )
      ),
    );
  }
}
