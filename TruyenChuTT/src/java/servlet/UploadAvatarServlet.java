package servlet;

import dao.NguoiDungDAO;
import jakarta.servlet.annotation.WebServlet;
import model.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@WebServlet("/upload-avatar")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UploadAvatarServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads/avatars";
    private static final String[] ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif"};
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    
    private NguoiDungDAO nguoiDungDAO;
    
    @Override
    public void init() throws ServletException {
        nguoiDungDAO = new NguoiDungDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Lấy file upload
            Part filePart = request.getPart("avatar");
            
            if (filePart == null || filePart.getSize() == 0) {
                session.setAttribute("error", "Vui lòng chọn file ảnh!");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            // Validate file
            String error = validateFile(filePart);
            if (error != null) {
                session.setAttribute("error", error);
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            // Tạo thư mục upload nếu chưa có
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Tạo tên file unique
            String fileName = generateUniqueFileName(filePart);
            String filePath = uploadPath + File.separator + fileName;
            
            // Lưu file
            Path path = Paths.get(filePath);
            Files.copy(filePart.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
            
            // Cập nhật database
            String relativePath = UPLOAD_DIR + "/" + fileName;
            boolean success = nguoiDungDAO.capNhatAnhDaiDien(user.getId(), relativePath);
            
            if (success) {
                // Xóa ảnh cũ nếu có
                if (user.getAnhDaiDien() != null && !user.getAnhDaiDien().isEmpty()) {
                    deleteOldAvatar(user.getAnhDaiDien());
                }
                
                // Cập nhật session
                user.setAnhDaiDien(relativePath);
                session.setAttribute("user", user);
                session.setAttribute("success", "Cập nhật ảnh đại diện thành công!");
            } else {
                // Xóa file nếu không cập nhật được database
                Files.deleteIfExists(path);
                session.setAttribute("error", "Có lỗi xảy ra khi cập nhật ảnh đại diện!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra khi upload ảnh!");
        }
        
        response.sendRedirect(request.getContextPath() + "/profile");
    }
    
    /**
     * Validate file upload
     */
    private String validateFile(Part filePart) {
        String fileName = filePart.getSubmittedFileName();
        if (fileName == null || fileName.trim().isEmpty()) {
            return "Tên file không hợp lệ!";
        }
        
        // Kiểm tra kích thước
        if (filePart.getSize() > MAX_FILE_SIZE) {
            return "File ảnh không được vượt quá 5MB!";
        }
        
        // Kiểm tra định dạng
        String extension = getFileExtension(fileName);
        boolean validExtension = false;
        for (String allowedExt : ALLOWED_EXTENSIONS) {
            if (allowedExt.equalsIgnoreCase(extension)) {
                validExtension = true;
                break;
            }
        }
        
        if (!validExtension) {
            return "Chỉ chấp nhận file ảnh (JPG, JPEG, PNG, GIF)!";
        }
        
        // Kiểm tra MIME type
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return "File không phải là ảnh!";
        }
        
        return null;
    }
    
    /**
     * Tạo tên file unique
     */
    private String generateUniqueFileName(Part filePart) {
        String originalFileName = filePart.getSubmittedFileName();
        String extension = getFileExtension(originalFileName);
        String uniqueId = UUID.randomUUID().toString();
        return "avatar_" + uniqueId + extension;
    }
    
    /**
     * Lấy extension của file
     */
    private String getFileExtension(String fileName) {
        if (fileName == null || fileName.lastIndexOf(".") == -1) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf("."));
    }
    
    /**
     * Xóa ảnh cũ
     */
    private void deleteOldAvatar(String oldAvatarPath) {
        try {
            String fullPath = getServletContext().getRealPath("") + File.separator + oldAvatarPath;
            Path path = Paths.get(fullPath);
            Files.deleteIfExists(path);
        } catch (Exception e) {
            // Log error nhưng không throw exception
            System.err.println("Không thể xóa ảnh cũ: " + e.getMessage());
        }
    }
}
