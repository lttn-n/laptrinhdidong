import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: Colors.white),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _currentMode = 'Standard';

  void _onKeyTap(String value) {
    setState(() {
      if (value == 'C' || value == 'CE') {
        _display = '0';
      } else if (value == '⌫') {
        _display = _display.length > 1 ? _display.substring(0, _display.length - 1) : '0';
      } else {
        _display = _display == '0' ? value : _display + value;
      }
    });
  }

  // Hàng trên: MC MR M+ M- MS M⌄
  Widget _memoryRow() {
    const labels = ['MC', 'MR', 'M+', 'M-', 'MS', 'M⌄'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: labels
          .map((l) => Text(l, style: const TextStyle(color: Colors.grey, fontSize: 13)))
          .toList(),
    );
  }

  Widget _buildButton(String label,
      {Color? bgColor, Color? textColor, bool isWide = false}) {
    return Expanded(
      flex: isWide ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor ?? const Color(0xFFF3F3F3),
              foregroundColor: textColor ?? Colors.black87,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: () => _onKeyTap(label),
            child: Text(label, style: const TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<String> labels, {Color? bgColor}) {
    return Row(children: labels.map((l) => _buildButton(l, bgColor: bgColor)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // menu
      drawer: Drawer(
        backgroundColor: const Color(0xFFF0F0F0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Nút menu icon ở đầu drawer giống hình
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFF0F0F0)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text('Calculator', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.calculate_outlined),
              title: const Text('Standard'),
              selected: _currentMode == 'Standard',
              selectedTileColor: Colors.grey.shade300,
              onTap: () {
                setState(() => _currentMode = 'Standard');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.science_outlined),
              title: const Text('Scientific'),
              onTap: () {
                setState(() => _currentMode = 'Scientific');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text('Graphing'),
              onTap: () {
                setState(() => _currentMode = 'Graphing');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Programmer'),
              onTap: () {
                setState(() => _currentMode = 'Programmer');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('Date calculation'),
              onTap: () {
                setState(() => _currentMode = 'Date calculation');
                Navigator.pop(context);
              },
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text('Converter', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on_outlined),
              title: const Text('Currency'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.straighten),
              title: const Text('Volume'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.height),
              title: const Text('Length'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Weight and mass'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.thermostat),
              title: const Text('Temperature'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bolt),
              title: const Text('Energy'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('Area'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.speed),
              title: const Text('Speed'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
     
        title: Text(_currentMode),
        actions: [
          IconButton(icon: const Icon(Icons.open_in_full, size: 18), onPressed: () {}),
          IconButton(icon: const Icon(Icons.history, size: 20), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Màn hình hiển thị kết quả
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.bottomRight,
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w400),
              ),
            ),
            _memoryRow(),
            const SizedBox(height: 8),
            _buildRow(['%', 'CE', 'C', '⌫']),
            _buildRow(['1/x', 'x²', '²√x', '÷']),
            _buildRow(['7', '8', '9', '×']),
            _buildRow(['4', '5', '6', '−']),
            _buildRow(['1', '2', '3', '+']),
            Row(
              children: [
                _buildButton('+/-'),
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('=', bgColor: Colors.blue, textColor: Colors.white),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}