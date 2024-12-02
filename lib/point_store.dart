import 'package:flutter/material.dart';
import 'manage_point.dart';

void main() {
  runApp(pointstore());
}

class pointstore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PointStoreScreen(),
    );
  }
}

class PointStoreScreen extends StatefulWidget {
  @override
  _PointStoreScreenState createState() => _PointStoreScreenState();
}

class _PointStoreScreenState extends State<PointStoreScreen> {
  int points = 1200; // 보유 포인트
  String profileImageUrl = "https://picsum.photos/288/364"; // 프로필 이미지 URL
  bool hasPurchasedNightSky = false; // 밤하늘 테마 구매 여부
  bool hasPurchasedCatSticker = false; // 고양이 스티커 구매 여부
  bool hasPurchasedDogSticker = false; // 강아지 스티커 구매 여부

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('포인트 상점'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pointmanage()),
              );
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: '배경테마'),
              Tab(text: '스티커'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                  Text(
                    '💰 $points',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildThemeTab(),
                  _buildStickerTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.pink[100],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('밤하늘 테마', style: TextStyle(fontSize: 16)),
                    Text('💰 80', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
              ),
              onPressed: hasPurchasedNightSky
                  ? null // 이미 구매했을 경우 버튼 비활성화
                  : () {
                _showPurchaseDialog(
                  context,
                  '밤하늘 테마',
                  80,
                      () {
                    setState(() {
                      if (points >= 80) {
                        points -= 80;
                        hasPurchasedNightSky = true;
                      }
                    });
                  },
                );
              },
              child: Text(
                hasPurchasedNightSky ? '이미 구매했습니다' : '구매하기',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStickerTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildStickerRow('고양이 스티커', 50, hasPurchasedCatSticker, () {
          setState(() {
            if (points >= 50) {
              points -= 50;
              hasPurchasedCatSticker = true;
            }
          });
        }),
        SizedBox(height: 16),
        _buildStickerRow('강아지 스티커', 60, hasPurchasedDogSticker, () {
          setState(() {
            if (points >= 60) {
              points -= 60;
              hasPurchasedDogSticker = true;
            }
          });
        }),
      ],
    );
  }

  Widget _buildStickerRow(String name, int cost, bool hasPurchased, VoidCallback onPurchase) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 16)),
                Text('💰 $cost', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[200],
          ),
          onPressed: hasPurchased
              ? null // 이미 구매했을 경우 버튼 비활성화
              : () {
            _showPurchaseDialog(
              context,
              name,
              cost,
              onPurchase,
            );
          },
          child: Text(hasPurchased ? '이미 구매했습니다' : '구매하기'),
        ),
      ],
    );
  }

  void _showPurchaseDialog(
      BuildContext context, String itemName, int cost, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$itemName 구매하기'),
          content: Text('정말 $itemName를 구매하시겠습니까? 💰 $cost'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                onConfirm(); // 구매 확인 콜백 실행
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text('구매하기'),
            ),
          ],
        );
      },
    );
  }
}
