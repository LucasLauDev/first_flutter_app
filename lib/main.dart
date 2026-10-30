import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'title_section.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  DateTime? _selectedDate;
  String? _selectedRole;

  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (DateTime newDate) {
            setState(() => _selectedDate = newDate);
          },
        ),
      ),
    );
  }

  void _showCupertinoRolePicker(BuildContext context) {
    final List<String> roles = ['Student', 'Developer', 'Designer'];
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoPicker(
          itemExtent: 32,
          onSelectedItemChanged: (int index) {
            setState(() => _selectedRole = roles[index]);
          },
          children: roles.map((role) => Center(child: Text(role))).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  Widget _buildPortraitView() {
    return ListView(
      children: [
        _buildStudentDetailsSection(),
        const TitleSection(
          name: 'Hogwarts School of Witchcraft and Wizardry',
          location: 'Hogsmeade, Scotland',
          starCount: 41,
        ),
        _buildInteractivePickers(),
      ],
    );
  }

  Widget _buildLandscapeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: _buildStudentDetailsSection(),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              const TitleSection(
                name: 'Hogwarts School of Witchcraft and Wizardry',
                location: 'Hogsmeade, Scotland',
                starCount: 41,
              ),
              _buildInteractivePickers(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStudentDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.indigo,
                backgroundImage: AssetImage('assets/avatar.jpeg'),
              ),
              const SizedBox(height: 20),
              const Text(
                'LAU TAI HONG',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Student ID: BCS24020028',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const Divider(height: 32, thickness: 1),
              const Text(
                'Personal Life Goal / Quote:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "LIFE for Life",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInteractivePickers() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Pickers (Lab 2.2)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),
            Text('Selected Date: ${_selectedDate?.toString().split(' ')[0] ?? 'None'}'),
            Text('Selected Role: ${_selectedRole ?? 'None'}'),
            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: () => _selectMaterialDate(context),
              icon: const Icon(Icons.date_range),
              label: const Text('Material Date Picker'),
            ),
            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: () => _showCupertinoDatePicker(context),
              icon: const Icon(CupertinoIcons.calendar),
              label: const Text('Cupertino Date Picker (Modal Sheet)'),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const Text('Material Dropdown: '),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedRole,
                  hint: const Text('Select Role'),
                  items: ['Student', 'Developer', 'Designer'].map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedRole = newValue);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: () => _showCupertinoRolePicker(context),
              icon: const Icon(CupertinoIcons.person_2),
              label: const Text('Cupertino Role Wheel Picker'),
            ),
          ],
        ),
      ),
    );
  }
}