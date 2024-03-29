package com.revature.gradingsystem.service;

import com.revature.gradingsystem.dao.AdminDaoImpl;

import java.util.List;

import com.revature.gradingsystem.dao.AdminDao;
import com.revature.gradingsystem.exception.DBException;
import com.revature.gradingsystem.exception.ServiceException;
import com.revature.gradingsystem.exception.ValidatorException;
import com.revature.gradingsystem.model.ScoreRange;
import com.revature.gradingsystem.model.UserDetails;
import com.revature.gradingsystem.validator.GradeValidator;

public class AdminService {

	public UserDetails adminLogin(String name, String pwd) throws ServiceException {
		
		AdminDao admindao=new AdminDaoImpl();
		UserDetails userdetail = null;
		
		try {
			userdetail=admindao.findAdminByNamePassword(name, pwd);
			if (userdetail == null) {
				throw new ServiceException("Invalid Username and password, Please enter the valid one.");
			}
		} catch (DBException e) {
			System.out.println(e.getMessage());
		}
		return userdetail;
		
	}

	public void updateScoreRangeService(String grade, int min, int max) throws ServiceException {

		AdminDao admindao = new AdminDaoImpl();
		try {
			GradeValidator gradeValidator = new GradeValidator();
				gradeValidator.isGradeExist(min, max);
			
			admindao.updateScoreRange(grade, min, max);
			
		}catch (ValidatorException e) {
			throw new ServiceException(e.getMessage());
		}catch (DBException e) {
			throw new ServiceException(e.getMessage());
		}
	}

	public List<ScoreRange> viewScoreRangeService() throws ServiceException {

		AdminDao admindao = new AdminDaoImpl();
		List<ScoreRange> list = null;
		
		try {
			list = admindao.viewScoreRange();
		} catch (DBException e) {
			throw new ServiceException(e.getMessage());
		}
		
		return list;
	}
	
}
