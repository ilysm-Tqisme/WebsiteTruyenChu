package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Security filter to add security headers and enforce HTTPS
 */
@WebFilter("/*")
public class SecurityFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Add security headers
        httpResponse.setHeader("X-Content-Type-Options", "nosniff");
        httpResponse.setHeader("X-Frame-Options", "DENY");
        httpResponse.setHeader("X-XSS-Protection", "1; mode=block");
        httpResponse.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
        httpResponse.setHeader("Content-Security-Policy", "default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com; style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com; font-src 'self' https://cdnjs.cloudflare.com; img-src 'self' data: https:;");
        
        // Enforce HTTPS in production
        if (!httpRequest.isSecure() && isProductionEnvironment()) {
            String httpsURL = "https://" + httpRequest.getServerName() + 
                             httpRequest.getRequestURI();
            if (httpRequest.getQueryString() != null) {
                httpsURL += "?" + httpRequest.getQueryString();
            }
            httpResponse.sendRedirect(httpsURL);
            return;
        }
        
        // Set character encoding
        if (httpRequest.getCharacterEncoding() == null) {
            httpRequest.setCharacterEncoding("UTF-8");
        }
        httpResponse.setCharacterEncoding("UTF-8");
        
        chain.doFilter(request, response);
    }
    
    private boolean isProductionEnvironment() {
    
        return "production".equalsIgnoreCase(System.getenv("APP_ENV"));
    }

    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
