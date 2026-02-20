package com.skillgap.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class PasswordHash {
    
    /**
     * Hash password using SHA-256
     */
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] messageDigest = md.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(messageDigest);
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Password hashing error: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Verify password against hash
     */
    public static boolean verifyPassword(String password, String hash) {
        String hashOfInput = hashPassword(password);
        return hashOfInput != null && hashOfInput.equals(hash);
    }
    
    /**
     * Generate salt for password hashing (optional advanced security)
     */
    public static String generateSalt() {
        byte[] salt = new byte[16];
        new java.util.Random().nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }
    
    /**
     * Hash password with salt
     */
    public static String hashPasswordWithSalt(String password, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            String saltedPassword = password + salt;
            byte[] messageDigest = md.digest(saltedPassword.getBytes());
            return Base64.getEncoder().encodeToString(messageDigest);
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Password hashing error: " + e.getMessage());
            return null;
        }
    }
}
