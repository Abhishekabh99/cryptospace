import 'package:cryptospace/screens/detail_screen.dart';
import 'package:cryptospace/utilities/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/crypto.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Crypto> _cryptos = [];
  bool _loading = false;

  Future<void> _fetchCrypto() async {
    //Make a call to the crypto api
    try {
      setState(() {
        _loading = true;
      });
      final response = await Dio().get("https://$baseUrl$cryptosPath");
      List<Crypto> cryptos = response.data['data']
          .map((json) => Crypto.fromJson(json))
          .toList()
          .cast<Crypto>();
      setState(() {
        _cryptos = cryptos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch cryptos'),
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCrypto();
  }

  Icon _getPrefixIcon(
    double percentChange, {
    Color? color,
  }) {
    return percentChange <= 0
        ? Icon(
            Icons.arrow_drop_down_rounded,
            size: 32,
            color: color ?? kRedColor,
          )
        : Icon(
            Icons.arrow_drop_up_rounded,
            size: 32,
            color: color ?? kGreenColor,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        // leading: SizedBox.shrink(),
        title: const Text(
          'Cryptospace',
          style: TextStyle(color: kGreenColor),
        ),
        elevation: 0,
        backgroundColor: kBlackColor,
        centerTitle: false,
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey[400],
            height: 0.1,
          ),
          preferredSize: Size.fromHeight(0.1),
        ),
      ),
      body: _loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: kGreenColor,
                ),
              ),
            )
          : ListView.builder(
              itemCount: _cryptos.length,
              itemBuilder: ((context, index) {
                final crypto = _cryptos[index];

                return InkWell(
                  onTap: (() {
                    Navigator.pushNamed(context, DetailScreen.id,
                        arguments: crypto);
                  }),
                  child: ListTile(
                    title: Text(
                      crypto.name,
                      style: TextStyle(
                        color: kGreenColor,
                      ),
                    ),
                    subtitle: Text(
                      crypto.symbol,
                      style: TextStyle(
                        color: kGreyColor,
                      ),
                    ),
                    leading: SizedBox(
                      width: 30.0,
                      child: Center(
                        child: Text(
                          crypto.rank.toString(),
                          style: TextStyle(
                            color: kGreyColor,
                          ),
                        ),
                      ),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${crypto.priceUsd.toStringAsFixed(2)} USD',
                          style: TextStyle(
                            color: kGreyColor,
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _getPrefixIcon(crypto.changePercent24hr),
                              Text(
                                crypto.changePercent24hr.toStringAsFixed(2),
                                style: TextStyle(
                                  color: crypto.changePercent24hr > 0
                                      ? kGreenColor
                                      : kRedColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
