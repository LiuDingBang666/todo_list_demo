import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 应用教授叫
    return MaterialApp(
      title: 'FLUTTER 页面绘制知识复习',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: FlutterKnowledgeReview(),
    );
  }
}

class FlutterKnowledgeReview extends StatefulWidget {
  String name;

  FlutterKnowledgeReview({Key? key, this.name = 'default'}) : super(key: key);

  @override
  _FlutterKnowledgeReviewState createState() => _FlutterKnowledgeReviewState();
}

class _FlutterKnowledgeReviewState extends State<FlutterKnowledgeReview> {
  // 放置状态组件
  int _selectedIndex = 0;
  String _inputText = '';
  bool _isLoading = false;
  final List<String> _todoList = ['学习flutter布局', '掌握状态管理', '练习自定义组件'];

  // 页面列表
  final List<Widget> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages.addAll([
      _buildLayoutPage(),
      _buildWidgetPage(),
      _buildStylePage(),
      _buildInteractionPage(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // 页面脚手架
    return Scaffold(
      // 头部
      appBar: AppBar(
        title: const Text('flutter页面绘制知识复习'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(onPressed: _showInfoDialog, icon: Icon(Icons.info)),
        ],
      ),
      // 身体
      body: IndexedStack(index: _selectedIndex, children: _pages),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value) => {
          setState(() {
            _selectedIndex = value;
          }),
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.view_quilt), label: '布局组件'),
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'UI组件'),
          BottomNavigationBarItem(icon: Icon(Icons.palette), label: '样式主题'),
          BottomNavigationBarItem(icon: Icon(Icons.touch_app), label: '交互状态'),
        ],
      ),
    );
  }

  // 显示信息对话框
  void _showInfoDialog() {}

  // 构建布局页面
  Widget _buildLayoutPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('1、基础布局组件'),
          _buildSubTitle('Container - 容器组件'),
          Container(
            width: double.infinity,
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Container 可以设置宽高、边距、内边距、装饰等',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Row和Column示例
          _buildSubTitle('Row 和 Column - 线性布局'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 60,
                height: 60,
                color: Colors.red,
                child: const Center(
                  child: Text('1', style: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                color: Colors.green,
                child: const Center(
                  child: Text('2', style: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                color: Colors.blue,
                child: const Center(
                  child: Text('3', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          //  column
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                color: Colors.orange,
                child: const Center(
                  child: Text(
                    'Column 子项1',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                color: Colors.purple,
                child: const Center(
                  child: Text(
                    'Column 子项2',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          //  stack
          _buildSubTitle('Stack - 层叠布局'),
          Container(
            height: 150,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Stack 允许组件重叠',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Flex 和 Expanded 示例
          _buildSubTitle('Flex 和 Expanded - 弹性布局'),
          Container(
            height: 60,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        'flex： 2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        'flex： 1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'flex： 1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Wrap 示例
          _buildSubTitle('Wrap - 流式布局'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(8, (index) {
              return Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.primaries[index % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    '标签${index + 1}',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title);
  }

  Widget _buildSubTitle(String title) {
    return Text(title);
  }

  // 构建组件页面
  Widget _buildWidgetPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('2. 常用UI组件'),
          _buildSubTitle('按钮组件'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => _showSnackBar('ElevatedButton 被点击'),
                child: Text('ElevatedButton'),
              ),
              OutlinedButton(
                onPressed: () => _showSnackBar('OutlinedButton 被点击'),
                child: Text('OutlinedButton'),
              ),
              TextButton(
                onPressed: () => _showSnackBar('TextButton 被点击'),
                child: Text('TextButton'),
              ),
              IconButton(
                onPressed: () => _showSnackBar('IconButton 被点击'),
                icon: const Icon(Icons.favorite),
                color: Colors.red,
              ),
            ],
          ),

          // 输入组件
          _buildSubTitle('输入组件'),
          TextField(
            decoration: const InputDecoration(
              labelText: '请输入文本',
              hintText: '这是一个输入框',
              prefixIcon: Icon(Icons.edit),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _inputText = value;
              });
            },
          ),
          const SizedBox(height: 8),
          Text('当前输入： $_inputText'),

          // 选择组件
          _buildSubTitle('选择组件'),
          Row(
            children: [
              Checkbox(
                value: _isLoading,
                onChanged: (value) {
                  setState(() {
                    _isLoading = value ?? false;
                  });
                },
              ),
              const Text('复选框'),
              const SizedBox(width: 20),
              Switch(
                value: _isLoading,
                onChanged: (value) {
                  setState(() {
                    _isLoading = value;
                  });
                },
              ),
              const Text('开关'),
            ],
          ),
          // 列表组件
          _buildSubTitle('列表组件'),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('${index + 1}'),
                  ),
                  title: Text(_todoList[index]),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        _todoList.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                );
              },
            ),
          ),
          // 卡片组件
          _buildSubTitle('卡片组件')
        ],
      ),
    );
  }

  void _showSnackBar(String title) {}
  // 构建样式页面
  Widget _buildStylePage() {
    return Text("data2");
  }

  // 构建内部页面
  Widget _buildInteractionPage() {
    return Text("data3");
  }
}
