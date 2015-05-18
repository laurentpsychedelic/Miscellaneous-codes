package MessagePassing;

import com.sun.jna.Library;
import com.sun.jna.Native;
import com.sun.jna.WString;

public class MessageReader {
    public static void main(String[] args) {
        final MessageReader mr = new MessageReader();
        mr.setHeader("{WPA}::");
        while (true) {
            System.out.println("Message: \"" + mr.readMessage() + "\"");
            try { Thread.sleep(1000 /* 1000ms */); } catch (InterruptedException ie) { /* NOTHING */ }
        }
    }
    void setHeader(String header) {
        NativeMessageReader.nmr.SetHeader(new WString(header));
    }
    String readMessage() {
        final WString wstr = NativeMessageReader.nmr.ReadMeassage();
        return wstr == null ? null : wstr.toString();
    }
    private interface NativeMessageReader extends Library { // native library
        NativeMessageReader nmr = (NativeMessageReader) Native.loadLibrary("MessageReader.dll", NativeMessageReader.class);
        void SetHeader(WString header);
        WString ReadMeassage();
    }
}
