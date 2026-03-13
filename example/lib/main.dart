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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<EnvironmentDetails>(
              future: PlatformDetail.environmentDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(
                      'Error getting environment details: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final details = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Environment Details:'),
                      Text('PlatformType: ${details.platformType.name}'),
                      Text('Platform: ${details.platform}'),
                      Text('Device Model: ${details.deviceModel}'),
                      Text('Locale: ${details.locale}'),
                    ],
                  );
                } else {
                  return const Text('No environment details available');
                }
              },
            ),
            const SizedBox(height: 16),
            FutureBuilder<String>(
              future: PlatformDetail.deviceInfoDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error getting device info: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text('Device Info: ${snapshot.data}');
                } else {
                  return const Text('No data available');
                }
              },
            ),
            const SizedBox(height: 16),
            FutureBuilder<VersionDetails>(
              future: PlatformDetail.versionDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error getting app details: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final details = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('App Details:'),
                      Text('App Name: ${details.appName}'),
                      Text('Package Name: ${details.packageName}'),
                      Text('Version: ${details.version}'),
                      Text('Build Number: ${details.buildNumber}'),
                    ],
                  );
                } else {
                  return const Text('No app details available');
                }
              },
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<String>>(
              future: PlatformDetail.getPrivateIp,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error getting private IP: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Text('Private IP: Unavailable');
                  }
                  return Text('Private IP: ${snapshot.data}');
                } else {
                  return const Text('No private IP available');
                }
              },
            ),
            const SizedBox(height: 16),
            FutureBuilder<String?>(
              future: PlatformDetail.getPublicIp,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error getting public IP: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text('Public IP: ${snapshot.data}');
                } else {
                  return const Text('No public IP available');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
