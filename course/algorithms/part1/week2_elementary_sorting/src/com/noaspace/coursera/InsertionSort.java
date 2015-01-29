package com.noaspace.coursera;

public class InsertionSort extends Sort{

    @Override
    public void sort(Comparable[] arr){
        for (int i = 1; i < arr.length; i ++){
            for (int j = i; j > 0; j --){
                if (less(arr[j], arr[j - 1])){
                    swap(arr, j-1, j);
                }else{
                    break;
                }
            }
        }
    }
}
