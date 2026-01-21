/// Pagination helper utility
class AppPaginationHelper {
  /// Calculate total pages based on items per page
  static int calculateTotalPages(int totalItems, int itemsPerPage) {
    if (totalItems == 0) return 1;
    return (totalItems / itemsPerPage).ceil();
  }

  /// Get items for current page
  static List<T> getPageItems<T>(
    List<T> allItems,
    int currentPage,
    int itemsPerPage,
  ) {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    if (startIndex >= allItems.length) {
      return [];
    }
    return allItems.sublist(
      startIndex,
      endIndex > allItems.length ? allItems.length : endIndex,
    );
  }

  /// Get page numbers to display (with ellipsis)
  static List<int?> getPageNumbers(int currentPage, int totalPages) {
    if (totalPages <= 7) {
      return List.generate(totalPages, (i) => i + 1);
    }

    final pages = <int?>[];

    if (currentPage <= 3) {
      // Show first 5 pages, then ellipsis, then last page
      for (int i = 1; i <= 5; i++) {
        pages.add(i);
      }
      pages.add(null); // Ellipsis
      pages.add(totalPages);
    } else if (currentPage >= totalPages - 2) {
      // Show first page, ellipsis, then last 5 pages
      pages.add(1);
      pages.add(null); // Ellipsis
      for (int i = totalPages - 4; i <= totalPages; i++) {
        pages.add(i);
      }
    } else {
      // Show first page, ellipsis, current-1, current, current+1, ellipsis, last page
      pages.add(1);
      pages.add(null); // Ellipsis
      pages.add(currentPage - 1);
      pages.add(currentPage);
      pages.add(currentPage + 1);
      pages.add(null); // Ellipsis
      pages.add(totalPages);
    }

    return pages;
  }

  /// Get start item number for display (1-indexed)
  static int getStartItemNumber(int currentPage, int itemsPerPage) {
    return (currentPage - 1) * itemsPerPage + 1;
  }

  /// Get end item number for display (1-indexed)
  static int getEndItemNumber(
    int currentPage,
    int itemsPerPage,
    int totalItems,
  ) {
    final end = currentPage * itemsPerPage;
    return end > totalItems ? totalItems : end;
  }
}
