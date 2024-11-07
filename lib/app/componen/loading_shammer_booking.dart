import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Loadingshammer extends StatelessWidget {
  const Loadingshammer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
    Shimmer(
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
                    children: [
                      const Text('Jenis Service'),
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
                      Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Kode Booking :'),
                      Shimmer(
                        child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Merek :'),
                      Shimmer(
                        child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                        Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                      const Text('Type :'),
                      Shimmer(
                        child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                        Text('', style: const TextStyle(fontWeight: FontWeight.bold),),),),
                      const Text('NoPol :'),
                      Shimmer(
                        child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                        Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Jam Booking :'),
                      Shimmer(
                        child:
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                        Text(
                          "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ),
                      SizedBox(height: 10,),
                      Shimmer(
                        child:
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Status :'),
                          ],
                        ),
                      ),
                      ),
                      const SizedBox(height: 5,),
                      Shimmer(
                        child:
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                        Shimmer(
                        child:
                            Container(
                              width: 120,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                              Text(
                                "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ),
                          ],
                        ),
                      ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Pemilik :'),
                        Shimmer(
                            child:
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                          Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                      ]),
                ],),
            ],
          ),
        ),),
        SizedBox(height: 5,),
        Shimmer(
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
                      children: [
                        const Text('Jenis Service'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),child:
                          Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Kode Booking :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Merek :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                        const Text('Type :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text('', style: const TextStyle(fontWeight: FontWeight.bold),),),),
                        const Text('NoPol :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Jam Booking :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text(
                              "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Status :'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Shimmer(
                                  child:
                                  Container(
                                    width: 120,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                    Text(
                                      "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Pemilik :'),
                          Shimmer(
                            child:
                            Container(
                              width: 120,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                              Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                        ]),
                  ],),
              ],
            ),
          ),),
        SizedBox(height: 5,),
        Shimmer(
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
                      children: [
                        const Text('Jenis Service'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),child:
                          Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Kode Booking :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Merek :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                        const Text('Type :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text('', style: const TextStyle(fontWeight: FontWeight.bold),),),),
                        const Text('NoPol :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Jam Booking :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text(
                              "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Status :'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Shimmer(
                                  child:
                                  Container(
                                    width: 120,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                    Text(
                                      "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Pemilik :'),
                          Shimmer(
                            child:
                            Container(
                              width: 120,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                              Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                        ]),
                  ],),
              ],
            ),
          ),),
        SizedBox(height: 5,),
        Shimmer(
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
                      children: [
                        const Text('Jenis Service'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),child:
                          Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Kode Booking :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Merek :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                        const Text('Type :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text('', style: const TextStyle(fontWeight: FontWeight.bold),),),),
                        const Text('NoPol :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Jam Booking :'),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Text(
                              "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Status :'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Shimmer(
                          child:
                          Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Shimmer(
                                  child:
                                  Container(
                                    width: 120,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                    Text(
                                      "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Pemilik :'),
                          Shimmer(
                            child:
                            Container(
                              width: 120,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                              Text("", style: const TextStyle(fontWeight: FontWeight.bold),),),),
                        ]),
                  ],),
              ],
            ),
          ),),
      ],
    );
  }
}
