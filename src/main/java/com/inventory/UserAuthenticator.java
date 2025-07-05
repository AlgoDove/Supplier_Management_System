package com.inventory;

import java.io.*;

public class UserAuthenticator {
    private final String filePath;

    public UserAuthenticator(String filePath) {
        this.filePath = filePath;
    }

    public boolean authenticate(User user) {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            String storedUsername = "";
            String storedPassword = "";

            while ((line = br.readLine()) != null) {
                if (line.startsWith("name:")) {
                    storedUsername = line.replace("name:", "").trim();
                } else if (line.startsWith("password:")) {
                    storedPassword = line.replace("password:", "").trim();
                }

                //Check if they match
                if (storedUsername.equals(user.getUsername()) &&
                        storedPassword.equals(user.getPassword())) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return false;
    }
}
