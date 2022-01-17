import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1A1B1D),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                // controller: editProfileController.bioCtrl,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,

                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff7C8395),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xff732EFF)),
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Search something',
                  hintStyle: TextStyle(
                    color: Color(0xff7C8395),
                  ),
                  filled: true,
                  fillColor: Color(0xff23252D),
                  contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              vSizedBox3,
              searchTopic(text: "Top Comments"),
              vSizedBox2,
              searchTopic(text: "Trending Pages"),
              vSizedBox2,
              searchTopic(text: "Trending Commentors"),
              vSizedBox2,
              searchTopic(text: "Trending Topics"),
            ],
          ),
        ));
  }

  Widget searchTopic({required String text}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        // color: Color(0xff732EFF),
        border: Border.all(
          width: 1,
          color: Color(0xff2F333B),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  // color: Color(0xff732EFF),
                  border: Border.all(
                    width: 1,
                    color: Color(0xffF1124D),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.auto_graph_rounded,
                    color: Color(0xffF1124D),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
