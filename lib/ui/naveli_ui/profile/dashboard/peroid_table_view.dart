import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PeroidTableView(),
  ));
}

class PeroidTableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table with Column and Row Background Color'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          border: TableBorder.all(
            width: 1.0,
            color: Colors.black, // Border color for the entire table
          ),
          children: [
            // Header Row with Background Color
            TableRow(
              decoration: BoxDecoration(
                color: Colors.blue.shade200, // Background color for header row
              ),
              children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      'No.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Age',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            // Row 1 with Different Column Background Colors
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    color: Colors
                        .green.shade100, // Background color for 1st column
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('1'),
                  ),
                ),
                TableCell(
                  child: Container(
                    color: Colors
                        .yellow.shade100, // Background color for 2nd column
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('John Doe'),
                  ),
                ),
                TableCell(
                  child: Container(
                    color: Colors
                        .orange.shade100, // Background color for 3rd column
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('25'),
                  ),
                ),
              ],
            ),
            // Row 2 with Different Column Background Colors
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    color: Colors.green.shade100,
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('2'),
                  ),
                ),
                TableCell(
                  child: Container(
                    color: Colors.yellow.shade100,
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Jane Smith'),
                  ),
                ),
                TableCell(
                  child: Container(
                    color: Colors.orange.shade100,
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('30'),
                  ),
                ),
              ],
            ),
            // Row 3 with Different Column Background Colors
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    color: Colors.green.shade100,
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('3'),
                  ),
                ),
                TableCell(
                  child: Container(
                    color: Colors.yellow.shade100,
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Alice Brown'),
                  ),
                ),
                TableCell(
                  child: Container(
                    color: Colors.orange.shade100,
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('28'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
