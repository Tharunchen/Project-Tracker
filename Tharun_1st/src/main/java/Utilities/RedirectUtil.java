package Utilities;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RedirectUtil {

    public static void redirect(
            HttpServletRequest req,
            HttpServletResponse res,
            String message,
            String page
    ) throws IOException {

        // store message for one-time display
        req.getSession().setAttribute("msg", message);

        // redirect to Main.jsp with dynamic page
        res.sendRedirect(
            req.getContextPath() + "/pages/Main.jsp?page=" + page
        );
    }
}
