import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class Ethernet extends StatefulWidget {
  const Ethernet({super.key});

  @override
  State<Ethernet> createState() => _EthernetState();
}

class _EthernetState extends State<Ethernet> {
  String rpcUrl = 'https://rpc.ankr.com/eth';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: Text('Web3Auth Flutter',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600)),
              backgroundColor: Colors.black),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final res = await Web3AuthFlutter.login(
                          LoginParams(loginProvider: Provider.google));

                      print('UserInfo, #{res?.userInfo?.toString()}');
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString(
                          'privateKey', res.privKey.toString());
                    },
                    child: Text('Login')),
              ],
            ),
          )),
    );
  }

  initPlatformState() async {
    Uri redirectUrl;
    if (Platform.isAndroid) {
      redirectUrl = Uri.parse('{SCHEME}://{HOST}/auth');
      // w3a://com.example.w3aflutter/auth
    } else if (Platform.isIOS) {
      redirectUrl = Uri.parse('{bundleId}://{openlogin}');
      // w3a://com.example.w3aflutter/auth
    } else {
      throw Exception('Unsupported platform');
    }

    await Web3AuthFlutter.init(
      Web3AuthOptions(
          clientId: 'WEB3AUTH_CLIENT_ID_FROM_DASHBOARD',
          network: Network.mainnet,
          redirectUrl: redirectUrl),
    );
  }
}
