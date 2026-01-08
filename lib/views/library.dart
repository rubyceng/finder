import 'package:finder/api/book.api.dart';
import 'package:finder/models/book.model.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool isLoading = false;

  List books = [];

  @override
  void initState() {
    super.initState();

    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    isLoading = true;

    List<Book> books = await BookApi.list();
    isLoading = false;
    if (!mounted) return;

    print("Fetched books: $books");

    setState(() {
      this.books = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 使用 NestedScrollView 以支持标题随滚动缩放
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 120.0, // 对应原型未滚动时的高度
            pinned: true, // 滚动后保持可见 (sticky)
            elevation: 0,
            scrolledUnderElevation: 2, // 滚动后显示阴影
            backgroundColor: Theme.of(context).colorScheme.surface,
            // 用户头像按钮
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHigh,
                  child: const Text("林", style: TextStyle(fontSize: 14)),
                ),
              ),
            ],
            // 核心部分：处理标题收缩逻辑
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16,
                bottom: 16,
              ),
              centerTitle: false,
              title: AnimatedOpacity(
                // 模拟原型：当滚动收缩时，副标题文字变淡消失
                duration: const Duration(milliseconds: 200),
                opacity: 1.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Finder",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // 仅在大标题状态下显示副标题
                    const Text(
                      "你的说明书书架",
                      style: TextStyle(
                        fontSize: 10, // 适配 FlexibleSpaceBar 的缩放
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      // 下方内容区
      body: Container(
        color: Theme.of(context).colorScheme.surface,

        child: books.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Icon(Icons.book, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "书架空空如也",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      Icons.book,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text("Book Item ${books[index].name}"),
                  );
                },
              ),
      ),
    );
  }
}
