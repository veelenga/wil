package com.genesyslab.platform.functional.tests.AppTemplateABTestsJava;

import java.util.HashMap;
import java.util.Map;

public class KeyIndexCounting {
    public static void main(String[] str) {
        Map<String, Integer> map = new HashMap<String, Integer>();
        map.put("a", 0);
        map.put("b", 1);
        map.put("c", 2);
        map.put("d", 3);
        map.put("e", 4);
        map.put("f", 5);

        String[] a = {"d", "a", "c", "f", "f", "b", "d", "b", "f", "b", "e", "a"};

        int N = a.length;
        int R = 6;
        int[] count = new int[R + 1];

        for (int i = 0; i < N; i++) {
            count[map.get(a[i]) + 1]++;
        }

        for (int i = 0; i < count.length; i++) {
            System.out.println(count[i]);
        }

        for (int i = 0; i < R; i++) {
            count[i + 1] += count[i];
        }

        System.out.println();
        for (int i = 0; i < count.length; i++) {
            System.out.println(count[i]);
        }

        int[] aux = new int[N];
        for (int i = 0; i < N; i++) {
            aux[count[map.get(a[i])]++] = map.get(a[i]);
        }

        System.out.println();
        for (int i = 0; i < N; i++) {
            System.out.println(aux[i]);
        }
    }
}
