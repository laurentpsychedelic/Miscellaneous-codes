package stateMachine;

import java.util.HashMap;

class State {
    void doAction() {
        /* NOTHING by default */
    }
    final protected void set(StateMachine sm) {
        sm.setState(this);
        doAction();
    }
    final protected State processEvent(Event evt) {
        Action action = actionTable.get(evt.getClass());
        if (null != action)
            return action.doAction();
        return null;
    }
    HashMap<Class<? extends Event>, Action> actionTable = new HashMap<>();
}

