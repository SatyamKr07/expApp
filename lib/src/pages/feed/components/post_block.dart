import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostBlock extends StatelessWidget {
  // final Map data;
  // const PostBlock({required this.data});
  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    // var date = DateTime.parse(data['created_at'].toDate().toString());
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                hSizedBox1,
                CircleAvatar(
                  radius: 16,
                  backgroundColor: CupertinoColors.systemPurple,
                  child: Icon(
                    CupertinoIcons.person,
                    // color: KConstantColors.conditionalColor(context: context),
                  ),
                ),
                hSizedBox2,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(data['useremail'],
                    //     style: KCustomTextstyle.kMedium(context, 10)),
                    Text(
                      "satyamismyname@gmail.com",
                      // style: KCustomTextstyle.kMedium(context, 10),
                    ),
                    Text(
                      timeago.format(date),
                      // style: KCustomTextstyle.kMedium(context, 8),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.comment,
                          size: 14,
                          // color: KConstantColors.whiteColor,
                        ),
                        hSizedBox2,
                        Text(
                          "Comment",
                          // style: KCustomTextstyle.kBold(context, 8),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: CupertinoColors.systemPurple,
                      borderRadius: BorderRadius.circular(12)),
                ),
                hSizedBox2
              ],
            ),
            vSizedBox2,
            Text(
              "hey captain!",
              // style: KCustomTextstyle.kBold(context, 10),
            ),
            // Text(data['caption'], style: KCustomTextstyle.kBold(context, 10)),
            vSizedBox1,
            Container(
                child: Image.network(
                    "https://d2poqm5pskresc.cloudfront.net/wp-content/uploads/2019/10/Hi-Tech-Platforms-Information-Services.jpg"),
                // child: Image.network(data['imageUrl']),
                color: CupertinoColors.systemPurple),
            vSizedBox1,
            Row(
              children: [
                hSizedBox1,
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.heart,
                      size: 18,
                      // color: KConstantColors.conditionalColor(context: context),
                    ),
                    hSizedBox2,
                    Text(
                      "0",
                      // style: KCustomTextstyle.kMedium(context, 10),
                    )
                  ],
                ),
                hSizedBox3,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
