import 'package:flutter/material.dart';
class Sensitization extends StatefulWidget{
  @override
  State<Sensitization> createState() => _SensitizationState();
}

class _SensitizationState extends State<Sensitization> with SingleTickerProviderStateMixin  {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds:8),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
    Container(
    decoration: BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/images/back.png'),
    fit: BoxFit.cover,
    ),
    ),
    ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Padding(
    padding: const EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 48.0,
    ),
    child: Center(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
      'Water Preservation',
      style: TextStyle(
      color: Colors.blue,
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      ),
      ),
      SizedBox(height: 8.0),
      Text(
      '        Save Water, Save Life',
      style: TextStyle(
      color: Colors.blue,
      fontSize: 18.0,
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
      ),
      ),
      ],
      ),
    ),
    ),
    Expanded(
    child: Container(
    decoration: BoxDecoration(
    color: Theme.of(context).canvasColor,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40.0),
    topRight: Radius.circular(40.0),
    ),
    ),
    child: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'The Importance of Water Preservation',
    style: TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    ),
    ),
    SizedBox(height: 16.0),
    Text(
    'Water is a precious resource that is essential for life. It is used in households, agriculture, and industries, and it is vital for the environment. However, the availability of water is threatened by climate change, pollution, and overuse. By conserving water, we can protect this precious resource and ensure its sustainability for future generations.',
    style: TextStyle(
    fontSize: 18.0,
      color: Theme.of(context).textTheme.headline2?.color,
    ),
    ),
    SizedBox(height: 32.0),
    Text(
    'Tips for Conserving Water',
    style: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    ),
    ),
    SizedBox(height: 16.0),
    ListView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: [
    ListTile(
      textColor:Theme.of(context).textTheme.headline2?.color,
      iconColor: Theme.of(context).textTheme.headline2?.color ,
    leading: Icon(Icons.check_circle_outline),
    title: Text('Fix leaky faucets'),
    ),
    ListTile(
      textColor:Theme.of(context).textTheme.headline2?.color,
      iconColor: Theme.of(context).textTheme.headline2?.color ,
    leading: Icon(Icons.check_circle_outline),
    title: Text('Take shorter showers'),
    ),
    ListTile(
      textColor:Theme.of(context).textTheme.headline2?.color,
      iconColor: Theme.of(context).textTheme.headline2?.color ,
    leading: Icon(Icons.check_circle_outline),
    title: Text('Water your lawn in the morning or evening'),
    ),
    ListTile(
        textColor:Theme.of(context).textTheme.headline2?.color,
        iconColor: Theme.of(context).textTheme.headline2?.color ,
    leading: Icon(Icons.check_circle_outline),
    title: Text('Install low-flow toilets and showerheads')),
      ListTile(
        textColor:Theme.of(context).textTheme.headline2?.color,
        iconColor: Theme.of(context).textTheme.headline2?.color ,
        leading: Icon(Icons.check_circle_outline),
        title: Text('Use a broom instead of a hose to clean driveways and sidewalks'),
      ),
      ListTile(
        textColor:Theme.of(context).textTheme.headline2?.color,
        iconColor: Theme.of(context).textTheme.headline2?.color ,
        leading: Icon(Icons.check_circle_outline),
        title: Text('Only run washing machines and dishwashers when they are full'),
      ),
      ListTile(
        textColor:Theme.of(context).textTheme.headline2?.color,
        iconColor: Theme.of(context).textTheme.headline2?.color ,
        leading: Icon(Icons.check_circle_outline),
        title: Text('Collect rainwater for watering plants'),
      ),
      ListTile(
        textColor:Theme.of(context).textTheme.headline2?.color,
        iconColor: Theme.of(context).textTheme.headline2?.color ,
        leading: Icon(Icons.check_circle_outline),
        title: Text('Do not overwater plants or lawns'),
      ),
      ],
    ),
      SizedBox(height: 32.0),
      Text(
        'Water Preservation Facts',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      SizedBox(height: 16.0),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.blue.withOpacity(0.2),
        ),
        child: Column(
          children: [
            ListTile(
              textColor:Theme.of(context).textTheme.headline2?.color,

              title: Text('75% of the Earth\'s surface is covered in water, but only 1% is available for human use.'),
            ),
            Divider(),
            ListTile(
              textColor:Theme.of(context).textTheme.headline2?.color,

              title: Text('An average American uses 100 gallons of water per day, while an average African family uses only 5 gallons per day.'),
            ),
            Divider(),
            ListTile(
              textColor:Theme.of(context).textTheme.headline2?.color,
              title: Text('A dripping faucet can waste up to 2,000 gallons of water per year.'),
            ),
            Divider(),
            ListTile(
              textColor:Theme.of(context).textTheme.headline2?.color,
              title: Text('Agriculture accounts for 70% of global water usage.'),
            ),
          ],
        ),
      ),
      SizedBox(height: 32.0),
      Center(

        child: ScaleTransition(
          scale: _animation,
          child: Container(
height: 250,
            width: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/D2Q01ONVAAMgdhA.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10)

            ),
          ),
        ),
      ),
      SizedBox(height: 32.0),
      Center(
        child: Text(
          'Save Water, Save Life',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      SizedBox(height: 16.0),
      Center(
        child: Text(
          'Be a Water Hero!',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ],
    ),
    ),
    ),
    ),
    ),
    ],
    ),
        ],
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

