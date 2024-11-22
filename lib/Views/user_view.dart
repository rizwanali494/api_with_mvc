import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/user_model.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {

  List<UserModel> userlist = [];

  Future<List<UserModel>> getUserApi() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for( Map i in data){
        userlist.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return userlist;
    }else{
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot){
                    if(!snapshot.hasData){
                      return const Center(child: CircularProgressIndicator(),);
                    }else{
                      return ListView.builder(
                          itemCount: userlist.length,
                          itemBuilder: (context, index){
                            return Card(
                              child: Column(
                                children: [
                                  ReuseableRow(title: "ID", value: snapshot.data![index].id.toString()),
                                  ReuseableRow(title: "Name", value: snapshot.data![index].name.toString()),
                                  ReuseableRow(title: "User Name", value: snapshot.data![index].username.toString()),
                                  ReuseableRow(title: "Email", value: snapshot.data![index].email.toString()),
                                  ReuseableRow(title: "Phone", value: snapshot.data![index].phone.toString()),
                                  ReuseableRow(title: "Website", value: snapshot.data![index].website.toString()),
                                  ReuseableRow(title: "Company", value: snapshot.data![index].company.name.toString()),
                                  // ReuseableRow(title: "CatchPhrase", value: snapshot.data![index].company.catchPhrase.toString()),
                                  ReuseableRow(title: "BS", value: snapshot.data![index].company.bs.toString()),
                                  ReuseableRow(title: "Address", value: snapshot.data![index].address.toString()),
                                  ReuseableRow(title: "City", value: snapshot.data![index].address.city.toString()),
                                  ReuseableRow(title: "Geo Longitude", value: snapshot.data![index].address.geo.lng.toString()),
                                  ReuseableRow(title: "Geo Latitude", value: snapshot.data![index].address.geo.lat.toString()),
                                ],
                              ),
                            );
                          }
                      );
                    }
                  }
                )
            )
          ],
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );  }
}

