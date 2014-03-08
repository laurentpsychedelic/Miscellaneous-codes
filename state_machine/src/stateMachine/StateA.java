package stateMachine;

class StateA extends State {
    @Override
    void doAction() {
        System.out.println("State[A]!");
    }
    StateA() {
        actionTable.put(Event1.class, new Action() {
            @Override
            public State doAction() {
                System.out.println("    -> Transition to [B]!");
                return new StateB();
            }
        });
    }
}
