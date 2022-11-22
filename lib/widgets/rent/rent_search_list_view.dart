import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/rent.dart';
import '../../screens/rent/scan_page.dart';
import 'rent_box.dart';

// Future<List<Rent>> _fetchRentList(String name) async {
//   final url = Uri.parse('http://p-cube-plus.com/rent/list/' + name);
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     print(json.decode(response.body).runtimeType);
//     return (json.decode(response.body) as List)
//         .map((data) => Rent.fromJson(data))
//         .toList();
//   } else {
//     throw Exception('Failed to load post');
//   }
// }

Future<List<Rent>> _fetchRentList(String name) async {
  final url = Uri.parse('http://p-cube-plus.com/rent/list');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(json.decode(response.body).runtimeType);
    return (json.decode(response.body) as List)
        .map((data) => Rent.fromJson(data))
        .toList()
        .where((element) => element.product.name.contains(name))
        .toList();
  } else {
    throw Exception('Failed to load post');
  }
}

class RentSearchListView extends StatelessWidget {
  const RentSearchListView({required this.productName});
  final String productName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Rent>>(
      future: _fetchRentList(productName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: List.generate(snapshot.data!.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RentBox(rent: snapshot.data![index], isActive: true),
              );
            }),
          );
        } else if (snapshot.hasError) {
          return productName == "" ? Container() : Text("이상해요");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
