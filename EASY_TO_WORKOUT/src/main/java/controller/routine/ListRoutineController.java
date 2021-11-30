package controller.routine;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import service.dto.Routine;
import service.RoutineManager;
import controller.member.MemberSessionUtils;

public class ListRoutineController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		if (!MemberSessionUtils.hasLogined(session)) {
			return "redirect:/login";
		}
		
		MemberSessionUtils.setLoginUserInfo(session, request);
		request.setAttribute("btnType", "routineCreate");
		
		String memberId = MemberSessionUtils.getLoginMemberId(session);

		
		RoutineManager manager = RoutineManager.getInstance();
		
		if (request.getMethod().equals("GET")) {
			List<Routine> routineList = manager.ListingRoutines();
			request.setAttribute("routineList", routineList);
			
			return "/routine/routinePage.jsp";
		}
		
		String type = request.getParameter("sortRoutine");
		
		if (type.equals("1")) {
			request.setAttribute("checkedOne", true);
			
			List<Routine> routineList = manager.ListingRoutines();
			request.setAttribute("routineList", routineList);
		}
		else if (type.equals("2")) {
			request.setAttribute("checkedTwo", true);
			
			List<Routine> routineList = manager.ListingRoutinesByPublic();
			request.setAttribute("routineList", routineList);
		}
		else if (type.equals("3")) {
			request.setAttribute("checkedThree", true);
			
			List<Routine> routineList = manager.ListingRoutinesByPersonal(memberId);
			request.setAttribute("routineList", routineList);
		}
		
		return "/routine/routinePage.jsp";
	}

}
