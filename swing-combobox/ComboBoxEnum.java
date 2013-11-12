import javax.swing.*;

public class ComboBoxEnum {

    public enum Enum {
        ELE1(1), ELE2(2), UNDEF(-1);
        private int intValue;
        public int intValue() {
            return this.intValue;
        }
        Enum(int intValue) {
            this.intValue = intValue;
        }
    }

    public static void main(String [] args) {
        JFrame frame = new JFrame("Swing Combo Box Test");
        frame.setSize(800, 80);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        /////////////////////////////
        final JComboBox cbox = new JComboBox<Enum>(new DefaultComboBoxModel<Enum>(Enum.values())); //JComboBox及びDefaultComboBoxModelを型Enumにspecialize（特化）させる
        cbox.addActionListener(new java.awt.event.ActionListener() {
                @Override
                public void actionPerformed(java.awt.event.ActionEvent evt) {
                    Object item = cbox.getSelectedItem();
                    System.out.println("item: " + item + "@{" + item.getClass().getSimpleName() + "}");
                    // "item" is effectively an Enum object
                    System.out.println("item int value is: " + ((Enum) item).intValue()); // <- Enumにキャストしちゃっても大丈夫
                }
            });
        ///////////////////////////
        frame.add(cbox);
        frame.setVisible(true);
    }
}
