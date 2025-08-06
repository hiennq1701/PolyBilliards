package poly.billiards.ui;

/**
 * Interface để thông báo khi dữ liệu thay đổi
 * Sử dụng để refresh dữ liệu trong các component khác
 */
public interface DataChangeListener {
    /**
     * Được gọi khi dữ liệu thay đổi
     */
    void onDataChanged();
} 