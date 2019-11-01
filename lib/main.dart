import 'package:flutter/material.dart';
import 'MatchCard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _getBackgroundColor(),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.navigate_before,
              color: _getTextColor(),
            ),
            Text(
              "Explore",
              style: TextStyle(color: _getTextColor()),
            ),
            Icon(Icons.search, color: _getTextColor())
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: CardListStateWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.not_interested, color: Colors.redAccent),
                      onPressed: () {}),
                ),
                Container(
                  width: 60,
                  height: 60,
                  child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.done, color: Colors.black87),
                      onPressed: () {}),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.bookmark, color: Colors.green),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CardListStateWidget extends StatefulWidget {
  @override
  _CardListStateWidgetState createState() => _CardListStateWidgetState();
}

class _CardListStateWidgetState extends State<CardListStateWidget> {
  List<Widget> cardList = List();
  List<MatchCard> cards = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cards.add(MatchCard("Ford", "Currently available",
        "http://pngimg.com/uploads/mustang/mustang_PNG51.png", 30, 4, 10));
    cards.add(MatchCard(
        "Volvo",
        "Currently available",
        "http://pngpix.com/wp-content/uploads/2016/06/PNGPIX-COM-Black-Volvo-XC90-Excellence-Car-PNG-Image.png",
        30,
        4,
        10));
    cards.add(MatchCard(
        "Nissan GTR",
        "Currently available",
        "http://www.pngmart.com/files/4/Nissan-GT-R-PNG-Picture.png",
        30,
        2,
        10));
  }
    void  _removeCard(index){
    setState(() {
      cards.removeAt(index);
      cardList.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
      cardList.clear();
    cards.asMap().forEach((index,cardw) {
      cardList.add(ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 100,
            minHeight: 100,
        maxHeight: 500),
        child: Container(
          child:Draggable(
            onDragEnd:(details){
              if(details.offset.dx >150 || details.offset.dx <-150 ){
                _removeCard(index);
              }
            },
            childWhenDragging: Container(),
              child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color:Color.fromARGB(255, 231, 234, 238),
                  spreadRadius: 2,
                  blurRadius: 5)
              ]),
            child: GestureDetector(
              onTap:(){
                _showCarDetailsSheet(context,cardw);
              },
              child: ClipRect(
                child: Container(
                  width: MediaQuery.of(context).size.width-40,
                   color: Colors.white,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(cardw.name,style: TextStyle(
                          color: _getTextColor(),
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),),
                          Text(cardw.available,style: TextStyle(
                             fontSize: 20,
                              fontWeight: FontWeight.w600,
                            color:Color.fromARGB(255, 160, 207, 34)
                          )),
                      ],
                    ),
                      Image.network(cardw.imgSrc,fit: BoxFit.contain,),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("\$${cardw.price}",style: TextStyle(
                                  fontSize: 30,
                       color:_getTextColor(),fontWeight:FontWeight.w800),),
                                Text("/day",style:TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: _getTextColor()
                                ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.people),
                                Text("${cardw.people}",style: TextStyle(
                                    fontSize: 20,
                                    color:_getTextColor(),fontWeight:FontWeight.w800),)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
              feedback: Container(
            width:MediaQuery.of(context).size.width-40,
            height:500,
            child:ClipRect(
              child: Container(
                width: MediaQuery.of(context).size.width-40,
                color: Colors.white,
                child:Image.network(
                  cardw.imgSrc,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ))
        )
      ));
    });
    return Center(
    child: Stack(
      children: cardList,
    ),
    );
  }
}

Color _getBackgroundColor() {
  return Color.fromARGB(255, 248, 249, 253);
}

Color _getTextColor() {
  return Color.fromARGB(255, 29, 39, 64);
}
void _showCarDetailsSheet(context,MatchCard cardw){
  showModalBottomSheet(context: context, builder: (BuildContext bc){
    return Container(
      child:Column(
        children:<Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration:BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  child: Icon(Icons.close,color:Colors.black),
                ),
              ],
            ),
          Column(
            children: <Widget>[
              Text(cardw.name,style: TextStyle(
                  color: _getTextColor(),
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
              Text(cardw.available,style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color:Color.fromARGB(255, 160, 207, 34)
              )),
              Image.network(cardw.imgSrc,fit:BoxFit.contain),
              RaisedButton(
                onPressed: (){},
                color:_getTextColor(),
                child:Text("Book This Vehicle",style:TextStyle(color:Colors.white),),
              )
            ],
          ),
        ],
      )
    );
  });
}