package testlambda;

import java.util.Arrays;

public class TestLambda {

    public static void main(String[] args) {
        System.out.println("Hello from Java 8!!");

        String [] names = new String [] { "ehjs", "adkhjkhwekh ", "sdwedwe", "dafkjhdeffejk" };
        for (String name : names) {
            System.out.print(name + "\t");
        } System.out.println();
        Arrays.sort(names, (str1, str2) -> str1.length() - str2.length());
        for (String name : names) {
            System.out.print(name + "\t");
        } System.out.println();

        //String name = null;
        //System.out.println("Length= " + name?.length() :? "null");

        new Thread(() -> { System.out.println("Hello from a lambda!!"); }).start();
    }

}
