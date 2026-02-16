package model;

import java.io.Serializable;
import java.sql.Timestamp;

// Bean che rappresenta un utente registrato nel sistema
public class UserBean implements Serializable {
    private int id;
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private String role; // 'USER' or 'ADMIN'
    private Timestamp createdAt;

    public UserBean() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Verifica se l'utente ha privilegi amministrativi
    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(this.role);
    }
}
