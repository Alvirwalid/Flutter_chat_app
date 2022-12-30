import 'package:calling_app/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

final localUserId = math.Random().nextInt(1000).toString();

class VideoCalling extends StatelessWidget {
  const VideoCalling({super.key});

  @override
  Widget build(BuildContext context) {
    final callingId = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: callingId,
                decoration: InputDecoration(
                    hintText: 'User ID', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return LiveCalling(
                              callID: callingId.text,
                            );
                          },
                        ));
                      },
                      child: const Text('Join')))
            ],
          ),
        ),
      ),
    );
  }
}

class LiveCalling extends StatelessWidget {
  LiveCalling({super.key, required this.callID});

  String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: Utils.appId,
      appSign: Utils.appSign,
      callID: callID,
      userID: localUserId,
      userName: 'user${Utils.appId}',
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) {
          Navigator.pop(context);
        },
    );
  }
}
