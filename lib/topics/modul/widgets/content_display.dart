import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart' as ce;
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/modul/screens/modul_lektie_screen.dart';
import 'package:lpp/utils/ad_route.dart';

Widget contentDisplay(ce.Content content) {
  switch (content.runtimeType) {
    case ce.Paragraph:
      return ParagraphWidget(paragraph: content as ce.Paragraph);
    case ce.Header:
      return HeaderWidget(header: content as ce.Header);
    case ce.Image:
      return ImageWidget(
        image: content as ce.Image,
      );
    case ce.Link:
      return LinkWidget(link: content as ce.Link);
    default:
      return Container();
  }
}

const linkStyle = TextStyle(color: Colors.lightBlue);

class LinkWidget extends StatelessWidget {
  const LinkWidget({super.key, required this.link});

  final ce.Link link;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, adRoute(ModulLektieScreen(content: link)));
      },
      child: Text(
        link.text,
        style: linkStyle,
      ),
    );
  }
}

class ParagraphWidget extends StatelessWidget {
  const ParagraphWidget({super.key, required this.paragraph});
  final ce.Paragraph paragraph;
  @override
  Widget build(BuildContext context) {
    return Text(paragraph.text);
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.header});
  final ce.Header header;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          header.text,
          style: headerStyle,
        ),
        subtitle: header.children.isEmpty
            ? null
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: header.children
                    .map((child) => contentDisplay(child))
                    .toList(),
              ));
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.image});
  final ce.Image image;
  @override
  Widget build(BuildContext context) {
    var student = context.read<StudentBloc>().state.student!;
    return Image(image: student.getImage(image.src));
  }
}
