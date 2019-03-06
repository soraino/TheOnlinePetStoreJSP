package Bean;

import java.io.Serializable;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Random;

public class UserBean implements Serializable {
    private int UserId;
    private String Username;
    private String PasswordHash;
    private String HashPrefix;

    public int getUserId() {
        return UserId;
    }

    public void setUserId(int userId) {
        UserId = userId;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        Username = username;
    }

    public String getPasswordHash() { return PasswordHash; }

    public void setPasswordHash(String passwordHash) { this.PasswordHash = passwordHash; }

    public String getHashPrefix() {
        return HashPrefix;
    }

    public void setHashPrefix(String hashPrefix) {
        HashPrefix = hashPrefix;
    }

    // this is the generate a new password
    public void generatePasswordHash(String password){
        // get the random placement of the prefix
        // the prefix will not be in the front or the back of the password string
        int rand = new Random().nextInt(password.length()-2)+1;

        // generate the unix time of the current system so it will be unique to every password
        long unixTime = System.currentTimeMillis() / 1000L;
        String prefix = String.valueOf(rand)+"%"+String.valueOf(unixTime);
        this.HashPrefix = prefix;

        StringBuilder newPasswordString = new StringBuilder(password);
        newPasswordString.insert(rand,unixTime);
        this.PasswordHash = generate256Hash(newPasswordString.toString());
    }
    // check the password is correct or not
    public boolean checkPassword(String password){
        String[] prefixChunks = this.getHashPrefix().split("%");

        StringBuilder PasswordString = new StringBuilder(password);
        PasswordString.insert(Integer.parseInt(prefixChunks[0]),prefixChunks[1]);

        return this.getPasswordHash().equals(generate256Hash(PasswordString.toString()));
    }

    // this is to create the SHA256 hash
    private String generate256Hash(String passwordWithPrefix){
        try{
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(passwordWithPrefix.getBytes(StandardCharsets.UTF_8));

            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, hash);

            // Convert message digest into hex value
            String hashString = no.toString(16);

            while (hashString.length() < 32) {
                hashString = "0" + hashString;
            }

            return hashString;
        }catch(Exception e){
            // woops
        }
        return "";
    }
}
