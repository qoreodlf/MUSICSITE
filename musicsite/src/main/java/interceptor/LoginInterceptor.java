package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import model.User;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		User auth =  (User) session.getAttribute("loginUser");
		
		if (auth==null) {
			response.sendRedirect(request.getContextPath()+"/user/login");
			return false;
		} else {
			return true;
		}
	}
}
