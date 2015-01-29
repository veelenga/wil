package com.noaspace.coursera;

import java.util.Random;

public class Client {

    public static Integer[] generateIntArr(int size) {
        Integer[] arr = new Integer[size];
        Random rand = new Random();
        for (int i = 0; i < arr.length; i++) {
            arr[i] = rand.nextInt(1000);
        }
        return arr;
    }

    public static void printIntArr(Integer[] arr) {
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println("\nIs sorted: " + sorted(arr));
    }

    public static boolean sorted(Integer[] arr) {
        for (int i = 0; i < arr.length - 1; i++) {
            if (arr[i] > arr[i + 1]) {
                return false;
            }
        }
        return true;
    }


    public static void main(String[] str) {
        Integer[] arr = generateIntArr(50);
        //Sort sortable = new InsertionSort();
        //Sort sortable = new SelectionSort();
        Sort sortable = new ShellSort();

        printIntArr(arr);
        sortable.sort(arr);
        printIntArr(arr);
    }
}
