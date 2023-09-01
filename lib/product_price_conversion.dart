import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ProductPriceConversion extends StatefulWidget {
  TextEditingController inrPrice;
   ProductPriceConversion({
    required this.inrPrice,
    super.key,
  });

  @override
  State<ProductPriceConversion> createState() => _ProductPriceConversionState();
}

class _ProductPriceConversionState extends State<ProductPriceConversion> {

  TextEditingController qtyController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

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

  String selectedCountry = "--Select--";
  var countries = [
    "USD",
    "JPY",
    "EURO",
    "AUS",
    "SRI"
  ];

  @override
  void initState() {
    productPriceController = widget.inrPrice;
    print('-------');
    print(productPriceController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product Price"),
            const SizedBox(height: 6,),
            SizedBox(
              width: 100,
              height: 40,
              child: TextField(
                controller: productPriceController,
                decoration: const InputDecoration(
                    labelText: 'Product Price',
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
              ),
            ),
          ],
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Quantity"),
            const SizedBox(height: 6,),
            SizedBox(
              width: 60,
              height: 40,
              child: TextField(
                controller: qtyController,
                decoration: const InputDecoration(
                    labelText: 'Qty',
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
              ),
            ),
          ],
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Country"),
            const SizedBox(height: 6,),
            SizedBox(
              width: 100,
              height: 40,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text(selectedCountry),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: countries.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                          child: Text(value)
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value!;
                        calculateCurrencies();
                      });
                    },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10,),
        Text("${getSelectedCurrencyAmount()}")
      ],
    );
  }
  Object getSelectedCurrencyAmount(){
    switch(selectedCountry){
      case "USD": return "\$$usdAmount";
      case "JPY": return "¥$jpyAmount";
      case "EURO": return "€$eurAmount";
      case "AUS": return "\$$ausAmount";
      case "SRI": return "රු $sriAmount";
      default: return 0.0;
    }
  }
  void calculateCurrencies(){
    double productPrice = double.tryParse(productPriceController.text) ?? 0.0;
    double quantity = double.tryParse(qtyController.text) ?? 1.0;

    switch (selectedCountry){
      case "USD":
        usdAmount = (productPrice*quantity)*usdRate;
        break;
      case "JPY":
        jpyAmount = (productPrice*quantity)*jpyRate;
        break;
      case "EURO":
        eurAmount = (productPrice*quantity)*eurRate;
        break;
      case "AUS":
        ausAmount = (productPrice*quantity)*ausRate;
        break;
      case "SRI":
        sriAmount = (productPrice*quantity)*sriRate;
        break;
      default: {
        print("Invalid Country");
      }
      break;
    }
  }
}
