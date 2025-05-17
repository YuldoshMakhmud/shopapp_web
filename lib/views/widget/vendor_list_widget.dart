import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorListWidget extends StatelessWidget {
  const VendorListWidget({super.key});

  @override
  Widget build(BuildContext context) {
 final Stream<QuerySnapshot> buyersStrem = FirebaseFirestore.instance.collection('vendors').snapshots();


     Widget vendorData(Widget widget, int? flex) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      ),
    );
  }
    return StreamBuilder<QuerySnapshot>(
      stream: buyersStrem,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index) {
            final buyer = snapshot.data!.docs[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 vendorData(
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: buyer['profileImage'] == ""
                          ? Image.network(
                              "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png")
                          : Image.network(
                              buyer['profileImage'],
                              width: 50,
                              height: 50,
                            ),
                    ), 
                    1),
                  vendorData(
                    Text(
                      buyer['fullName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    3),
                 vendorData(
                    Text(
                      buyer['locality'] +
                          
                          buyer['city'] +
                          buyer['state'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    2),
                    vendorData(
                    Text(
                      buyer['email'],
                    ),
                    2),
                  vendorData(
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {},
                      child: Text(
                        'reject',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    1),
              ],
            );
          }),
        );
      },
    );
  }
}