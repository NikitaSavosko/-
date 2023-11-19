// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Data/Data_Base.dart';
import '../Models/Transaction_Model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {

    if (_myBox.get('TransactionList') == null) {
      db.createInitialData();
    }

    else {
      db.loadData();
    }

    super.initState();
    _balanse = calculateBalance();
  }


  bool isExpence = false;

  double _balanse = 0;

  final _ItemController = TextEditingController();
  final _PriceController = TextEditingController();
  final _DescriptionController = TextEditingController();


  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {

    DateTime? picked = await showDatePicker(
      context: context, 
      locale: const Locale('ru', 'RU'),
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2030),
    );

    if(picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void DeleteItemDialog(int index, bool value, String item, String amount) {
    showDialog(
      context: context, 
      builder:(BuildContext context) {
        return AlertDialog(
          title: Text(
            value == false ? 'Удалить этот доход?' : 'Удалить этот расход?',
          ),

          titleTextStyle: TextStyle(
            color: Colors.grey[900],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),

                    child: Text(
                      item,
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),

                    child: Text(
                      '$amount Br',
                    ),
                  ),
                ],
              ),

              Container(
                color: Colors.grey[300],
                height: 1,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  MaterialButton(
                    onPressed:() {
                      _RemoveItem(index);
                      Navigator.pop(context);
                    },

                    child: const Text(
                      'Да',
                    ),
                  ),

                  MaterialButton(
                    onPressed:() => Navigator.pop(context),

                    child: const Text(
                      'Нет',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _RemoveItem(int index) {

    setState(() {

      if(db.transactions[index].type == false) {
        _balanse -= db.transactions[index].amount;
      }

      else if(db.transactions[index].type == true) {
        _balanse += db.transactions[index].amount;
      }

      db.transactions.removeAt(index);

    });

    db.updateDataBase();
  }

  void _CloseDialog() {
    setState(() {
      clear();
      Navigator.pop(context);
    });
  }

  void clear() {
    setState(() {
      _ItemController.clear();
      _PriceController.clear();
      _DescriptionController.clear();
    });
  }

  void _addNewItem(double value, bool type) {

    setState(() {

      db.transactions.add(
        Transaction(
        name: _ItemController.text,
        description: _DescriptionController.text,
        amount: value, 
        type: type,
        time: selectedDate,
        ));

      if(type == false) {
        _balanse += value;
      }

      else if(type == true) {
        _balanse -= value;
      }

      clear();

      Navigator.pop(context);
    });

    db.updateDataBase();
  }

  double calculateBalance() {
    double total = 0;

    for(var transaction in db.transactions) {
      if(transaction.type == false) {
        total += transaction.amount;
      }

      else if(transaction.type == true) {
        total -= transaction.amount;
      }
    }

    return total;
  }

  void _AddNewItemDialog() {

    showDialog(
      context: context, 
      builder:(BuildContext context) {
        return StatefulBuilder(
          builder:(context, setState) {
            return AlertDialog(
              title: Text(
                'Добавить Доходы/Расходы',
          
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
          
                      Text(
                        'Доходы',
          
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: isExpence == false ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
          
                      Transform.scale(
                        scale: 1.5,

                        child: Switch(
                          value: isExpence, 
                          onChanged: (newValue) {
                            setState(() {
                              isExpence = newValue;
                            });
                          },
                          activeColor: Colors.grey[200],
                          activeTrackColor: Colors.indigoAccent,
                          inactiveThumbColor: Colors.grey[200],
                          inactiveTrackColor: Colors.indigoAccent,
                        ),
                      ),
          
                      Text(
                        'Расходы',
          
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: isExpence == true ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
          
                  TextField(
                    controller: _ItemController,
          
                    decoration: InputDecoration(
                      hintText: isExpence ? 'На что?' : 'Откуда?',
                      
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
          
                  TextField(
                    controller: _DescriptionController,
          
                    decoration: const InputDecoration(
                      hintText: 'Описание(Не обязательно)',
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 1,
          
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          
                  TextField(
                    controller: _PriceController,
                    keyboardType: TextInputType.number,
          
                    decoration: const InputDecoration(
                      hintText: 'Сколько?',
                    ),
                  ),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
          
                    children: [
          
                      IconButton(
                        onPressed:() => _selectDate(context),
          
                        icon: const Icon(Icons.date_range),
                      ),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
          
                          MaterialButton(
                            onPressed: () => _addNewItem(double.parse(_PriceController.text), isExpence),
          
                            child: Text(
                              'Ок',
          
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
          
                          MaterialButton(
                            onPressed: _CloseDialog,
          
                            child: Text(
                              'Отмена',
          
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,

          children: [

            DrawerHeader(

              decoration: const BoxDecoration(
                color: Colors.indigoAccent,
              ),

              child: Text(
                'Домашняя бухгалтерия',
              
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.attach_money, color: Colors.redAccent,),

              title: Text(
                'Расходы',

                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),

              onTap:() {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/OutcomePage');
              },
            ),

            Container(
              color: Colors.grey[300],
              height: 1,
            ),

            ListTile(
              leading: const Icon(Icons.attach_money, color: Colors.greenAccent,),

              title: Text(
                'Доходы',

                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),

              onTap:() {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/IncomePage');
              },
            ),

            Container(
              color: Colors.grey[300],
              height: 1,
            ),

            ListTile(
              leading: const Icon(Icons.help, color: Colors.indigo,),

              title: Text(
                'Справка',

                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),

              onTap:() {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/HelpPage');
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:() {
          setState(() {
            _AddNewItemDialog();
          });
        },

        backgroundColor: Colors.indigoAccent,


        child: const Icon(Icons.add),
      ),

      body: Column(
        children: <Widget>[
      
          Expanded(
            flex: 1,
            
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
              padding: const EdgeInsets.all(20),
                
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 2,
                  color: Color.fromARGB(40, 0, 0, 0),           
                  //offset: Offset(0, 5),
                )],
              ),
                
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
          
                  children: [
          
                    Expanded(
                      child: Text(
                        'Всего:',
                              
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 30,
                        ),
                      ),
                    ),
          
                    Expanded(
                      child: Text(
                        '${_balanse.toStringAsFixed(2)}' ' Br',
                          
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      
          Expanded(
            flex: 3,

            child: ListView.builder(
              shrinkWrap: true,
              itemCount: db.transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  padding: const EdgeInsets.only(left: 0, right: 10, top: 10, bottom: 10),
                
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(
                      blurRadius: 10,
                      color: Color.fromARGB(28, 0, 0, 0),
                      offset: Offset(0, 5),
                    )],
                  ),
                
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                
                      Row(
                        children: [
                      
                          IconButton(
                          
                            onPressed: () {
                              DeleteItemDialog(index, db.transactions[index].type, db.transactions[index].name, db.transactions[index].amount.toString());
                            },
                          
                            icon: const Icon(Icons.delete_forever, color: Colors.redAccent,),
                          ),
                      
                          Text(
                            db.transactions[index].name,
                                              
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                                        
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                
                      Text(
                        db.transactions[index].type == false ? '+ ${db.transactions[index].amount} Br' : '- ${db.transactions[index].amount} Br',
                                          
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                                    
                        style: TextStyle(
                          color: db.transactions[index].type == false ? Colors.lightGreen : Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}