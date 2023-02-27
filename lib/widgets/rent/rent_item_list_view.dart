import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/widgets/rent/rent_button.dart';

import '../../models/rent.dart';
import 'button_page.dart';
import 'rent_box.dart';

Future<List<Rent>> _fetchRentList() async {
  final url = Uri.parse('http://p-cube-plus.com/rent/list');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(json.decode(response.body).runtimeType);
    return (json.decode(response.body) as List)
        .map((data) => Rent.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load post');
  }
}

class RentItenListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonPage(
      names: ["전체", "대여 가능", "대여 중"],
      contents: [RentItemView(), RentItemView(), RentItemView()],
    );
  }
}

class RentItemView extends StatefulWidget {
  @override
  State<RentItemView> createState() => RentItemViewState();
}

class RentItemViewState extends State<RentItemView> {
  late Future<List<Rent>> rentAPI;

  @override
  void initState() {
    super.initState();
    rentAPI = _fetchRentList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Rent>>(
      future: rentAPI,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RentBox(rent: snapshot.data![index]);
                  }),
              //Padding(
              //  padding: const EdgeInsets.only(top: 8, bottom: 24.0),
              //  child: RentButton(text: "스캔하기", isActive: true, isRent: true),
              //)
            ],
          );
        } else if (snapshot.hasError) {
          return Text("정보를 불러올 수 없습니다.");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
