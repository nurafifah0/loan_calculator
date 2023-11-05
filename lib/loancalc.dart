import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const LoanCalcPage());

class LoanCalcPage extends StatefulWidget {
  const LoanCalcPage({super.key});

  @override
  State<LoanCalcPage> createState() => _LoanCalcPageState();
}

class _LoanCalcPageState extends State<LoanCalcPage> {
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController loanTermController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();

  int backInYear = 0;
  double loanAmount = 0.0,
      loanTerm = 0.0,
      interestRate = 0.0,
      result = 0.0,
      totalPayment = 0.0,
      totalInterest = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Loan Calculator'),
            backgroundColor: const Color.fromARGB(197, 67, 176, 190)),
        //at body : Center, wrap the padding with widget, n change the widget to SingleChildScrollView so keyboard wont have straps yellow boarder on top
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset('assets/images/pic1.png', scale: 2),
                  const Text(
                    "Loan Calculator",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    // textAlign: TextAlign.center,
                    controller: loanAmountController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                        labelText: 'Loan Amount',
                        hintText: "Loan Amount",
                        labelStyle:
                            const TextStyle(color: Colors.teal, fontSize: 20),
                        prefixText: '\$: ',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: loanTermController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                        labelText: 'Loan Term',
                        labelStyle:
                            const TextStyle(color: Colors.teal, fontSize: 20),
                        hintText: "    Loan Term",
                        suffixText: 'Year(s)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: TextField(
                          controller: interestRateController,
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                              labelText: 'Interest Rate',
                              labelStyle: const TextStyle(
                                  color: Colors.teal, fontSize: 20),
                              hintText: "Interest Rate",
                              suffixText: '% ',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const ColoredBox(color: Color.fromRGBO(255, 241, 118, 1)),
                      const SizedBox(height: 0, width: 50),
                      ElevatedButton(
                        onPressed: _calLoan,
                        style: ElevatedButton.styleFrom(
                            //shadowColor: Color.fromARGB(57, 178, 85, 62),
                            backgroundColor:
                                const Color.fromARGB(232, 21, 88, 65)),
                        child: const Text("Calculate Loan"),
                      ),
                      const SizedBox(height: 0, width: 20),
                      ElevatedButton(
                          onPressed: _clear,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(232, 21, 88, 65)),
                          child: const Text("Clear"))
                    ],
                  ),
                  Text(
                    "Monthly Payment : :\$ ${result.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 20,
                    //width: 400,
                  ),
                  //child:
                  Card(
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.grey[400],
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                          width: 20,
                        ),
                        Text(
                          "You will need to pay \$ ${result.toStringAsFixed(2)} every month for $backInYear years to payoff the debt.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Text(
                              "Total of  ${loanTerm.toInt()} Payments : \$ ${totalPayment.toStringAsFixed(2)}",
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(height: 30, width: 20),
                            Text(
                              "Total Interest : \$ ${totalInterest.toStringAsFixed(2)}",
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //),
                ],
              ),
            ),
          ),
        ));
  }

  void _calLoan() {
    /* Amortization
      A = Payemtn amount per period
      P = Initial Printical (loan amount)
      r = interest rate
      n = total number of payments or periods 

        double A = 0.0;
    int P = int.parse(_principalAmount.text); 
    double r = int.parse(_interestRate.text) / 12 / 100;
    int n = _tenureType == "Year(s)" ? int.parse(_tenure.text) * 12  : int.parse(_tenure.text);

    A = (P * r * pow((1+r), n) / ( pow((1+r),n) -1));
 */

    loanAmount = double.parse(loanAmountController.text);
    loanTerm = double.parse(loanTermController.text) * 12;
    interestRate = double.parse(interestRateController.text) / 12 / 100;
    backInYear = int.parse(loanTermController.text);

    result = (loanAmount *
        interestRate *
        pow((1 + interestRate), loanTerm) /
        (pow((1 + interestRate), loanTerm) - 1));

    totalPayment = result * loanTerm;
    totalInterest = totalPayment - loanAmount;

    totalPayment.toStringAsFixed(2);
    totalInterest.toStringAsFixed(2);

    setState(() {});
  }

  void _clear() {
    loanAmountController.clear();
    loanTermController.clear();
    interestRateController.clear();
    result = 0.0;
    totalPayment = 0.0;
    backInYear = 0;
    totalInterest = 0;
    loanTerm = 0;
    setState(() {});
  }
}
