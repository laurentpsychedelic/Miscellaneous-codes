import java.io.*;

public class WriteUTF {
    public static void main(String [] args) throws IOException {
        File file = new File(".test~");
        FileOutputStream fos = new FileOutputStream(file);
        DataOutputStream dos = new DataOutputStream(fos);
        dos.writeUTF("123");
        dos.writeUTF("456789");
        dos.writeUTF("12‚¢");
        dos.close();
    }
}
