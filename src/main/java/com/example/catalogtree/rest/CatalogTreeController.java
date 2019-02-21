package com.example.catalogtree.rest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller

public class CatalogTreeController {
    @RequestMapping("/catalogtree")
    @ResponseBody
    public ModelAndView testFtl(ModelAndView modelAndView){
        modelAndView.setViewName("catalogtree");
        return modelAndView;
    }
}
