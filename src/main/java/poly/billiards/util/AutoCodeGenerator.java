package poly.billiards.util;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Utility class để sinh mã tự động cho đồ uống
 */
public class AutoCodeGenerator {
    
    /**
     * Sinh mã mới dựa trên số lượng đồ uống hiện có + 1
     * @param existingCodes Danh sách mã hiện tại
     * @return Mã mới theo thứ tự tăng dần
     */
    public static String generateNextCode(List<String> existingCodes) {
        if (existingCodes == null || existingCodes.isEmpty()) {
            return "001";
        }
        
        // Đếm số lượng đồ uống hiện có
        int count = existingCodes.size();
        
        // Mã mới = số lượng hiện có + 1 (để bắt đầu từ 001)
        int newCodeNumber = count + 1;
        
        // Format thành 3 chữ số với số 0 ở đầu
        return String.format("%03d", newCodeNumber);
    }
    
    /**
     * Sinh mã mới với khoảng trống (tìm mã bị thiếu)
     * @param existingCodes Danh sách mã hiện tại
     * @return Mã mới với khoảng trống đầu tiên
     */
    public static String generateCodeWithGap(List<String> existingCodes) {
        if (existingCodes == null || existingCodes.isEmpty()) {
            return "001";
        }
        
        // Đếm số lượng đồ uống hiện có
        int count = existingCodes.size();
        
        // Mã mới = số lượng hiện có + 1 (để bắt đầu từ 001)
        int newCodeNumber = count + 1;
        
        // Format thành 3 chữ số với số 0 ở đầu
        return String.format("%03d", newCodeNumber);
    }
    
    /**
     * Kiểm tra mã có hợp lệ không (chỉ chấp nhận số)
     * @param code Mã cần kiểm tra
     * @return true nếu hợp lệ
     */
    public static boolean isValidCode(String code) {
        return code != null && code.trim().matches("\\d+");
    }
    
    /**
     * Kiểm tra mã đã tồn tại chưa
     * @param code Mã cần kiểm tra
     * @param existingCodes Danh sách mã hiện tại
     * @return true nếu đã tồn tại
     */
    public static boolean isCodeExists(String code, List<String> existingCodes) {
        if (code == null || existingCodes == null) {
            return false;
        }
        
        return existingCodes.stream()
            .anyMatch(existingCode -> existingCode.trim().equals(code.trim()));
    }
} 