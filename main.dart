import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:win32/win32.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  TextEditingController Massge = TextEditingController();
  TextEditingController Numbers = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

          // backgroundColor: Colors.black,
          body: Column(
        children: [
          TextField(
            maxLines: 5,
            controller: Massge,
          ),
          Divider(
            height: 20,
          ),
          TextField(
            maxLines: 20,
            controller: Numbers,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    print(
                        'Switching to WhatsUp and going to sleep for a second.');

                    const VK_A = 0x0D;
                    List Number = Numbers.text.toString().split("\n");

                    print(Numbers.text.toString().split("\n"));
                    Number.forEach((element) {
                      ShellExecute(
                          0,
                          TEXT('open'),
                          TEXT(
                              'whatsapp://send?phone=964$element&text=${Massge.text}'),
                          nullptr,
                          nullptr,
                          SW_SHOW);

                      Sleep(2000);
                      print('Sending Enter ');
                      final kbd = calloc<INPUT>();
                      kbd.ref.type = INPUT_KEYBOARD;
                      kbd.ref.ki.wVk = VK_A;
                      var result = SendInput(1, kbd, sizeOf<INPUT>());
                      if (result != TRUE) print('Error: ${GetLastError()}');
                      free(kbd);
                    });
                  },
                  icon: Icon(Icons.send)),
            ],
          )
        ],
      )),
    );
  }
}
