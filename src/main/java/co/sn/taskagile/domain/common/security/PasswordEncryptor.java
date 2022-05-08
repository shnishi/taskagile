/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package co.sn.taskagile.domain.common.security;

/**
 *
 * @author shigeo
 */
public interface PasswordEncryptor {

    /**
     * Encrypt a raw password
     */
    String encrypt(String rawPassword);
}
