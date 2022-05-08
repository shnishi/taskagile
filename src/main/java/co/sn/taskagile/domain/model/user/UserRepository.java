/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package co.sn.taskagile.domain.model.user;

/**
 * User repository interface
 */
public interface UserRepository {

  /**
   * Find user by a username
   *
   * @param username the provided username used for finding user
   * @return an instance of <code>User</code> if found, null otherwise
   */
  User findByUsername(String username);

  /**
   * Find user by an email address
   *
   * @param emailAddress the provided email address used for finding user
   * @return an instance of <code>User</code> if found, null otherwise
   */
  User findByEmailAddress(String emailAddress);

  /**
   * Save a new user or an existing user
   *
   * @param user the user instance to be saved
   * @return the newly save user
   */
  void save(User user);
}
