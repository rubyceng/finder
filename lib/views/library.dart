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
    setState(() => isLoading = true);
    List<Book> fetchedBooks = await BookApi.list();
    if (!mounted) return;
    setState(() {
      books = fetchedBooks;
      isLoading = false;
    });
  }

  // 辅助方法：构建分类标签
  Widget _buildCategoryChip(
    BuildContext context,
    String label,
    bool isSelected,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool value) {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 消除垂直热区间距
        shape: const StadiumBorder(),
        side: BorderSide.none,
        showCheckmark: false,
        labelStyle: TextStyle(
          fontSize: 12,
          color: isSelected
              ? Theme.of(context).colorScheme.onSecondaryContainer
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        selectedColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // 使用 CustomScrollView 替代 NestedScrollView
      body: CustomScrollView(
        slivers: <Widget>[
          // 1. 伸缩标题栏
          SliverAppBar(
            expandedHeight: 120.0,
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 2,
            backgroundColor: Theme.of(context).colorScheme.surface,
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
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16,
                bottom: 16,
              ),
              centerTitle: false,
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Finder",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // 固定缩放后的基础大小
                    ),
                  ),
                  const Text(
                    "你的说明书书架",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. 分类标签栏
          SliverToBoxAdapter(
            child: Container(
              height: 48, // 调整高度更紧凑
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryChip(context, "客厅", false),
                  _buildCategoryChip(context, "保修中", false),
                  _buildCategoryChip(context, "PDF", false),
                  _buildCategoryChip(context, "家电", false),
                  _buildCategoryChip(context, "汽车", false),
                ],
              ),
            ),
          ),

          // 3. 内容区域
          isLoading
              ? const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              : books.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.book, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          "书架空空如也",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.book,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text("Book Item ${books[index].name}"),
                    );
                  }, childCount: books.length),
                ),

          // 给底部留出一定空间，防止被 FAB 遮挡
          const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
        ],
      ),
    );
  }
}
