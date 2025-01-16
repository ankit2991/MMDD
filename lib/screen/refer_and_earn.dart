import 'package:flutter/material.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/constrans.dart';
import 'package:flutter/services.dart';

class referAndEarn extends StatelessWidget {
  const referAndEarn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: mainColor,
        title: Text(
          "Refer and Earn",
          style: TextStyle(fontFamily: "Fontmain"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // spacing: 5,
          children: [
            Text(
              "Refer and Earn Program: Terms and Conditions ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "Welcome to [MMDD App]'s Refer and Earn Program! By participating in this program, you agree to the following terms and conditions:",
                style: TextStyle(fontSize: 15)),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Refer + Earn',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ])
              ],
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('1',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Bronze',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('50',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('2',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Silver',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('75',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('3',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Gold',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('100',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('4',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Platinum',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('125',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "The Refer and Earn Program is open to all registered users of the MMDD Merchant App who are in good standing.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            Text(
                "To participate, share your unique referral link/code with friends and family.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 15,
            ),
            Text("A referral is considered successful when:",
                style: TextStyle(fontSize: 15)),
            Text(
                "•	The referred person downloads and installs the MMDD Merchant App.",
                style: TextStyle(fontSize: 15)),
            Text(
                "•	The referred person registers an account using the referrer’s unique referral link/code",
                style: TextStyle(fontSize: 15)),
            Text(
                "•	The referred person meets specific conditions such as makes a purchase, completes profile setup, etc.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 15,
            ),
            Text(
                "Referrers will receive specific reward, such as points for every successful referral.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            Text(
                "Rewards will be credited to the referrer’s account within [24 Hrs] of a successful referral.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            Text(
                "Rewards are non-transferable and cannot be exchanged for cash or other benefits unless stated otherwise.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            Text(
                "Any misuse of the program, including but not limited to creating fake accounts, spamming, or providing false information, will result in disqualification from the program and forfeiture of all earned rewards.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            Text(
                "MMDD Merchant App reserves the right to take legal action against fraudulent activities.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            Text(
                "MMDD Merchant App reserves the right to modify or terminate the Refer and Earn Program at any time without prior notice.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            Text(
                "MMDD Merchant App is not responsible for any issues arising due to technical failures, delayed rewards, or unauthorized access to accounts.",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            Text(
                "MMDD Merchant App is not responsible for any issues arising due to technical failures, delayed rewards, or unauthorized access to accounts.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    
      floatingActionButton: Api.User_info["Table"][0]["SelfReferCode"] != null
          ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                            text: Api.User_info["Table"][0]["SelfReferCode"]))
                        .then((_) {
                      Api.snack_bar(context: context, message: "copied Refer Code");
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color:  mainColor,borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.copy,color: Colors.white,),
                        Text("${Api.User_info["Table"][0]["SelfReferCode"]}",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  )),
            ],
          )
          : SizedBox(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
// onPressed: () {
//           Clipboard.setData(ClipboardData(text: Api.User_info["Table"][0]["SelfReferCode"])).then((_) {
//            Api.snack_bar(context: context, message: "Refer Code copied");
//           });
//         },
        // child: Text(),