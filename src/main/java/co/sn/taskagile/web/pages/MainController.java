/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.sn.taskagile.web.pages;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 *
 * @author shigeo
 */
@Controller
public class MainController {

    @GetMapping(value = {"/", "/login", "/register"})
    public String entry() {
        return "index";
    }

}
