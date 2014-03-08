package main;

import java.util.Random;
import stateMachine.*;

public class Main {
    public static void main(String [] args) {
        Sequencer sq = new Sequencer();
        final Random rd = new Random();
        sq.start();
        while (true) {
            try { Thread.sleep(rd.nextInt(1000)); } catch (InterruptedException ie) { /* NOTHING */ }
            final int n = rd.nextInt(3);
            if (n == 0)
                sq.postEvent(new Event1());
            else if (n == 1)
                sq.postEvent(new Event2());
            else
                sq.postEvent(new Event());
        }
    }
}
