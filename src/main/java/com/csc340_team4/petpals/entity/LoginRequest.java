package com.csc340_team4.petpals.entity;

import lombok.Data;

@Data
public class LoginRequest {
    private String email;
    private String password;
}
