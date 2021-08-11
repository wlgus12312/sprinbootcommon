package com.auc.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.auc.common.config.CommonFunc;
import com.auc.common.config.ConvertConfig;
import com.auc.common.config.CriptoConfig;
import com.auc.common.vo.LoginUser;
import com.auc.common.vo.ResolverMap;
import com.auc.main.service.MainService;

@RestController
public class MainController {
	
	private static Logger log = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	MainService mainService;
	
	@Autowired
	ConvertConfig convertConfig;
	
	@Autowired
	CriptoConfig criptoConfig;
	
	@Autowired
	CommonFunc commonFunc;
	
	@Resource
	LoginUser loginUser;
	
	
	@ResponseBody
	@RequestMapping(value="/selectMenuList", method=RequestMethod.POST)
	public Map<String, Object> selectMenuList(ResolverMap rMap) throws Exception{				
		
		Map<String, Object> map = convertConfig.conMap(rMap);
				
		//xml 조회
		List<Map<String, Object>> reList = mainService.selectMenuList(map);
				
		//JSON으로 변경
		JSONArray jsonArray = commonFunc.convertListMapToJson(reList);
		
		String encript = criptoConfig.encript(jsonArray.toString());
				
		Map<String, Object> reMap = new HashMap<String, Object>();
		
		reMap.put("data", encript);
		
		return reMap;
	}
	
	
	
	
	@RequestMapping(value="/err", method=RequestMethod.GET)
	public ModelAndView err() throws Exception{	
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello");		
		int i = 1;		
		if(i == 1) {
			throw new RuntimeException();
		}				
		return mv;
	}
		
		
	@RequestMapping(value="/hello", method=RequestMethod.GET)
	public ModelAndView hello() throws Exception{				
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello");		
		
		return mv;
	}
	
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public ModelAndView index() throws Exception{				
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index");		
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/getDataMap", method=RequestMethod.POST)
	public Map<String, Object> getDataMap(ResolverMap rMap) throws Exception{				
		
		Map<String, Object> map = convertConfig.conMap(rMap);
		
		log.info(map.toString());
		
		//xml 조회
		List<Map<String, Object>> reList = mainService.getUserList(map);
				
		//JSON으로 변경
		JSONArray jsonArray = commonFunc.convertListMapToJson(reList);
		
		String encript = criptoConfig.encript(jsonArray.toString());
				
		Map<String, Object> reMap = new HashMap<String, Object>();
		
		reMap.put("data", encript);
		
		return reMap;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(ResolverMap rMap) throws Exception{				
		
		//로그인 세션 값 넣기
		loginUser.setEno("123456");
		
		return "SUCCESS";
	}
	
	
//	@ResponseBody
//	@RequestMapping(value="/getDataListMap", method=RequestMethod.POST)
//	public List<Map<String, Object>> getDataListMap(ResolverMap rMap) throws Exception{				
//								
//		Map<String, Object> map = convertConfig.conMap(rMap); 		
//		log.info(map.toString());		
//				
//		//처리 로직		
//  	    List<Map<String, Object>> reList = new ArrayList<Map<String, Object>>();
//		
//		Map<String, Object> reMap = new HashMap<String, Object>();
//		
//		reMap.put("result", 1);
//		reList.add(reMap);
//		
//		return reList;
//	}
	
	
	
	
	
	

}
