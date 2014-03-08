package stateMachine;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class Sequencer {
    private final StateMachine stateMachine = new StateMachine(new StateA());
    BlockingQueue<Event> events = new LinkedBlockingQueue<>();
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
                        Event evt = events.poll();
                        while (null != evt) {
                            System.out.println("Process event<" + evt + ">");
                            stateMachine.processEvent(evt);
                            evt = events.poll();
                        }
                        try { Thread.sleep(intervalMs); } catch (InterruptedException ie) { /* NOTHING */ }
                    }
                }
            }).start();
    }
}
