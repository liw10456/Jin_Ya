package com.web.config;

import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import api.domain.Activity;
import api.domain.UserService;

@Controller
public class WelcomeController {
	
	String dbURL = "jdbc:oracle:thin:@localhost:1521/orcl";
	String username = "system";
	String password = "oracle";
	
	private JdbcTemplate jdbcTemplate;
	
//	@Autowired
//	private UserService userService;
	

	private static final Logger LOGGER = Logger.getLogger(WelcomeController.class.getName());
	
	@Autowired
    DataSource dataSource;

	@Value("${village.name}")
	private String villageName;
	
	String result = null;
	
	@RequestMapping(value = "/", method = {RequestMethod.POST,RequestMethod.GET})
	public String welcome(Map<String, Object> model, Authentication auth) {
		model.put("profile", profile());
		model.put("activity", activity()); 
		model.put("people", people()); 
		model.put("publicResource", publicResource());
		model.put("billboard", billboard()); 
		model.put("ad",ad());
		model.put("username", auth==null?"":auth.getName());
		return "welcome";
	}
	
	@RequestMapping(value = {"/userLogout"}, method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseStatus(value=HttpStatus.OK)
    public String logout(Map<String, Object> model, HttpServletRequest request,HttpServletResponse response,@RequestParam(value = "/userLogout", required = false) String logout) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null){    
			LOGGER.info("***"+ auth.getName() + " Logout Successfully.***");
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		model.put("profile", profile());
		model.put("activity", activity()); 
		model.put("people", people()); 
		model.put("publicResource", publicResource());
		model.put("billboard", billboard()); 
		model.put("ad",ad());
		
		return "welcome";
    }
	
	@RequestMapping(value = "/admin**", method = RequestMethod.GET)
	public ModelAndView adminPage() {
	  ModelAndView model = new ModelAndView();
	  model.addObject("title", "Spring Security Login Form - Database Authentication");
	  model.addObject("message", "This page is for ROLE_ADMIN only!");
	  model.setViewName("admin");
	  return model;
	}
	
	@RequestMapping(value="/registration", method = RequestMethod.GET)
	public ModelAndView registration(){
		ModelAndView modelAndView = new ModelAndView();
//		User user = new User();
//		modelAndView.addObject("user", user);
		modelAndView.setViewName("registration");
		return modelAndView;
	}
	
	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public ModelAndView createNewUser(@Valid User user, BindingResult bindingResult) {
		ModelAndView modelAndView = new ModelAndView();
		LOGGER.info("registration");
//		User userExists = userService.findUserByEmail(user.getEmail());
//		if (userExists != null) {
//			bindingResult
//					.rejectValue("email", "error.user",
//							"There is already a user registered with the email provided");
//		}
//		if (bindingResult.hasErrors()) {
//			modelAndView.setViewName("registration");
//		} else {
////			userService.saveUser(user);
//			modelAndView.addObject("successMessage", "User has been registered successfully");
////			modelAndView.addObject("user", new User());
//			modelAndView.setViewName("registration");
//			
//		}
		return modelAndView;
	}
	
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {
	  ModelAndView model = new ModelAndView();
	  Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	  if (!(auth instanceof AnonymousAuthenticationToken)) {
		UserDetails userDetail = (UserDetails) auth.getPrincipal();	
		model.addObject("username", userDetail.getUsername());
	  }
	  model.setViewName("403");
	  return model;
	}
	
	
	
	public Map<String,String> profile() {
		String sql = "SELECT c.* from VILLAGE_INFO c where c.VILLAGE_NAME = '"+villageName+"'";
		Map<String,String> map = new HashMap<>();
	    try {
	          Connection myConnection2 = dataSource.getConnection();
	          PreparedStatement pStmt = myConnection2.prepareStatement(sql);
	          ResultSet rs = pStmt.executeQuery();
	          while (rs.next()) {
	              String name = rs.getString("TITLE");
	              int id = rs.getInt("ID");
	              LOGGER.info("****name:"+name);
	              LOGGER.info("****id:"+id);
	              map.putIfAbsent(name, String.valueOf(id));
	              LOGGER.info("map"+map.toString());
	              
	              System.out.println("**********"+name);
	          }
	    }catch(SQLException sqle){
	        sqle.printStackTrace();
	    }
	    return map; 
	}
	
	public Map<String,String> activity() {
		String sql = "SELECT c.* from VILLAGE_ACTIVITY c where c.VILLAGE_NAME = '"+villageName+"'";
		Map<String,String> map = new HashMap<>();
	    try {
	          Connection myConnection2 = dataSource.getConnection();
	          PreparedStatement pStmt = myConnection2.prepareStatement(sql);
	          ResultSet rs = pStmt.executeQuery();
	          while (rs.next()) {
	              String name = rs.getString("TITLE");
	              long id = rs.getLong("ID");
	              LOGGER.info("****name:"+name);
	              LOGGER.info("****id:"+id);
	              map.putIfAbsent(name, String.valueOf(id));
	              LOGGER.info("map"+map.toString());
	              
	          }
	    }catch(SQLException sqle){
	        sqle.printStackTrace();
	    }
	    return map;
	}
	
	public Map<String,String> people() {
		String sql = "SELECT c.* from VILLAGE_PEOPLE c where c.VILLAGE_NAME = '"+villageName+"'";
		Map<String,String> map = new HashMap<>();
	    try {
	          Connection myConnection2 = dataSource.getConnection();
	          PreparedStatement pStmt = myConnection2.prepareStatement(sql);
	          ResultSet rs = pStmt.executeQuery();
	          while (rs.next()) {
	              String name = rs.getString("TITLE");
	              long id = rs.getLong("ID");
	              LOGGER.info("****name:"+name);
	              LOGGER.info("****id:"+id);
	              map.putIfAbsent(name, String.valueOf(id));
	              LOGGER.info("map"+map.toString());
	              
	          }
	    }catch(SQLException sqle){
	        sqle.printStackTrace();
	    }
	    return map;
	}
	
	public Map<String,String> publicResource() {
		String sql = "SELECT c.* from VILLAGE_PUBLIC_RESOURCES c where c.VILLAGE_NAME = '"+villageName+"'";
		Map<String,String> map = new HashMap<>();
	    try {
	          Connection myConnection2 = dataSource.getConnection();
	          PreparedStatement pStmt = myConnection2.prepareStatement(sql);
	          ResultSet rs = pStmt.executeQuery();
	          while (rs.next()) {
	              String name = rs.getString("TITLE");
	              long id = rs.getLong("ID");
	              LOGGER.info("****name:"+name);
	              LOGGER.info("****id:"+id);
	              map.putIfAbsent(name, String.valueOf(id));
	              LOGGER.info("map"+map.toString());
	              
	          }
	    }catch(SQLException sqle){
	        sqle.printStackTrace();
	    }
	    return map;
	}
	
	public Map<String,String> billboard() {
		String sql = "SELECT c.* from VILLAGE_BROADCAST c where c.VILLAGE_NAME = '"+villageName+"'";
		Map<String,String> map = new HashMap<>();
	    try {
	          Connection myConnection2 = dataSource.getConnection();
	          PreparedStatement pStmt = myConnection2.prepareStatement(sql);
	          ResultSet rs = pStmt.executeQuery();
	          while (rs.next()) {
	              String name = rs.getString("TITLE");
	              long id = rs.getLong("ID");
	              LOGGER.info("****name:"+name);
	              LOGGER.info("****id:"+id);
	              map.putIfAbsent(name, String.valueOf(id));
	              LOGGER.info("map"+map.toString());
	              
	          }
	    }catch(SQLException sqle){
	        sqle.printStackTrace();
	    }
	    return map;
	}
	
	public Map<String,String> ad() {
		String sql = "SELECT c.* from VILLAGE_AD c where c.VILLAGE_NAME = '"+villageName+"'";
		Map<String,String> map = new HashMap<>();
	    try {
	          Connection myConnection2 = dataSource.getConnection();
	          PreparedStatement pStmt = myConnection2.prepareStatement(sql);
	          ResultSet rs = pStmt.executeQuery();
	          while (rs.next()) {
	              String name = rs.getString("TITLE");
	              long id = rs.getLong("ID");
	              LOGGER.info("****name:"+name);
	              LOGGER.info("****id:"+id);
	              map.putIfAbsent(name, String.valueOf(id));
	              LOGGER.info("map"+map.toString());
	              
	          }
	    }catch(SQLException sqle){
	        sqle.printStackTrace();
	    }
	    return map;
	}
	
	@RequestMapping(value = "/activity", consumes = MediaType.APPLICATION_JSON_VALUE, method = RequestMethod.POST)
    public ResponseEntity<String> createActivity(@RequestBody Activity activity) throws SQLException
    {
		Connection conn = DriverManager.getConnection(dbURL, username, password);
		
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		String sql = "INSERT INTO VILLAGE_ACTIVITY ("
				+ "ID, CREATOR, DESCRIPTION, CREATED_TIME, UPDATED_TIME, LOCATION_NAME, START_TIME, END_TIME,GUEST_AMOUNT,TITLE, VILLAGE_NAME) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement statement = conn.prepareStatement(sql);
		statement.setLong(1, currentTime.getTime());
		statement.setString(2, activity.getHostName());
		statement.setString(3, activity.getDescription());
		statement.setTimestamp(4, currentTime);
		statement.setTimestamp(5, currentTime);
		statement.setString(6, activity.getLocation());
		statement.setTimestamp(7,activity.getStartTime());
		statement.setTimestamp(8,activity.getEndTime());		
		statement.setLong(9, activity.getAmount());
		statement.setString(10, activity.getTopic());
		statement.setString(11,villageName);
		int rowsInserted = statement.executeUpdate();
		if (rowsInserted > 0) {
		    System.out.println("A new user was inserted successfully!");
		}
		
		LOGGER.info("activity----"+activity.getAmount());
       
        return new ResponseEntity<String>(HttpStatus.CREATED);
    }
	
	@RequestMapping(value = "/event/{categoryName}/{id}", method = RequestMethod.GET)
    public ResponseEntity<Object> getNeighboodEventInfo(@PathVariable(value="categoryName") final String categoryName,@PathVariable(value="id") final int id, Map<String, Object> model,HttpServletRequest request,HttpServletResponse response) throws SQLException
    {
		String sql = "Select * FROM "+ categoryName +" where ID = "+id + "AND VILLAGE_NAME = '"+villageName+"'";
		List<String> a = new ArrayList<>();
	    try {
	          Connection myConnection2 = dataSource.getConnection();
	          PreparedStatement pStmt = myConnection2.prepareStatement(sql);
	          
	          ResultSet rs = pStmt.executeQuery();
	          while (rs.next()) {
	              model.put("description", rs.getString("DESCRIPTION"));
	              model.put("createdTime", rs.getString("CREATED_TIME"));
	              model.put("title", rs.getString("TITLE"));
	              model.put("creator", rs.getString("CREATOR"));
	          }
	    }catch(SQLException sqle){
	        sqle.printStackTrace();
	    }
	    
	    HttpHeaders responseHeaders = new HttpHeaders();
	    String location = request.getContextPath();
	    responseHeaders.set("MyResponseHeader", "MyValue");
	    
        return new ResponseEntity<Object>(model, responseHeaders, HttpStatus.OK);
    }
}