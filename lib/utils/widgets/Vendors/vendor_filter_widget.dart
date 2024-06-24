import 'package:flutter/material.dart';

class VendorFilterWidget extends StatelessWidget {
  const VendorFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height / 65),
      child: Container(
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionChip(
              elevation: 3,
              backgroundColor: Color(0xff2c4c3b),
              side:  BorderSide.none,
              label: Text(
                'All Vendors',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Color(0xff2c4c3b),
              side:  BorderSide.none,
              label: Text(
                'Active',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Color(0xff2c4c3b),
              side:  BorderSide.none,
              label: Text(
                'In Active',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Color(0xff2c4c3b),
              side:  BorderSide.none,
              label: Text(
                'Top Picked',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Color(0xff2c4c3b),
              side:  BorderSide.none,
              label: Text(
                'Top Rated',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
