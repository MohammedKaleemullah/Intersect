import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../layout/nav_layout.dart';
import '../../screens/order_history_screen/api/order_history_api.dart';
import '../../screens/order_history_screen/widgets/order_history_card.dart';

class ThunderDealsPage extends StatefulWidget {
  const ThunderDealsPage({Key? key}) : super(key: key);

  @override
  State<ThunderDealsPage> createState() => _ThunderDealsPage();
}

class _ThunderDealsPage extends State<ThunderDealsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "ThunderDeals",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFC5CAE9),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const NavigationLayout(isConsumer: true),
              ),
            );
          },
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: const Color(0xFFC5CAE9), // Background color
        child: ThunderDealsData == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: ThunderDealsData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: size.width * 0.5,
                height: size.height * 0.2, // Adjust the height as needed
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFC5CAE9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.2, // Adjust the height as needed
                            width: size.width * 0.4, // Adjust the width as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://thunderr-deals.myshopify.com/cdn/shop/files/Thunder_4.jpg?v=1646483404",
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ThunderDealsData?[index]['Name'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20, // Adjust the font size as needed
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    ThunderDealsData![index]['Overview'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Rs. ${ThunderDealsData?[index]['Pricing'].toString()}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    getTrendingDataFromVahanDB("https://platformwaste-api.onrender.com/api/PlatformWaste");
  }

  var ThunderDealsData;
  DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

  void getTrendingDataFromVahanDB(String? url) async {
    final response = await http.get(Uri.parse(url!));

    setState(() {
      ThunderDealsData = jsonDecode(response.body)['response'];
    });
  }
}
