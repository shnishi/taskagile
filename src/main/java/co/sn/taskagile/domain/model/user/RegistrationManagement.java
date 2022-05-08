/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.sn.taskagile.domain.model.user;


import co.sn.taskagile.domain.common.security.PasswordEncryptor;
import org.springframework.stereotype.Component;

/**
 * User registration domain service
 */
@Component
public class RegistrationManagement {

  private UserRepository repository;
  private PasswordEncryptor passwordEncryptor;

  public RegistrationManagement(UserRepository repository, PasswordEncryptor passwordEncryptor) {
    this.repository = repository;
    this.passwordEncryptor = passwordEncryptor;
  }

  public User register(String username, String emailAddress, String password)
    throws RegistrationException {
    User existingUser = repository.findByUsername(username);
    if (existingUser != null) {
      throw new UsernameExistsException();
    }

    existingUser = repository.findByEmailAddress(emailAddress.toLowerCase());
    if (existingUser != null) {
      throw new EmailAddressExistsException();
    }

    String encryptedPassword = passwordEncryptor.encrypt(password);
    User newUser = User.create(username, emailAddress.toLowerCase(), encryptedPassword);
    repository.save(newUser);
    return newUser;
  }
}
