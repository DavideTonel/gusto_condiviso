import 'package:flutter/material.dart';

class RecipePreview extends StatelessWidget{
  const RecipePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width/6,
      height: size.width/6,
      child: Column(
        children: [
          Container(
            width: size.width/6,
            height: size.width/10,
            color: Colors.amber,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              width: size.width/6,
              color: Colors.blue,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "Patate ripiene prosciutto e formaggio, con aggiunta di provola in forno",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star),
                            Text("4.5"),
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Row(
                          children: [
                            Icon(Icons.comment),
                            Text("12"),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}