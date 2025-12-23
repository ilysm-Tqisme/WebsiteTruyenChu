/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author USER
 */
public class VietQRGenerator {
    
    // Bank codes theo chuẩn Napas
    public static final String VIETCOMBANK_BIN = "970436";
    public static final String TECHCOMBANK_BIN = "970407";
    public static final String BIDV_BIN = "970418";
    public static final String VIETINBANK_BIN = "970415";
    public static final String AGRIBANK_BIN = "970405";
    public static final String MBBANK_BIN = "970422";
    public static final String SACOMBANK_BIN = "970403";
    public static final String ACB_BIN = "970416";
    public static final String VPBANK_BIN = "970432";
    public static final String TPBANK_BIN = "970423";
    
    // EMVCo Data Objects
    private static final String PAYLOAD_FORMAT_INDICATOR = "00";
    private static final String POINT_OF_INITIATION_METHOD = "01";
    private static final String MERCHANT_ACCOUNT_INFORMATION = "38";
    private static final String TRANSACTION_CURRENCY = "53";
    private static final String TRANSACTION_AMOUNT = "54";
    private static final String COUNTRY_CODE = "58";
    private static final String MERCHANT_NAME = "59";
    private static final String MERCHANT_CITY = "60";
    private static final String ADDITIONAL_DATA_FIELD = "62";
    private static final String CRC = "63";
    
    // VietQR specific
    private static final String VIETQR_GUID = "A000000727";
    private static final String VIETQR_SERVICE = "QRIBFTTA";
    
    /**
     * Tạo VietQR code cho chuyển khoản ngân hàng
     * 
     * @param bankBin Mã BIN của ngân hàng (6 số)
     * @param accountNumber Số tài khoản người nhận
     * @param accountName Tên chủ tài khoản
     * @param amount Số tiền (VND) - BigDecimal
     * @param description Nội dung chuyển khoản
     * @param city Thành phố (mặc định: "Ha Noi")
     * @return Base64 string của QR code image
     */
    public static String generateVietQR(String bankBin, String accountNumber, 
                                       String accountName, BigDecimal amount, 
                                       String description, String city) {
        try {
            String qrData = buildVietQRData(bankBin, accountNumber, accountName, 
                                          amount, description, city);
            return generateQRCodeImage(qrData, 300, 300);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Tạo VietQR code với thông tin mặc định
     */
    public static String generateVietQR(String bankBin, String accountNumber, 
                                       String accountName, BigDecimal amount, 
                                       String description) {
        return generateVietQR(bankBin, accountNumber, accountName, amount, description, "Quang Ngai");
    }
    
    /**
     * Xây dựng Merchant Account Information cho VietQR tương thích MoMo
     */
    private static String buildMerchantAccountInfo(String bankBin, String accountNumber) {
        StringBuilder merchantInfo = new StringBuilder();
        
        // 00: GUID - VietQR GUID
        merchantInfo.append(formatDataObject("00", VIETQR_GUID));
        
        // 01: Service Code - QRIBFTTA cho VietQR
        merchantInfo.append(formatDataObject("01", VIETQR_SERVICE));
        
        // 02: Beneficiary ID - Format đặc biệt cho MoMo: {BankBin}{AccountNumber}
        String cleanAccountNumber = accountNumber.replaceAll("[^0-9]", "");
        String beneficiaryId = bankBin + cleanAccountNumber;
        merchantInfo.append(formatDataObject("02", beneficiaryId));
        
        return merchantInfo.toString();
    }
    
    /**
     * Xây dựng chuỗi dữ liệu VietQR theo chuẩn EMVCo
     */
    private static String buildVietQRData(String bankBin, String accountNumber, 
                                         String accountName, BigDecimal amount, 
                                         String description, String city) {
        StringBuilder qrData = new StringBuilder();
        
        // 00: Payload Format Indicator
        qrData.append(formatDataObject(PAYLOAD_FORMAT_INDICATOR, "01"));
        
        // 01: Point of Initiation Method (11 = static QR, 12 = dynamic QR)
        qrData.append(formatDataObject(POINT_OF_INITIATION_METHOD, "11"));
        
        // 38: Merchant Account Information (VietQR specific)
        String merchantInfo = buildMerchantAccountInfo(bankBin, accountNumber);
        qrData.append(formatDataObject(MERCHANT_ACCOUNT_INFORMATION, merchantInfo));
        
        // 53: Transaction Currency (704 = VND)
        qrData.append(formatDataObject(TRANSACTION_CURRENCY, "704"));
        
        // 54: Transaction Amount - Chỉ thêm nếu có amount
        if (amount != null && amount.compareTo(BigDecimal.ZERO) > 0) {
            // Format số tiền: loại bỏ phần thập phân và format thành string đơn giản
            String amountStr = amount.setScale(0, BigDecimal.ROUND_HALF_UP).toPlainString();
            qrData.append(formatDataObject(TRANSACTION_AMOUNT, amountStr));
        }
        
        // 58: Country Code
        qrData.append(formatDataObject(COUNTRY_CODE, "VN"));
        
        // 59: Merchant Name - Tên người nhận (tối đa 25 ký tự)
        String cleanAccountName = cleanString(accountName, 25);
        qrData.append(formatDataObject(MERCHANT_NAME, cleanAccountName));
        
        // 60: Merchant City - Thành phố (tối đa 15 ký tự)
        String cleanCity = cleanString(city, 15);
        qrData.append(formatDataObject(MERCHANT_CITY, cleanCity));
        
        // 62: Additional Data Field Template - Nội dung chuyển khoản
        if (description != null && !description.trim().isEmpty()) {
            String additionalData = buildAdditionalDataField(description);
            qrData.append(formatDataObject(ADDITIONAL_DATA_FIELD, additionalData));
        }
        
        // 63: CRC - Tính toán CRC16 cho toàn bộ chuỗi
        String dataWithoutCRC = qrData.toString() + CRC + "04";
        String crcValue = calculateCRC16(dataWithoutCRC);
        qrData.append(formatDataObject(CRC, crcValue));
        
        return qrData.toString();
    }
    
    
    /**
     * Xây dựng Additional Data Field Template
     */
    private static String buildAdditionalDataField(String description) {
        StringBuilder additionalData = new StringBuilder();
        
        // 08: Bill Number / Purpose of Transaction
        String cleanDescription = cleanString(description, 25);
        additionalData.append(formatDataObject("08", cleanDescription));
        
        return additionalData.toString();
    }
    
    /**
     * Format data object theo chuẩn EMVCo: ID + Length + Value
     */
    private static String formatDataObject(String id, String value) {
        if (value == null || value.isEmpty()) {
            return "";
        }
        
        String length = String.format("%02d", value.length());
        return id + length + value;
    }
    
    /**
     * Làm sạch chuỗi: loại bỏ ký tự đặc biệt, chuyển thành chữ hoa, cắt độ dài
     */
    private static String cleanString(String input, int maxLength) {
        if (input == null) {
            return "";
        }
        
        // Loại bỏ dấu tiếng Việt và ký tự đặc biệt, chỉ giữ lại chữ cái, số và khoảng trắng
        String cleaned = removeVietnameseAccents(input)
            .replaceAll("[^A-Za-z0-9\\s]", " ")  // Thay thế ký tự đặc biệt bằng khoảng trắng
            .replaceAll("\\s+", " ")             // Gộp nhiều khoảng trắng thành một
            .trim()                              // Loại bỏ khoảng trắng đầu cuối
            .toUpperCase();                      // Chuyển thành chữ hoa
        
        // Cắt chuỗi nếu quá dài
        if (cleaned.length() > maxLength) {
            cleaned = cleaned.substring(0, maxLength).trim();
        }
        
        return cleaned;
    }
    
    /**
     * Loại bỏ dấu tiếng Việt
     */
    private static String removeVietnameseAccents(String input) {
        if (input == null) return "";
        
        String[][] accents = {
            {"à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ", "a"},
            {"è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ", "e"},
            {"ì|í|ị|ỉ|ĩ", "i"},
            {"ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ", "o"},
            {"ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ", "u"},
            {"ỳ|ý|ỵ|ỷ|ỹ", "y"},
            {"đ", "d"},
            {"À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ", "A"},
            {"È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ", "E"},
            {"Ì|Í|Ị|Ỉ|Ĩ", "I"},
            {"Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ", "O"},
            {"Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ", "U"},
            {"Ỳ|Ý|Ỵ|Ỷ|Ỹ", "Y"},
            {"Đ", "D"}
        };
        
        String result = input;
        for (String[] accent : accents) {
            result = result.replaceAll(accent[0], accent[1]);
        }
        
        return result;
    }
    
    /**
     * Tính CRC16 theo chuẩn ISO/IEC 13239
     */
    private static String calculateCRC16(String data) {
        int crc = 0xFFFF;
        byte[] bytes = data.getBytes();
        
        for (byte b : bytes) {
            crc ^= (b & 0xFF);
            for (int i = 0; i < 8; i++) {
                if ((crc & 1) != 0) {
                    crc = (crc >>> 1) ^ 0x8408;
                } else {
                    crc = crc >>> 1;
                }
            }
        }
        
        crc = (~crc) & 0xFFFF;
        return String.format("%04X", crc);
    }
    
    /**
     * Tạo QR code image từ dữ liệu
     */
    private static String generateQRCodeImage(String data, int width, int height) 
            throws WriterException, IOException {
        
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M);
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.MARGIN, 1);
        
        BitMatrix bitMatrix = qrCodeWriter.encode(data, BarcodeFormat.QR_CODE, width, height, hints);
        
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix, "PNG", outputStream);
        
        byte[] pngData = outputStream.toByteArray();
        return Base64.getEncoder().encodeToString(pngData);
    }
    
    /**
     * Method debug để kiểm tra QR data
     */
    public static void debugQRData(String bankBin, String accountNumber, 
                                  String accountName, BigDecimal amount, 
                                  String description) {
        System.out.println("=== DEBUG VIETQR DATA ===");
        System.out.println("Bank BIN: " + bankBin);
        System.out.println("Account Number: " + accountNumber);
        System.out.println("Account Name: " + accountName);
        System.out.println("Amount: " + amount);
        System.out.println("Amount Plain String: " + (amount != null ? amount.setScale(0, BigDecimal.ROUND_HALF_UP).toPlainString() : "null"));
        System.out.println("Description: " + description);
        
        String qrData = buildVietQRData(bankBin, accountNumber, accountName, amount, description, "Ha Noi");
        System.out.println("Generated QR Data: " + qrData);
        System.out.println("QR Data Length: " + qrData.length());
        System.out.println("========================");
    }

    /**
     * Tạo VietQR code tối ưu cho MoMo với format đặc biệt
     */
    public static String generateVietQRForMoMo(String bankBin, String accountNumber,
                                              String accountName, BigDecimal amount,
                                              String description) {
        try {
            // Làm sạch và format dữ liệu đầu vào
            String cleanAccountNumber = accountNumber.replaceAll("[^0-9]", "");
            String cleanAccountName = cleanString(accountName, 25);
            String cleanDescription = cleanString(description, 25);

            // Debug info
            System.out.println("=== MOMO VIETQR DEBUG ===");
            System.out.println("Bank BIN: " + bankBin);
            System.out.println("Clean Account Number: " + cleanAccountNumber);
            System.out.println("Clean Account Name: " + cleanAccountName);
            System.out.println("Amount: " + (amount != null ? amount.toPlainString() : "null"));
            System.out.println("Clean Description: " + cleanDescription);

            String qrData = buildVietQRDataForMoMo(bankBin, cleanAccountNumber, cleanAccountName,
                    amount, cleanDescription, "Quang Ngai");

            System.out.println("Generated QR Data: " + qrData);
            System.out.println("QR Data Length: " + qrData.length());
            System.out.println("========================");

            return generateQRCodeImage(qrData, 300, 300);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Xây dựng chuỗi dữ liệu VietQR tối ưu cho MoMo
     */
    private static String buildVietQRDataForMoMo(String bankBin, String accountNumber, 
                                       String accountName, BigDecimal amount, 
                                       String description, String city) {
        StringBuilder qrData = new StringBuilder();
        
        // 00: Payload Format Indicator
        qrData.append(formatDataObject(PAYLOAD_FORMAT_INDICATOR, "01"));
        
        // 01: Point of Initiation Method (11 = static QR, 12 = dynamic QR)
        qrData.append(formatDataObject(POINT_OF_INITIATION_METHOD, "11"));
        
        // 38: Merchant Account Information (VietQR specific cho MoMo)
        String merchantInfo = buildMerchantAccountInfoForMoMo(bankBin, accountNumber);
        qrData.append(formatDataObject(MERCHANT_ACCOUNT_INFORMATION, merchantInfo));
        
        // 52: Merchant Category Code (MoMo yêu cầu)
        qrData.append(formatDataObject("52", "0000"));
        
        // 53: Transaction Currency (704 = VND)
        qrData.append(formatDataObject(TRANSACTION_CURRENCY, "704"));
        
        // 54: Transaction Amount - Format đặc biệt cho MoMo (không có .00)
        if (amount != null && amount.compareTo(BigDecimal.ZERO) > 0) {
            // MoMo cần format số tiền không có dấu phẩy và không có .00
            String amountStr = amount.setScale(0, BigDecimal.ROUND_HALF_UP).toString();
            qrData.append(formatDataObject(TRANSACTION_AMOUNT, amountStr));
        }
        
        // 58: Country Code
        qrData.append(formatDataObject(COUNTRY_CODE, "VN"));
        
        // 59: Merchant Name - Tên người nhận (tối đa 25 ký tự)
        String cleanAccountName = cleanString(accountName, 25);
        qrData.append(formatDataObject(MERCHANT_NAME, cleanAccountName));
        
        // 60: Merchant City - Thành phố (tối đa 15 ký tự)
        String cleanCity = cleanString(city, 15);
        qrData.append(formatDataObject(MERCHANT_CITY, cleanCity));
        
        // 62: Additional Data Field Template - Nội dung chuyển khoản cho MoMo
        if (description != null && !description.trim().isEmpty()) {
            String additionalData = buildAdditionalDataFieldForMoMo(description);
            qrData.append(formatDataObject(ADDITIONAL_DATA_FIELD, additionalData));
        }
        
        // 63: CRC - Tính toán CRC16 cho toàn bộ chuỗi
        String dataWithoutCRC = qrData.toString() + CRC + "04";
        String crcValue = calculateCRC16(dataWithoutCRC);
        qrData.append(formatDataObject(CRC, crcValue));
        
        return qrData.toString();
    }

    /**
     * Xây dựng Merchant Account Information đặc biệt cho MoMo
     */
    private static String buildMerchantAccountInfoForMoMo(String bankBin, String accountNumber) {
        StringBuilder merchantInfo = new StringBuilder();
        
        // 00: GUID - VietQR GUID
        merchantInfo.append(formatDataObject("00", VIETQR_GUID));
        
        // 01: Service Code - QRIBFTTA cho VietQR
        merchantInfo.append(formatDataObject("01", VIETQR_SERVICE));
        
        // 02: Beneficiary ID - Format: {BankBin}{AccountNumber} (không có khoảng trắng)
        String cleanAccountNumber = accountNumber.replaceAll("[^0-9]", "");
        String beneficiaryId = bankBin + cleanAccountNumber;
        merchantInfo.append(formatDataObject("02", beneficiaryId));
        
        return merchantInfo.toString();
    }

    /**
     * Xây dựng Additional Data Field Template cho MoMo
     */
    private static String buildAdditionalDataFieldForMoMo(String description) {
        StringBuilder additionalData = new StringBuilder();
        
        // 08: Bill Number / Purpose of Transaction - MoMo format
        String cleanDescription = cleanString(description, 25);
        additionalData.append(formatDataObject("08", cleanDescription));
        
        return additionalData.toString();
    }
    
    /**
     * Tạo VietQR code với format cải tiến cho MoMo
     */
    public static String generateVietQRForMoMoV2(String bankBin, String accountNumber,
                                            String accountName, BigDecimal amount,
                                            String description) {
        try {
            // Làm sạch và format dữ liệu đầu vào
            String cleanAccountNumber = accountNumber.replaceAll("[^0-9]", "");
            String cleanAccountName = cleanString(accountName, 25);
            String cleanDescription = cleanString(description, 25);

            // Debug info
            System.out.println("=== MOMO VIETQR V2 DEBUG ===");
            System.out.println("Bank BIN: " + bankBin);
            System.out.println("Clean Account Number: " + cleanAccountNumber);
            System.out.println("Clean Account Name: " + cleanAccountName);
            System.out.println("Amount: " + (amount != null ? amount.toPlainString() : "null"));
            System.out.println("Clean Description: " + cleanDescription);

            String qrData = buildVietQRDataForMoMoV2(bankBin, cleanAccountNumber, cleanAccountName,
                    amount, cleanDescription, "Ha Noi");

            System.out.println("Generated QR Data V2: " + qrData);
            System.out.println("QR Data Length: " + qrData.length());
            System.out.println("========================");

            return generateQRCodeImage(qrData, 300, 300);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Build VietQR data với format cải tiến cho MoMo
     */
    private static String buildVietQRDataForMoMoV2(String bankBin, String accountNumber, 
                                         String accountName, BigDecimal amount, 
                                         String description, String city) {
        StringBuilder qrData = new StringBuilder();
        
        // 00: Payload Format Indicator
        qrData.append(formatDataObject("00", "01"));
        
        // 01: Point of Initiation Method
        qrData.append(formatDataObject("01", "11"));
        
        // 38: Merchant Account Information
        String merchantInfo = buildMerchantAccountInfoV2(bankBin, accountNumber);
        qrData.append(formatDataObject("38", merchantInfo));
        
        // 52: Merchant Category Code
        qrData.append(formatDataObject("52", "0000"));
        
        // 53: Transaction Currency (704 = VND)
        qrData.append(formatDataObject("53", "704"));
        
        // 54: Transaction Amount
        if (amount != null && amount.compareTo(BigDecimal.ZERO) > 0) {
            // Format: số nguyên, không có .00
            long amountLong = amount.longValue();
            qrData.append(formatDataObject("54", String.valueOf(amountLong)));
        }
        
        // 58: Country Code
        qrData.append(formatDataObject("58", "VN"));
        
        // 59: Merchant Name
        String cleanAccountName = cleanString(accountName, 25);
        qrData.append(formatDataObject("59", cleanAccountName));
        
        // 60: Merchant City
        String cleanCity = cleanString(city, 15);
        qrData.append(formatDataObject("60", cleanCity));
        
        // 62: Additional Data Field Template
        if (description != null && !description.trim().isEmpty()) {
            String additionalData = buildAdditionalDataFieldV2(description);
            qrData.append(formatDataObject("62", additionalData));
        }
        
        // 63: CRC
        String dataWithoutCRC = qrData.toString() + "6304";
        String crcValue = calculateCRC16(dataWithoutCRC);
        qrData.append(formatDataObject("63", crcValue));
        
        return qrData.toString();
    }

    /**
     * Build Merchant Account Info V2
     */
    private static String buildMerchantAccountInfoV2(String bankBin, String accountNumber) {
        StringBuilder merchantInfo = new StringBuilder();
        
        // 00: GUID
        merchantInfo.append(formatDataObject("00", "A000000727"));
        
        // 01: Service Code
        merchantInfo.append(formatDataObject("01", "QRIBFTTA"));
        
        // 02: Beneficiary ID
        String beneficiaryId = bankBin + accountNumber;
        merchantInfo.append(formatDataObject("02", beneficiaryId));
        
        return merchantInfo.toString();
    }

    /**
     * Build Additional Data Field V2
     */
    private static String buildAdditionalDataFieldV2(String description) {
        StringBuilder additionalData = new StringBuilder();
        
        // 08: Purpose of Transaction
        String cleanDescription = cleanString(description, 25);
        additionalData.append(formatDataObject("08", cleanDescription));
        
        return additionalData.toString();
    }
    
    /**
     * Utility method để test QR code generation
     */
    public static void main(String[] args) {
        try {
            String qrBase64 = generateVietQR(
                VIETCOMBANK_BIN,
                "1028177524",
                "VO TAN QUY",
                new BigDecimal("50000"),
                "VIP 1 THANG NGUYEN VAN A user@example.com"
            );
            
            if (qrBase64 != null) {
                System.out.println("QR Code generated successfully!");
                System.out.println("Base64 length: " + qrBase64.length());
            } else {
                System.out.println("Failed to generate QR Code");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
