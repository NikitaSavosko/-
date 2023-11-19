import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        elevation: 0,

        title: Text(
          'Справка',

          style: TextStyle(
            color: Colors.grey[200],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        leading: IconButton(
          onPressed:() {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(40),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,

        children: <Widget>[

          Text(
            'При входе в приложение вас встречает главный экран:',
            textAlign: TextAlign.center,

            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 400,
            child: Image.asset('assets/images/HomePage.jpg', fit: BoxFit.contain,)
          ),

          Text(
            'На этом экране вы можете добавить новые доходы или расходы, нажав на эту кнопку:',

            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 200,
            child: Image.asset('assets/images/Button.jpg', fit: BoxFit.contain,)
          ),

          Text(
            'В этом окне вы можете изменить режим с  добавления дохода на добавление расхода, нажатием на ползунок.',

            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
            ),
          ),

          Text(
            'Также в этом окне есть поля ввода, которые нужно заполнить (кроме среднего).',

            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 300,
            child: Image.asset('assets/images/addNewItem.jpg', fit: BoxFit.contain,)
          ),

          Text(
            'На окне добавления доходов/расходов, что изображён выше, есть кнопка с иконкой календаря, по нажатии на которую вы сможете выбрать дату, если дату не выбирать, то добавится сегодняшняя.',

            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 350,
            child: Image.asset('assets/images/DataChange.jpg', fit: BoxFit.contain,)
          ),

          Text(
            'На главном экране отображаются доходы или расходы, которые вы добавили.',
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 200,
            child: Image.asset('assets/images/ItemWidget.jpg', fit: BoxFit.contain,)
          ),

          Text(
            'При нажатии на иконку корзины, что изображена на изображении выше, на экран высветится подтверждение удаления.',
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 200,
            child: Image.asset('assets/images/DeleteDialog.jpg', fit: BoxFit.contain,)
          ),

          Text(
            'Также на главном экране есть кнопка меню, по нажатии на которое откроется меню с выбором страниц.',
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 400,
            child: Image.asset('assets/images/HomePage.jpg', fit: BoxFit.contain,)
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 300,
            child: Image.asset('assets/images/Drawer.jpg', fit: BoxFit.contain,)
          ),

          Text(
            'Чтобы открыть страницу (например страницу доходов) вам нужно нажать на одну из них и откроется нужная вам страница.',
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
            ),
          ),

          Text(
            'На странице доходов или расходов вы можете посмотреть детальную информацию по добавленным вами доходам или расходам.',
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 17,
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 200,
            child: Image.asset('assets/images/IncomePage.jpg', fit: BoxFit.contain,)
          ),

        ],
      ),
    );
  }
}