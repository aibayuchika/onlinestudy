package net.gdpu.interceptor;

import net.gdpu.entity.OsUser;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component
public class LoginInterceptor implements HandlerInterceptor {
    /**
     * 目标路径调用之前执行，如果该方法返回true，则表示用户执行目标路径
     * 否则不让用户执行
     * */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
        HttpSession session = request.getSession();
        OsUser user = (OsUser) session.getAttribute("user");
        //获取用户要访问的路径，保存至session，用户登录后，可从session获取登录前路径
        if(user == null){
            String uri = request.getRequestURI();
            System.out.println(uri);
            request.getSession().setAttribute("toPath", uri);
            response.sendRedirect("/tologin");
            return false;
        } else{
            return true;
        }
    }
    /*
    目标路径调用之后执行
     */
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {
    }

    /*
   目标页面绘制完之后执行
    */
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {
    }
}
