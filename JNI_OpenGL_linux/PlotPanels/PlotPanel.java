package PlotPanels;

import javax.swing.JFrame;
import java.awt.BorderLayout;
import java.awt.Canvas;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.Timer;

public class PlotPanel extends Canvas implements ActionListener {

    static {
        System.load("/home/laurent-dev/Dropbox/dev/JNI_OpenGL_linux/PlotPanels/libPlotPanel.so");
    }

    public final static int PERIOD = 100;

    private boolean oglInitialized = false;

    public void actionPerformed(ActionEvent evt) {
        if (oglInitialized == false) {
            ID = initializeGL();
            oglInitialized = true;
        }
        paintOpenGLVoid();
    }

    public void addNotify() {
        super.addNotify();
        Timer timer = new Timer(PERIOD, this);
        timer.start();
    }

    public void removeNotify() {
        super.removeNotify();
        releaseGL();
    }

    public void paintOpenGLVoid() {
        paintOpenGLVoid(ID);
    }
    private int ID = -1;
    public native void paintOpenGLVoid(int ID);
    private native int initializeGL();
    private native void releaseGL();

    public static void main(String[] args) {
        JFrame f = new JFrame("OpenGL Test");
        f.setLayout(new BorderLayout());
        f.setSize(512, 512);
        f.add(new PlotPanel());
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.setVisible(true);
    }
}

