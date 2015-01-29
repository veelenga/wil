package com.noaspace.coursera;

public abstract class Sort {
    public abstract void sort(Comparable[] arr);

    public boolean less(Comparable v, Comparable w) {
        return v.compareTo(w) < 0;
    }

    public void swap(Comparable[] arr, int i, int j) {
        if (i == j){
            return;
        }
        Comparable temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
