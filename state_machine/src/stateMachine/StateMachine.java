package stateMachine;

class StateMachine {
    State currentState;
    protected StateMachine(State initialState) {
        currentState = initialState;
    }
    public void setState(State state) {
        this.currentState = state;
    }
    protected void processEvent(Event evt) {
        State newState = currentState.processEvent(evt);
        if (null != newState)
            newState.set(this);
    }
}
