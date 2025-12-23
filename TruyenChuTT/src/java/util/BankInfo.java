/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author USER
 */
public class BankInfo {
    private static final Map<String, BankDetails> BANK_MAP = new HashMap<>();
    
    static {
        // Khởi tạo thông tin các ngân hàng
        BANK_MAP.put("VCB", new BankDetails("970436", "Vietcombank", "Ngân hàng TMCP Ngoại thương Việt Nam"));
        BANK_MAP.put("TCB", new BankDetails("970407", "Techcombank", "Ngân hàng TMCP Kỹ thương Việt Nam"));
        BANK_MAP.put("BIDV", new BankDetails("970418", "BIDV", "Ngân hàng TMCP Đầu tư và Phát triển Việt Nam"));
        BANK_MAP.put("VTB", new BankDetails("970415", "Vietinbank", "Ngân hàng TMCP Công thương Việt Nam"));
        BANK_MAP.put("AGB", new BankDetails("970405", "Agribank", "Ngân hàng Nông nghiệp và Phát triển Nông thôn Việt Nam"));
        BANK_MAP.put("MBB", new BankDetails("970422", "MBBank", "Ngân hàng TMCP Quân đội"));
        BANK_MAP.put("STB", new BankDetails("970403", "Sacombank", "Ngân hàng TMCP Sài Gòn Thương tín"));
        BANK_MAP.put("ACB", new BankDetails("970416", "ACB", "Ngân hàng TMCP Á Châu"));
        BANK_MAP.put("VPB", new BankDetails("970432", "VPBank", "Ngân hàng TMCP Việt Nam Thịnh vượng"));
        BANK_MAP.put("TPB", new BankDetails("970423", "TPBank", "Ngân hàng TMCP Tiên Phong"));
    }
    
    public static class BankDetails {
        private final String bin;
        private final String shortName;
        private final String fullName;
        
        public BankDetails(String bin, String shortName, String fullName) {
            this.bin = bin;
            this.shortName = shortName;
            this.fullName = fullName;
        }
        
        public String getBin() { return bin; }
        public String getShortName() { return shortName; }
        public String getFullName() { return fullName; }
    }
    
    /**
     * Lấy thông tin ngân hàng theo mã
     */
    public static BankDetails getBankInfo(String bankCode) {
        return BANK_MAP.get(bankCode.toUpperCase());
    }
    
    /**
     * Lấy BIN của ngân hàng
     */
    public static String getBankBin(String bankCode) {
        BankDetails bank = getBankInfo(bankCode);
        return bank != null ? bank.getBin() : null;
    }
    
    /**
     * Kiểm tra ngân hàng có tồn tại không
     */
    public static boolean isValidBank(String bankCode) {
        return BANK_MAP.containsKey(bankCode.toUpperCase());
    }
    
    /**
     * Lấy danh sách tất cả ngân hàng
     */
    public static Map<String, BankDetails> getAllBanks() {
        return new HashMap<>(BANK_MAP);
    }
}
