import 'package:flutter/material.dart';
import 'package:platform_detail/platform_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(
          title:
              'Flutter Demo Home Page ${PlatformDetail.currentGroupPlatform.name}'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
                future: PlatformDetail.deviceInfoDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error getting device info: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Text('Device Info: ${snapshot.data}');
                  } else {
                    return Text('No data available');
                  }
                }),
            FutureBuilder(
                future: PlatformDetail.getPrivateIp,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error getting private IP: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Text('Private IP: Unavailable');
                    }
                    return Text('Private IP: ${snapshot.data}');
                  } else {
                    return Text('No private IP available');
                  }
                }),
            FutureBuilder(
                future: PlatformDetail.getPublicIp,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error getting public IP: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Text('Public IP: ${snapshot.data}');
                  } else {
                    return Text('No public IP available');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
