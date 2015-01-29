package com.noaspace.coursera;

import java.util.Stack;

public class ShellSort extends Sort {

    @Override
    public void sort(Comparable[] arr) {

        int d = 1;
        while (d < arr.length / 3.0) {
            d = d * 3 + 1;
        }
        Stack s;

        while (d > 0) {
            for (int i = d; i < arr.length; i++) {
                for (int j = i; j >= d; j -= d) {
                    if (less(arr[j], arr[j - d])) {
                        swap(arr, j - d, j);
                    } else {
                        break;
                    }
                }
            }
            d /= 3;
        }
    }
}
