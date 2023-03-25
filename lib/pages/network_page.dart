import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:networking_request/pages/product_page.dart';
import 'package:networking_request/servise/http_servise.dart';

import '../model/post_model.dart';

class NetworkPage extends StatefulWidget {
  static const route="network_page";

  const NetworkPage({Key? key}) : super(key: key);

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  var isloading = false;
  List<Post> items = [];

  @override
  void initState() {
    super.initState();
    var post = Post(
        id: 2,
        employee_name: "PDP",
        employee_salary: 3500,
        employee_age: 23,
        profile_image: "");
    _apiPostList();
  }

  void _apiPostList() async {
    setState(() {
      isloading = true;
    });

    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      setState(() {
        isloading = false;
        items = Network.parsePostList(response);
      });
    }
  }

  void _apiPostCreate(Post post) {
    Network.POST(Network.API_CREATE, Network.paramsCreate(post))
        .then((response) => {print(response.toString())});
  }

  void _apiPostUpdate(Post post) {
    Network.PUT(
            Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post))
        .then((response) => {print(response.toString())});
  }

  void _apiPostDelete(Post post) {
    Network.DELETE(
            Network.API_DELETE + post.id.toString(), Network.paramsEmpty())
        .then((response) => {
              _apiPostList(),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            return itemHomePost(items[index]);
          },
        ),
        isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox.shrink()
      ],
    ));
  }

  Widget itemHomePost(Post post) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductPage.route,arguments: {
          "post":post
        });
      },
      child: Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  _apiPostDelete(post);
                },
                flex: 3,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: "Delete",
              )
            ],
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(post.employee_name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 22)),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "(${post.employee_age.toString()})",
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "${post.employee_salary} \$",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 22),
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
          )),
    );
  }
}
