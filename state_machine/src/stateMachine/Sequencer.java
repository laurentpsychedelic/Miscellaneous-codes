package stateMachine;

import java.lang.reflect.InvocationTargetException;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import javax.swing.SwingUtilities;

public class Sequencer {
    private final StateMachine stateMachine = new StateMachine(new StateA());
    private final BlockingQueue<Event> events = new LinkedBlockingQueue<>();
    public void postEvent(Event evt) {
        try {
            events.put(evt);
        } catch (InterruptedException ie) { /* NOTHING */ }
    }
    private final int intervalMs = 100; // 100ms
    public void start() {
        new Thread(new Runnable() {
                @Override
                public void run() {
                    while (true) {
                        try {
                            if (events.size() > 0) {
                                for (final Event evt : events) {
                                    System.out.println("Process event<" + evt + ">");
                                    try {
                                        SwingUtilities.invokeAndWait(new Runnable() {
                                                @Override
                                                public void run() {
                                                    stateMachine.processEvent(evt);
                                                }
                                            });
                                    } catch (InvocationTargetException ite) {
                                        System.out.println("Exception in event processing! :: " + ite.getCause());
                                    }
                                }
                            }
                            Thread.sleep(intervalMs);
                        } catch (InterruptedException ie) { System.exit(0); } // Never happens!
                    }
                }
            }).start();
    }
}
