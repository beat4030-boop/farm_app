import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InviteCodePage(), // ← 여기! 바로 초대 코드 화면
    );
  }
}

// 초대 코드 입력 화면
class InviteCodePage extends StatefulWidget {
  @override
  _InviteCodePageState createState() => _InviteCodePageState();
}

class _InviteCodePageState extends State<InviteCodePage> {
  final TextEditingController _codeController = TextEditingController();
  String result = "초대 코드를 입력하세요";

  void checkCode() {
    if (_codeController.text == 'FARM123') {
      setState(() {
        result = "환영합니다! 앱에 입장하셨습니다!";
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else {
      setState(() {
        result = "틀린 코드예요. 다시 입력하세요";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('농수산물 앱 - 초대 코드')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('초대 코드로만 입장 가능!', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: '초대 코드 (예: FARM123)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkCode,
              child: Text('입장하기', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 18, color: result.contains('틀린') ? Colors.red : Colors.green)),
          ],
        ),
      ),
    );
  }
}

// 주소/이름/전화번호 입력 (skip 가능)
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('정보 입력 (skip 가능)')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: '이름 *')),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: '전화번호 *')),
            TextField(controller: _addressController, decoration: InputDecoration(labelText: '정확한 주소 *')),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text('Skip'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty && 
                        _phoneController.text.isNotEmpty && 
                        _addressController.text.isNotEmpty) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('필수 항목을 입력하세요!')),
                      );
                    }
                  },
                  child: Text('다음'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 제품 목록 화면
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cartCount = 0;
  int totalPrice = 0;

  void addToCart(int price) {
    setState(() {
      cartCount++;
      totalPrice += price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('농수산물 판매')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('배추 5kg'),
                  subtitle: Text('10,000원'),
                  trailing: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () => addToCart(10000),
                  ),
                ),
                ListTile(
                  title: Text('고등어 1마리'),
                  subtitle: Text('5,000원'),
                  trailing: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () => addToCart(5000),
                  ),
                ),
                ListTile(
                  title: Text('새우 500g'),
                  subtitle: Text('15,000원'),
                  trailing: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () => addToCart(15000),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Column(
              children: [
                Text('장바구니: $cartCount개 | 총액: $totalPrice원', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('결제는 이체로 부탁드려요!', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('카카오뱅크 3333-12-3456789', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}