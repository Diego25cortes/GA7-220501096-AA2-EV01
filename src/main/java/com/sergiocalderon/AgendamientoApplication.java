package com.sergiocalderon;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.sergiocalderon.controller", "com.sergiocalderon.service", "com.sergiocalderon.repository"})
public class AgendamientoApplication extends SpringBootServletInitializer {
    
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(AgendamientoApplication.class);
    }
    
    public static void main(String[] args) {
        SpringApplication.run(AgendamientoApplication.class, args);
    }
}