import 'package:flutter/material.dart';
import 'package:mddmerchant/Booking_reg/AddBooking/add_booking.dart';

class MyBoking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking', style: TextStyle(color: Colors.white, fontFamily: 'Fontmain')),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Change the color of the icon
          iconSize: 30.0, // Adjust the size of the icon
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: .84,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  InkWell(
                    onTap: () {
                      print('click completed event');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => PageOne()),
                      // );
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Spacer(),
                          Image.asset(
                            "assets/images/register/Compelte.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Spacer(),
                          Text(
                            "Completed Events",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Fontmain',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('click UpComing Event');
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Spacer(),
                          Image.asset(
                            "assets/images/register/Upcoming.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Spacer(),
                          Text(
                            "UpComing Events",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Fontmain',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 150, // Set custom width
        height: 40, // Set custom height
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBooking()),
            );
          },
          label: Text(
            'Add Bookings',
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Fontmain',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          icon: Icon(Icons.add, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: Color(0xffC4A68B),
        ),
      ),

    );
  }
}
