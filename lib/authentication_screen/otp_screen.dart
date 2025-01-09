import "package:flutter/material.dart";
import "package:flutter/services.dart";

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return OtpScreenState();
  }
}

class OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 92,left: 20,right: 20),
            child: Column(
              children: [
                 Center(
                  child: Text(
                    "OTP Verification",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: "Sf Ui Display SemiBold"),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                    width: 300,
                    height: 40,
                    child: Text(
                      "Please Check your Email to See your Verification Code",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "gill sans", fontSize: 16,color: Color(0xFF7D848D)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("OTP Code",
                    style: TextStyle(fontSize: 20,fontFamily: "Sf Ui Display SemiBold"),),
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value){
                          if (value.length ==1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        onSaved: (pin1){},
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          fillColor: Colors.blueGrey.shade50,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value){
                          if (value.length ==1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        onSaved: (pin2){},
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          fillColor: Colors.blueGrey.shade50,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value){
                          if (value.length ==1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        onSaved: (pin3){},
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          fillColor: Colors.blueGrey.shade50,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onChanged: (value){
                          if (value.length ==1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        onSaved: (pin4){},
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          fillColor: Colors.blueGrey.shade50,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 335,
                  height: 56,
                  child: ElevatedButton(onPressed: (){

                  },style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                      child: const Text("Verify",style: TextStyle(fontSize: 16,fontFamily: "Sf Ui Display SemiBold",color: Colors.white),)),
                ),
                const SizedBox(
                  height: 16,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Resend code to",style: TextStyle(fontSize: 16,fontFamily: "gill sans",color: Theme.of(context).colorScheme.secondary),),
                    const Text("01:26",style: TextStyle(fontSize: 16,fontFamily: "gill sans",color: Color(0xFF7D848D)),)
                  ],
                )

              ],
            ),
          ),
        ));
  }
}
