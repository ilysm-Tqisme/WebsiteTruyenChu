package listener;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import model.NguoiDung;
import util.SessionRegistry;

@WebListener
public class SessionListener implements HttpSessionListener {
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        Object obj = se.getSession().getAttribute("user");
        if (obj instanceof NguoiDung user) {
            SessionRegistry.removeSession(user.getId());
        }
    }
}
