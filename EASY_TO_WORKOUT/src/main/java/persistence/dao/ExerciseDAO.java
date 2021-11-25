package persistence.dao;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

import service.dto.*;
import persistence.util.JDBCUtil;

public class ExerciseDAO {

	private JDBCUtil jdbcUtil = null;
	
	private static String query = "SELECT EXERCISE.EXERCISEID AS EXERCISE_ID, " +
	         "EXERCISE.NAME AS EXERCISE_NAME, " +
	         "EXERCISE.PART AS EXERCISE_PART, " +
	         "EXERCISE.METHOD AS EXERCISE_METHOD ";
	
	public ExerciseDAO() {
		jdbcUtil = new JDBCUtil();
	}
	
	public List<Exercise> getExerciseList() {
		String allQuery = query +
			   "FROM EXERCISE ORDER BY EXERCISE.EXERCISEID ASC ";		
		jdbcUtil.setSqlAndParameters(allQuery, null);		// JDBCUtil 에 query 설정

		try { 
				ResultSet rs = jdbcUtil.executeQuery();		// query 문 실행			
				List<Exercise> list = new ArrayList<Exercise>();		// ExerciseDTO 객체들을 담기위한 list 객체
				while (rs.next()) {	
					Exercise dto = new Exercise();		// 하나의 ExerciseDTO 객체 생성 후 정보 설정
					dto.setExerciseId(rs.getInt("EXERCISE_ID"));
					dto.setName(rs.getString("EXERCISE_NAME"));
					dto.setPart(rs.getString("EXERCISE_PART"));
					dto.setMethod(rs.getString("EXERCISE_METHOD"));
					list.add(dto);		// list 객체에 정보를 설정한 ExerciseDTO 객체 저장
				}
				return list;		// 운동을 저장한 dto들의 목록을 반환
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// ResultSet, PreparedStatement, Connection 반환
		}		
		return null;
	}

	public Exercise getExerciseByName(String name) {
		String searchQuery = query +
		        "FROM EXERCISE " +
		        "WHERE EXERCISE.NAME = ? ";
		   	 
		Object[] param = new Object[] { name };
		
		jdbcUtil.setSqlAndParameters(searchQuery, param);

		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 문 실행
			Exercise dto = null;
			if (rs.next()) {						// 찾은 운동의 정보를 ExerciseDTO 객체에 설정
				dto = new Exercise();
				dto.setExerciseId(rs.getInt("EXERCISE_ID"));
				dto.setName(rs.getString("EXERCISE_NAME"));
				dto.setPart(rs.getString("EXERCISE_PART"));
				dto.setMethod(rs.getString("EXERCISE_METHOD"));
			}
			return dto;				// 찾은 운동의 정보를 담고 있는 ExerciseDTO 객체 반환
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// ResultSet, PreparedStatement, Connection 반환
		}
		return null;
	}

}
