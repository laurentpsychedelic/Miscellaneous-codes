#!/bin/bash

mkdir main
echo 'package main;
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from Java!");
        while (true) {
            System.out.print(".");
            try { Thread.sleep(10000); } catch (InterruptedException ie) {}
        }
    }
}' > main/Main.java
echo 'Manifest-Version: 1.0
Main-Class: main.Main' > manifest.mf
javac main/Main.java && jar cvfm MyApplication.jar manifest.mf main
rm -rvf main/ manifest.mf

