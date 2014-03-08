package stateMachine;

class StateB extends State {
    @Override
    void doAction() {
        System.out.println("State[B]!");
    }
    StateB() {
        actionTable.put(Event2.class, new Action() {
            @Override
            public State doAction() {
                System.out.println("    -> Transition to [A]!");
                return new StateA();
            }
        });
    }
}
