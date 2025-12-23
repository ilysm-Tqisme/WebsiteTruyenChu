package util;

import jakarta.servlet.http.HttpSession;
import java.util.concurrent.ConcurrentHashMap;

public class SessionRegistry {
    private static final ConcurrentHashMap<Integer, HttpSession> sessions = new ConcurrentHashMap<>();

    public static void addSession(int userId, HttpSession session) {
        sessions.put(userId, session);
    }

    public static void removeSession(int userId) {
        sessions.remove(userId);
    }

    public static void invalidateSession(int userId) {
        HttpSession session = sessions.get(userId);
        if (session != null) {
            try {
                session.invalidate(); // Hủy session → buộc đăng xuất
            } catch (IllegalStateException e) {
                // Session đã bị huỷ
            }
            sessions.remove(userId);
        }
    }

    public static HttpSession getSession(int userId) {
        return sessions.get(userId);
    }
}
