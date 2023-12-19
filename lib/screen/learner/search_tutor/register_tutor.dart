import 'package:flutter/material.dart';
import 'package:datn/model/user/user.dart' as model_user;

class RegisterTutor extends StatefulWidget {
  model_user.User tutor;

  RegisterTutor({required this.tutor, super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterTutorState();
  }
}

class _RegisterTutorState extends State<RegisterTutor> {
  List<String> subjects = [];
  late String initSubject;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subjects = widget.tutor.subjects ?? [];
    initSubject = subjects[0] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng kí học")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                    style: BorderStyle.solid,
                    color: Theme.of(context).colorScheme.primary),
              ),
              color: Theme.of(context).colorScheme.background,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Chọn môn học',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(30),
                        child: DropdownMenu<String>(
                          initialSelection: subjects.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              initSubject = value!;
                            });
                          },
                          dropdownMenuEntries: subjects.map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(value: value, label: value);
                          }).toList(),
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                      style: BorderStyle.solid,
                      color: Theme.of(context).colorScheme.primary),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                        backgroundImage: (widget.tutor.photoUrl != null)
                            ? NetworkImage(widget.tutor.photoUrl!)
                            : AssetImage('assets/bear.jpg') as ImageProvider,
                        radius: 50),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Center(
                        child: (widget.tutor.displayName != null)
                            ? Text(
                                widget.tutor.displayName!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 24),
                              )
                            : Text('',
                                style: TextStyle(
                                    fontSize: 24,
                                    color:
                                        Theme.of(context).colorScheme.error)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: const OutlineInputBorder(borderSide: BorderSide()),
                      color: Theme.of(context).colorScheme.background,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: (widget.tutor.verify == true)
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Text(
                                      'Đã xác minh',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.verified_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    )
                                  ])
                            : Text(
                                'Đang chờ duyệt',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                    style: BorderStyle.solid,
                    color: Theme.of(context).colorScheme.primary),
              ),
              color: Theme.of(context).colorScheme.background,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Kinh nghiệm',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(30),
                        child: (widget.tutor.experience != null)
                            ? Text(
                                widget.tutor.experience!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              )
                            : Text('',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.error)),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            Center(
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterTutor(tutor: widget.tutor)));
                    },
                    child: Text('Đăng kí học')))
          ],
        ),
      ),
    );
  }
}
