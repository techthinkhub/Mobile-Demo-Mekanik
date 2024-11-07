import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoadingshammerHistory extends StatelessWidget {
  const LoadingshammerHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(children: [
        Shimmer(
        direction: ShimmerDirection(),
    child:
      Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Tipe Service'),
                  Shimmer(
                    direction: ShimmerDirection(),
                    child:
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),child:
                    Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Pelanggan :'),
                          Shimmer(
                            direction: ShimmerDirection(),
                            child:
                            Container(
                              width: 120,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),child:
                            Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                        ],),
                      SizedBox(width: 10,),
                    ],),
                  SizedBox(height: 10,),
                  Text('PIC Estimasi :'),
                  Shimmer(
                    direction: ShimmerDirection(),
                    child:
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),child:
                    Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                ],),
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Status :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                    SizedBox(height: 10,),
                    Text('Kode Booking :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ]),
            ],),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: [
                  Text('Tgl estimasi :'),
                  Shimmer(
                    direction: ShimmerDirection(),
                    child:
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),child:
                    Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                ],),
                Column(children: [
                  Text('Kode estimasi :'),
                  Shimmer(
                    direction: ShimmerDirection(),
                    child:
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),child:
                    Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                ],),
                Shimmer(
                  direction: ShimmerDirection(),
                  child:
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),child: Center(child:
                  Text('Detail',style: TextStyle(fontWeight: FontWeight.bold),),),),),
              ],),),
          SizedBox(height: 10,),
        ],
      ),
      ),),
      SizedBox(height: 5,),
    Shimmer(
    direction: ShimmerDirection(),
    child:
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Tipe Service'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Pelanggan :'),
                            Shimmer(
                              direction: ShimmerDirection(),
                              child:
                              Container(
                                width: 120,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),child:
                              Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                          ],),
                        SizedBox(width: 10,),
                      ],),
                    SizedBox(height: 10,),
                    Text('PIC Estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Status :'),
                      Shimmer(
                        direction: ShimmerDirection(),
                        child:
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),child:
                        Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                      SizedBox(height: 10,),
                      Text('Kode Booking :'),
                      Shimmer(
                        direction: ShimmerDirection(),
                        child:
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),child:
                        Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                    ]),
              ],),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(children: [
                    Text('Tgl estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                  Column(children: [
                    Text('Kode estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                  Shimmer(
                    direction: ShimmerDirection(),
                    child:
                    Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),child: Center(child:
                    Text('Detail',style: TextStyle(fontWeight: FontWeight.bold),),),),),
                ],),),
            SizedBox(height: 10,),
          ],
        ),
      ),),
      SizedBox(height: 5,),
    Shimmer(
    direction: ShimmerDirection(),
    child:
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Tipe Service'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Pelanggan :'),
                            Shimmer(
                              direction: ShimmerDirection(),
                              child:
                              Container(
                                width: 120,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),child:
                              Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                          ],),
                        SizedBox(width: 10,),
                      ],),
                    SizedBox(height: 10,),
                    Text('PIC Estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Status :'),
                      Shimmer(
                        direction: ShimmerDirection(),
                        child:
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),child:
                        Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                      SizedBox(height: 10,),
                      Text('Kode Booking :'),
                      Shimmer(
                        direction: ShimmerDirection(),
                        child:
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),child:
                        Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                    ]),
              ],),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(children: [
                    Text('Tgl estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                  Column(children: [
                    Text('Kode estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                  Shimmer(
                    direction: ShimmerDirection(),
                    child:
                    Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),child: Center(child:
                    Text('Detail',style: TextStyle(fontWeight: FontWeight.bold),),),),),
                ],),),
            SizedBox(height: 10,),
          ],
        ),
      ),),
      SizedBox(height: 5,),
    Shimmer(
    direction: ShimmerDirection(),
    child:
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Tipe Service'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Pelanggan :'),
                            Shimmer(
                              direction: ShimmerDirection(),
                              child:
                              Container(
                                width: 120,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),child:
                              Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                          ],),
                        SizedBox(width: 10,),
                      ],),
                    SizedBox(height: 10,),
                    Text('PIC Estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Status :'),
                      Shimmer(
                        direction: ShimmerDirection(),
                        child:
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),child:
                        Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                      SizedBox(height: 10,),
                      Text('Kode Booking :'),
                      Shimmer(
                        direction: ShimmerDirection(),
                        child:
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),child:
                        Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                    ]),
              ],),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(children: [
                    Text('Tgl estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                  Column(children: [
                    Text('Kode estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                  Shimmer(
                    direction: ShimmerDirection(),
                    child:
                    Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),child: Center(child:
                    Text('Detail',style: TextStyle(fontWeight: FontWeight.bold),),),),),
                ],),),
            SizedBox(height: 10,),
          ],
        ),
      ),),
      SizedBox(height: 5,),
    Shimmer(
    direction: ShimmerDirection(),
    child:
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Tipe Service'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Pelanggan :'),
                            Shimmer(
                              direction: ShimmerDirection(),
                              child:
                              Container(
                                width: 120,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),child:
                              Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                          ],),
                        SizedBox(width: 10,),
                      ],),
                    SizedBox(height: 10,),
                    Text('PIC Estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Status :'),
                      Shimmer(
                        direction: ShimmerDirection(),
                        child:
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),child:
                        Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                      SizedBox(height: 10,),
                      Text('Kode Booking :'),
                      Shimmer(
                        direction: ShimmerDirection(),
                        child:
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),child:
                        Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                    ]),
              ],),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(children: [
                    Text('Tgl estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                  Column(children: [
                    Text('Kode estimasi :'),
                    Shimmer(
                      direction: ShimmerDirection(),
                      child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),child:
                      Text('',style: TextStyle(fontWeight: FontWeight.bold),),),),
                  ],),
                  Shimmer(
                    direction: ShimmerDirection(),
                    child:
                    Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),child: Center(child:
                    Text('Detail',style: TextStyle(fontWeight: FontWeight.bold),),),),),
                ],),),
            SizedBox(height: 10,),
          ],
        ),
      ),),
   ]);
  }
}
