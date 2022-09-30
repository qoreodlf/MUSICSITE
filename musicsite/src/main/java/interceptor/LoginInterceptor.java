package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String auth = (String) session.getAttribute("userEmail");
		
		if (auth==null) {
			response.sendRedirect(request.getContextPath()+"/user/login");
			return false;
		} else {
			return true;
		}
	}
}
