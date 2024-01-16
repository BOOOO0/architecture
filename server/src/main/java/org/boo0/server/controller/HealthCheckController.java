package org.boo0.server.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j2;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;


@RestController
@RequestMapping("/health")
@Log4j2
public class HealthCheckController {
    
    @GetMapping("")
    public ResponseEntity<String> healthCheck() {
        log.info("..............health check");
        return ResponseEntity.ok().build();
    }
    
}
