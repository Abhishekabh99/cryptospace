import 'package:cryptospace/models/crypto.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class DetailScreen extends StatefulWidget {
  static const String id = "detail_screen";
  final Crypto crypto;
  const DetailScreen({
    Key? key,
    required this.crypto,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kGreenColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kBlackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            _getPrefixIcon(widget.crypto.changePercent24hr),
            Text(
              widget.crypto.name.toString(),
              style: TextStyle(color: kBlackColor),
            ),
          ],
        ),
      ),
      body: SizedBox(
        child: Column(
          children: [
            _listTile('RANK', widget.crypto.rank.toString()),
            SizedBox(height: 24),
            _listTile('NAME', widget.crypto.name.toString()),
            SizedBox(height: 24),
            _listTile('PRICE', widget.crypto.priceUsd.toString()),
            SizedBox(height: 24),
            _listTile('PERCENT CHNAGE (24hr)',
                widget.crypto.changePercent24hr.toString()),
            SizedBox(height: 24),
            _listTile('MARKET CAP', widget.crypto.marketCapUsd.toString()),
          ],
        ),
      ),
    );
  }

  Icon _getPrefixIcon(
    double percentChange, {
    Color? color,
  }) {
    return percentChange <= 0
        ? Icon(
            Icons.arrow_drop_down_rounded,
            size: 32,
            color: color ?? Colors.purple,
          )
        : Icon(
            Icons.arrow_drop_up_rounded,
            size: 32,
            color: color ?? kBlackColor,
          );
  }

  Widget _listTile(title, subtitle) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: kGreyColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: kGreenColor,
          fontSize: 24,
        ),
      ),
    );
  }
}
