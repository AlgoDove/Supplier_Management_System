package utils;

import java.io.*;
import java.nio.file.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class UserUtils {
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    // Merge Sort for user items (based on expiry date)
    public static void mergeSort(List<String[]> items, int left, int right) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergeSort(items, left, mid);
            mergeSort(items, mid + 1, right);
            merge(items, left, mid, right);
        }
    }

    private static void merge(List<String[]> items, int left, int mid, int right) {

        List<String[]> leftList = new ArrayList<>(items.subList(left, mid + 1));
        List<String[]> rightList = new ArrayList<>(items.subList(mid + 1, right + 1));


        int i = 0, j = 0, k = left;

        while (i < leftList.size() && j < rightList.size()) {
            try {
                Date leftDate = dateFormat.parse(leftList.get(i)[6]);
                Date rightDate = dateFormat.parse(rightList.get(j)[6]);

                if (leftDate.compareTo(rightDate) <= 0) {
                    items.set(k++, leftList.get(i++));
                } else {
                    items.set(k++, rightList.get(j++));
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        while (i < leftList.size()) {
            items.set(k++, leftList.get(i++));
        }

        while (j < rightList.size()) {
            items.set(k++, rightList.get(j++));
        }
    }

}
