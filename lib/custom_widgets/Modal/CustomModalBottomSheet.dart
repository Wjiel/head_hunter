import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Buttons/CustomIconButton.dart';

Future showCustomModalBottomSheet(context, {
      required String text,
      required List<Widget> Function(ScrollController scrollController) widgets,
      FutureOr<void> Function()? whenComplete,
    }) async  {
  var _response = await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context){
        return CustomModalBottomSheet(widgets: widgets, text: text);
    }
  ).whenComplete(() => whenComplete != null ? whenComplete() : null);
  return _response;
}



Future showCustomModalDataBottomSheet(context,
    {required String text,
      void Function()? onBack,
    required List<Widget> Function(ScrollController scrollController) widgets,
    FutureOr<void> Function()? whenComplete}) async  {
  var _response = await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context){
        return CustomModalDataBottomSheet(widgets: widgets, text: text, onBack: onBack ?? null);
      }
  ).whenComplete(() => whenComplete != null ? whenComplete() : null);
  return _response;
}

Future showCustomModalFilledDataBottomSheet(context,
    {required String text,
      void Function()? onBack,
      required List<Widget> widgets,
      FutureOr<void> Function()? whenComplete}) async  {
  var _response = await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context){
        return CustomModalFilledDataBottomSheet(widgets: widgets, text: text,onBack: onBack ?? null,);
      }
  ).whenComplete(() => whenComplete != null ? whenComplete() : null);
  return _response;
}

class CustomModalBottomSheet extends StatelessWidget {
  final String text;
  final List<Widget> Function(ScrollController scrollController) widgets;
  const CustomModalBottomSheet({super.key, required this.widgets, required this.text});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        key: UniqueKey(),
        initialChildSize: 0.5,
        maxChildSize: 1,
        minChildSize: .4,
        builder: (context, controller) {
        return Ink(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color(0xFFF4F6FF),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            controller: controller,
            children: [

              Row(
                children: [

                  Expanded(
                    child: SizedBox(),
                  ),

                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(text,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF363636)
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Transform.scale(
                      scale: 1.2,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: CustomIconButton(
                            callback: (){
                              Navigator.of(context).pop();
                            },
                            height: 20,
                            width: 20,
                            padding: EdgeInsets.all(4),
                            iconSVG: "assets/icons/close.svg",
                            fit: BoxFit.contain
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              SizedBox(height: 28,),

              Material(
                color: Colors.transparent,
                child: Column(
                  children: widgets(controller),
                ),
              ),

              SizedBox(height: 20,),

            ],
          ),
        );
      }
    );
  }
}

class CustomModalDataBottomSheet extends StatelessWidget {
  final String text;
  final List<Widget> Function(ScrollController scrollController) widgets;
  final void Function()? onBack;
  const CustomModalDataBottomSheet({super.key, required this.widgets, required this.text, required this.onBack});


  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      key: UniqueKey(),
      initialChildSize: 0.5,
      maxChildSize: 1,
      minChildSize: .4,
      builder: (context, controller) {
        return Ink(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color(0xFFF4F6FF),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            controller: controller,
            children: [

              Row(
                children: [

                  Expanded(
                    child: GestureDetector(
                      onTap: onBack != null ? onBack : null,
                      child: Row(
                        children: [

                          onBack != null
                              ? Row(
                            children: [
                              Icon(CupertinoIcons.back, color: Color(0xFF707073),),
                              SizedBox(width: 10,)
                            ],
                          )
                              : SizedBox(),

                          Expanded(
                            child: Text(text,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF707073)
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),



                  Transform.scale(
                    scale: 1.2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: CustomIconButton(
                          callback: (){
                            Navigator.of(context).pop();
                          },
                          height: 20,
                          width: 20,
                          padding: EdgeInsets.all(4),
                          iconSVG: "assets/icons/close.svg",
                          fit: BoxFit.contain
                      ),
                    ),
                  ),

                ],
              ),

              SizedBox(height: 28,),

              Material(
                color: Colors.transparent,
                child: Column(
                  children: widgets(controller),
                ),
              ),

              SizedBox(height: 20,),

            ],
          ),
        );
      },
    );
  }
}

class CustomModalFilledDataBottomSheet extends StatelessWidget {
  final String text;
  final List<Widget> widgets;
  final void Function()? onBack;
  const CustomModalFilledDataBottomSheet({super.key, required this.widgets, required this.text, this.onBack});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      key: UniqueKey(),
      initialChildSize: 0.5,
      maxChildSize: 1,
      minChildSize: .4,
      builder: (context, controller) {
        return Ink(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            controller: controller,
            children: [

              Row(
                children: [

                  onBack != null ? Expanded(
                    child: InkWell(
                      onTap: onBack,
                      child: Row(
                        children: [
                      
                          Icon(CupertinoIcons.back, color: Color(0xFF707073),),
                      
                          SizedBox(width: 10,),
                      
                          Expanded(
                            child: Text(text,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF707073)
                              ),
                            ),
                          ),
                      
                        ],
                      ),
                    ),
                  ) : Expanded(
                    child: Row(
                      children: [
                    
                        Expanded(
                          child: Text(text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF707073)
                            ),
                          ),
                        ),
                    
                      ],
                    ),
                  ),

                  Transform.scale(
                    scale: 1.2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: CustomIconButton(
                          callback: (){
                            Navigator.of(context).pop();
                          },
                          height: 20,
                          width: 20,
                          padding: EdgeInsets.all(4),
                          iconSVG: "assets/icons/close.svg",
                          fit: BoxFit.contain
                      ),
                    ),
                  ),

                ],
              ),

              SizedBox(height: 28,),

              Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets,
                ),
              ),

              SizedBox(height: 28,),

            ],
          ),
        );
      },
    );
  }
}

