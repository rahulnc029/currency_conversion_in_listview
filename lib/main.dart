import 'package:currency_conversion/product_price_conversion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  TextEditingController inrController = TextEditingController();

  double usdRate = 0.012;
  double jpyRate = 1.76;
  double eurRate = 0.011;
  double ausRate = 0.019;
  double sriRate = 3.89;

  double usdAmount = 0.0;
  double jpyAmount = 0.0;
  double eurAmount = 0.0;
  double ausAmount = 0.0;
  double sriAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const SizedBox(
                  width: 50,
                    child: Text("INR"),
                ),
                const SizedBox(
                  width: 20,
                  child: Text(
                      ":",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: TextField(
                    controller: inrController,
                    decoration: const InputDecoration(
                        labelText: 'INR Amount',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                        bottom: 5,
                        left: 8
                      )
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      calculateCurrencies();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                    child: Text('USD')
                ),
                const SizedBox(
                  width: 20,
                  child: Text(
                    ":",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(usdAmount.toStringAsFixed(3)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                    width: 50,
                    child: Text('JPY')
                ),
                const SizedBox(
                  width: 20,
                  child: Text(
                    ":",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(jpyAmount.toStringAsFixed(3)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                    width: 50,
                    child: Text('EUR')
                ),
                const SizedBox(
                  width: 20,
                  child: Text(
                    ":",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(eurAmount.toStringAsFixed(3)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                    width: 50,
                    child: Text('AUD')
                ),
                const SizedBox(
                  width: 20,
                  child: Text(
                    ":",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(ausAmount.toStringAsFixed(3)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                    width: 50,
                    child: Text('SRI')
                ),
                const SizedBox(
                  width: 20,
                  child: Text(
                    ":",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(sriAmount.toStringAsFixed(3)),
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(height: 10,),
             ProductPriceConversion(inrPrice: inrController,)
          ],
        ),
      ),
    );
  }

  void calculateCurrencies() {
    double inrAmount = double.tryParse(inrController.text) ?? 0.0;
    usdAmount = inrAmount * usdRate;
    jpyAmount = inrAmount * jpyRate;
    eurAmount = inrAmount * eurRate;
    ausAmount = inrAmount * ausRate;
    sriAmount = inrAmount * sriRate;
    setState(() {});
  }
}
