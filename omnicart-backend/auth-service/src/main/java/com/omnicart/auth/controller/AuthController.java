package com.omnicart.auth.controller;

import com.omnicart.auth.dto.*;
import com.omnicart.auth.entity.Role;
import com.omnicart.auth.entity.User;
import com.omnicart.auth.repository.UserRepository;
import com.omnicart.auth.security.JwtTokenProvider;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider tokenProvider;

    @PostMapping("/register")
    public ResponseEntity<?> register(@Valid @RequestBody RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Email already registered");
        }

        User user = User.builder()
                .email(request.getEmail())
                .passwordHash(passwordEncoder.encode(request.getPassword()))
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .role(Role.CUSTOMER)
                .build();

        userRepository.save(user);

        UserDto userDto = convertToDto(user);
        String token = tokenProvider.generateToken(user.getId(), user.getEmail(), user.getRole().name());

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(AuthResponse.builder().token(token).user(userDto).build());
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElse(null);

        if (user == null || !passwordEncoder.matches(request.getPassword(), user.getPasswordHash())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Invalid email or password");
        }

        UserDto userDto = convertToDto(user);
        String token = tokenProvider.generateToken(user.getId(), user.getEmail(), user.getRole().name());

        return ResponseEntity.ok(AuthResponse.builder().token(token).user(userDto).build());
    }

    @GetMapping("/me")
    public ResponseEntity<?> getProfile() {
        String email = (String) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userRepository.findByEmail(email)
                .orElse(null);

        if (user == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }

        return ResponseEntity.ok(convertToDto(user));
    }

    private UserDto convertToDto(User user) {
        return UserDto.builder()
                .id(user.getId())
                .email(user.getEmail())
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .role(user.getRole())
                .build();
    }
}
