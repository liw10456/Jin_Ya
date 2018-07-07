package com.web.config;

import java.util.logging.Logger;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

@Configuration
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

	@Autowired 
	DataSource dataSource;
	
	private static final Logger LOGGER = Logger.getLogger(SecurityConfiguration.class.getName());

	
    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
        .authorizeRequests()
        .antMatchers("/login/**")
        .access("hasRole('ROLE_ADMIN')")  
        .and()
        .formLogin().loginPage("/login").permitAll()
        .usernameParameter("username")
        .passwordParameter("password")
        .and()
        .logout()
        .logoutUrl("/userLogout")
        .logoutSuccessUrl("/userLogout").permitAll()
        .and()
        .exceptionHandling().accessDeniedPage("/403")
        .and()
        .csrf()
        .requireCsrfProtectionMatcher(new RequestMatcher(){
        	private Pattern allowedMethods = Pattern.compile("^(GET|POST|PUT|DELETE|HEAD|TRACE|OPTIONS)$");
			
        	private AntPathRequestMatcher[] requestMatchers = {
        		new AntPathRequestMatcher("/login"),
        		new AntPathRequestMatcher("/logout")
        	};
        	
        	@Override
			public boolean matches(HttpServletRequest request) {
				if(allowedMethods.matcher(request.getMethod()).matches()){
					return false;
				};
        	
        		for(AntPathRequestMatcher rm:requestMatchers){
        			if(rm.matches(request)){return false;}
        		}
        		return true;
        	}
        });
    }
    
    @Autowired
    public void configAuthentication(AuthenticationManagerBuilder auth) throws Exception {
      auth.jdbcAuthentication().dataSource(dataSource)
     .usersByUsernameQuery(
      "select USERNAME, PASSWORD, 'TRUE' from APP_LOGIN_USER where USERNAME=?")
     .authoritiesByUsernameQuery(
      "select USERNAME, role from APP_LOGIN_USER_ROLES where username=?");
    } 
}