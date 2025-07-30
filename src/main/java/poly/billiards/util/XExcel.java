package poly.billiards.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import poly.billiards.entity.*;

public class XExcel {
    
    private static File chooseFile(boolean isSave) {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setFileFilter(new FileNameExtensionFilter("Excel Files", "xlsx"));
        int result = isSave ? fileChooser.showSaveDialog(null) : fileChooser.showOpenDialog(null);
        if (result == JFileChooser.APPROVE_OPTION) {
            File file = fileChooser.getSelectedFile();
            if (!file.getName().toLowerCase().endsWith(".xlsx")) {
                file = new File(file.getAbsolutePath() + ".xlsx");
            }
            return file;
        }
        return null;
    }
    
    private static String getStringCellValue(Cell cell) {
        if (cell == null) return null;
        switch (cell.getCellType()) {
            case STRING: return cell.getStringCellValue();
            case NUMERIC: return String.valueOf((int)cell.getNumericCellValue());
            case BOOLEAN: return String.valueOf(cell.getBooleanCellValue());
            default: return null;
        }
    }
    
    private static int getIntegerCellValue(Cell cell) {
        if (cell == null) return 0;
        switch (cell.getCellType()) {
            case NUMERIC: return (int)cell.getNumericCellValue();
            case STRING: return Integer.parseInt(cell.getStringCellValue());
            default: return 0;
        }
    }
    
    private static double getDoubleCellValue(Cell cell) {
        if (cell == null) return 0;
        switch (cell.getCellType()) {
            case NUMERIC: return cell.getNumericCellValue();
            case STRING: return Double.parseDouble(cell.getStringCellValue());
            default: return 0;
        }
    }
    
    private static boolean getBooleanCellValue(Cell cell) {
        if (cell == null) return false;
        switch (cell.getCellType()) {
            case BOOLEAN: return cell.getBooleanCellValue();
            case STRING: return Boolean.parseBoolean(cell.getStringCellValue());
            default: return false;
        }
    }
    
    public static void exportUsers(List<User> users) throws IOException {
        File file = chooseFile(true);
        if (file == null) return;
        
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Users");
            
            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] columns = {"Username", "Full Name", "Email", "Manager", "Enabled", "Photo"};
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
            }
            
            // Add data rows
            int rowNum = 1;
            for (User user : users) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(user.getUsername());
                row.createCell(1).setCellValue(user.getFullname());
                row.createCell(2).setCellValue(user.getEmail());
                row.createCell(3).setCellValue(user.isManager());
                row.createCell(4).setCellValue(user.isEnabled());
                row.createCell(5).setCellValue(user.getPhoto());
            }
            
            // Auto-size columns
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }
            
            // Write to file
            try (FileOutputStream fileOut = new FileOutputStream(file)) {
                workbook.write(fileOut);
            }
        }
    }
    
    public static List<User> importUsers() throws IOException {
        File file = chooseFile(false);
        if (file == null) return null;
        
        List<User> users = new ArrayList<>();
        try (Workbook workbook = WorkbookFactory.create(file)) {
            Sheet sheet = workbook.getSheetAt(0);
            
            // Validate headers
            Row headerRow = sheet.getRow(0);
            String[] requiredColumns = {"Username", "Full Name", "Email", "Manager", "Enabled", "Photo"};
            for (int i = 0; i < requiredColumns.length; i++) {
                Cell cell = headerRow.getCell(i);
                if (cell == null || !cell.getStringCellValue().equals(requiredColumns[i])) {
                    throw new IOException("Lỗi, thiếu dữ liệu quan trọng, hãy xem lại file excel!");
                }
            }
            
            // Read data
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;
                
                User user = new User();
                user.setUsername(getStringCellValue(row.getCell(0)));
                user.setFullname(getStringCellValue(row.getCell(1)));
                user.setEmail(getStringCellValue(row.getCell(2)));
                user.setManager(getBooleanCellValue(row.getCell(3)));
                user.setEnabled(getBooleanCellValue(row.getCell(4)));
                user.setPhoto(getStringCellValue(row.getCell(5)));
                
                // Validate required fields
                if (user.getUsername() == null || user.getUsername().isEmpty() ||
                    user.getFullname() == null || user.getFullname().isEmpty() ||
                    user.getEmail() == null || user.getEmail().isEmpty()) {
                    throw new IOException("Lỗi, thiếu dữ liệu quan trọng, hãy xem lại file excel!");
                }
                
                users.add(user);
            }
        }
        return users;
    }
    
    public static void exportCards(List<Table> tables) throws IOException {
        File file = chooseFile(true);
        if (file == null) return;
        
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Bàn");
            
            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] columns = {"ID bàn", "Trạng thái"};
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
            }
            
            // Add data rows
            int rowNum = 1;
            for (Table table : tables) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(table.getId());
                row.createCell(1).setCellValue(table.getStatus());
            }
            
            // Auto-size columns
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }
            
            // Write to file
            try (FileOutputStream fileOut = new FileOutputStream(file)) {
                workbook.write(fileOut);
            }
        }
    }
    
    public static List<Table> importCards() throws IOException {
        File file = chooseFile(false);
        if (file == null) return new ArrayList<>();
        
        List<Table> tables = new ArrayList<>();
        try (Workbook workbook = WorkbookFactory.create(new FileInputStream(file))) {
            Sheet sheet = workbook.getSheet("Bàn");
            if (sheet == null) return tables;
            
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;
                
                Table table = new Table();
                table.setId(getIntegerCellValue(row.getCell(0)));
                table.setStatus(getIntegerCellValue(row.getCell(1)));
                tables.add(table);
            }
        }
        return tables;
    }
    
    public static void exportDrinks(List<Food> foods) throws IOException {
        File file = chooseFile(true);
        if (file == null) return;
        
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Drinks");
            
            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] columns = {"ID", "Name", "Category ID", "Unit Price", "Discount", "Available", "Image"};
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
            }
            
            // Add data rows
            int rowNum = 1;
            for (Food food : foods) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(food.getId());
                row.createCell(1).setCellValue(food.getName());
                row.createCell(2).setCellValue(food.getCategoryId());
                row.createCell(3).setCellValue(food.getUnitPrice());
                row.createCell(4).setCellValue(food.getDiscount());
                row.createCell(5).setCellValue(food.isAvailable());
                row.createCell(6).setCellValue(food.getImage());
            }
            
            // Auto-size columns
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }
            
            // Write to file
            try (FileOutputStream fileOut = new FileOutputStream(file)) {
                workbook.write(fileOut);
            }
        }
    }
    
    public static List<Food> importDrinks() throws IOException {
        File file = chooseFile(false);
        if (file == null) return null;
        
        List<Food> foods = new ArrayList<>();
        try (Workbook workbook = WorkbookFactory.create(file)) {
            Sheet sheet = workbook.getSheetAt(0);
            
            // Validate headers
            Row headerRow = sheet.getRow(0);
            String[] requiredColumns = {"ID", "Name", "Category ID", "Unit Price", "Discount", "Available", "Image"};
            for (int i = 0; i < requiredColumns.length; i++) {
                Cell cell = headerRow.getCell(i);
                if (cell == null || !cell.getStringCellValue().equals(requiredColumns[i])) {
                    throw new IOException("Lỗi, thiếu dữ liệu quan trọng, hãy xem lại file excel!");
                }
            }
            
            // Read data
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;
                
                Food food = new Food();
                food.setId(getStringCellValue(row.getCell(0)));
                food.setName(getStringCellValue(row.getCell(1)));
                food.setCategoryId(getStringCellValue(row.getCell(2)));
                food.setUnitPrice(getDoubleCellValue(row.getCell(3)));
                food.setDiscount(getDoubleCellValue(row.getCell(4)));
                food.setAvailable(getBooleanCellValue(row.getCell(5)));
                food.setImage(getStringCellValue(row.getCell(6)));
                
                // Validate required fields
                if (food.getId() == null || food.getId().isEmpty() ||
                    food.getName() == null || food.getName().isEmpty() ||
                    food.getCategoryId() == null || food.getCategoryId().isEmpty()) {
                    throw new IOException("Lỗi, thiếu dữ liệu quan trọng, hãy xem lại file excel!");
                }
                
                foods.add(food);
            }
        }
        return foods;
    }
    
    public static void exportCategories(List<FoodCategory> categories) throws IOException {
        File file = chooseFile(true);
        if (file == null) return;
        
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Categories");
            
            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] columns = {"ID", "Name"};
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
            }
            
            // Add data rows
            int rowNum = 1;
            for (FoodCategory category : categories) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(category.getId());
                row.createCell(1).setCellValue(category.getName());
            }
            
            // Auto-size columns
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }
            
            // Write to file
            try (FileOutputStream fileOut = new FileOutputStream(file)) {
                workbook.write(fileOut);
            }
        }
    }
    
    public static List<FoodCategory> importCategories() throws IOException {
        File file = chooseFile(false);
        if (file == null) return null;
        
        List<FoodCategory> categories = new ArrayList<>();
        try (Workbook workbook = WorkbookFactory.create(file)) {
            Sheet sheet = workbook.getSheetAt(0);
            
            // Validate headers
            Row headerRow = sheet.getRow(0);
            String[] requiredColumns = {"ID", "Name"};
            for (int i = 0; i < requiredColumns.length; i++) {
                Cell cell = headerRow.getCell(i);
                if (cell == null || !cell.getStringCellValue().equals(requiredColumns[i])) {
                    throw new IOException("Lỗi, thiếu dữ liệu quan trọng, hãy xem lại file excel!");
                }
            }
            
            // Read data
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;
                
                Category category = new Category();
                category.setId(getStringCellValue(row.getCell(0)));
                category.setName(getStringCellValue(row.getCell(1)));
                
                // Validate required fields
                if (category.getId() == null || category.getId().isEmpty() ||
                    category.getName() == null || category.getName().isEmpty()) {
                    throw new IOException("Lỗi, thiếu dữ liệu quan trọng, hãy xem lại file excel!");
                }
                
                categories.add(category);
            }
        }
        return categories;
    }
    
    public static void exportBills(List<Bill> bills) throws IOException {
        File file = chooseFile(true);
        if (file == null) return;
        
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Hoá đơn");
            
            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] columns = {"ID hoá đơn", "Tên người dùng", "ID bàn", "Thời gian checkin", "Thời gian checkout", "Trạng thái"};
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
            }
            
            // Add data rows
            int rowNum = 1;
            for (Bill bill : bills) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(bill.getId());
                row.createCell(1).setCellValue(bill.getUsername());
                row.createCell(2).setCellValue(bill.getIdtable());
                row.createCell(3).setCellValue(XDate.format(bill.getDatecheckin(), Bill.DATE_PATTERN));
                row.createCell(4).setCellValue(bill.getDatecheckout()!= null ? XDate.format(bill.getDatecheckout(), Bill.DATE_PATTERN) : "");
                row.createCell(5).setCellValue(Bill.Status.values()[bill.getStatus()].name());
            }
            
            // Auto-size columns
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }
            
            // Write to file
            try (FileOutputStream fileOut = new FileOutputStream(file)) {
                workbook.write(fileOut);
            }
        }
    }
    
    public static void exportBillDetails(List<Billinfo> infos) throws IOException {
        File file = chooseFile(true);
        if (file == null) return;
        
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Hoá đơn chi tiết");
            
            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] columns = {"ID", "ID hoá đơn", "ID đồ ăn", "Tên đồ ăn", "Đơn giá", "Giảm giá", "Số lượng"};
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
            }
            
            // Add data rows
            int rowNum = 1;
            for (Billinfo info : infos) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(info.getId());
                row.createCell(1).setCellValue(info.getIdbill());
                row.createCell(2).setCellValue(info.getDrinkName());
                row.createCell(3).setCellValue(info.getUnitPrice());
                row.createCell(4).setCellValue(info.getDiscount());
                row.createCell(5).setCellValue(info.getQuantity());
                row.createCell(6).setCellValue(info.getQuantity() * info.getUnitPrice() * (1 - detail.getDiscount()));
            }
            
            // Auto-size columns
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }
            
            // Write to file
            try (FileOutputStream fileOut = new FileOutputStream(file)) {
                workbook.write(fileOut);
            }
        }
    }
} 