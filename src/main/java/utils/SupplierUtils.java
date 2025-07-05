package utils;

import java.io.*;
import java.nio.file.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class SupplierUtils {
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    // Modified merge sort to work with arrays
    public static void mergeSort(String[][] items, int left, int right) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergeSort(items, left, mid);
            mergeSort(items, mid + 1, right);
            merge(items, left, mid, right);
        }
    } //recursive merge sort for sorting a 2D array items

    private static void merge(String[][] items, int left, int mid, int right) {
        // 1. Calculate size of left and right halves
        int n1 = mid - left + 1;
        int n2 = right - mid;

        // 2. Create temp arrays to hold copies of these halves
        String[][] leftArray = new String[n1][];
        String[][] rightArray = new String[n2][];

        // 3. Copy data into temporary arrays
        for (int i = 0; i < n1; i++) {
            leftArray[i] = items[left + i];
        }
        for (int j = 0; j < n2; j++) {
            rightArray[j] = items[mid + 1 + j];
        }
        // 4. Merge back by comparing expiry dates
        int i = 0, j = 0, k = left;

        while (i < n1 && j < n2) {
            try {
                // Parse expiry date string to Date object (field at index 6)
                Date date1 = dateFormat.parse(leftArray[i][6]);
                Date date2 = dateFormat.parse(rightArray[j][6]);

                // Compare dates and pick the earlier one
                if (date1.compareTo(date2) <= 0) {
                    items[k++] = leftArray[i++];
                } else {
                    items[k++] = rightArray[j++];
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        // Copy remaining items from leftArray
        while (i < n1) {
            items[k++] = leftArray[i++];
        }
        // Copy remaining items from rightArray
        while (j < n2) {
            items[k++] = rightArray[j++];
        }
    }

    // This is the only place we use List to read from file — not related to your custom data structure
    public static String[][] getSupplierStockLines(String supplierUsername, String filePath) throws IOException {
        BufferedReader reader = new BufferedReader(new FileReader(filePath));
        String line;
        boolean found = false;
        String[][] tempArray = new String[100][];
        int count = 0;

        while ((line = reader.readLine()) != null) {
            if (line.equals(supplierUsername)) {
                found = true;
                continue;
            }

            if (found) {
                if (line.trim().isEmpty()) break;// End of supplier block
                String[] parts = line.split(",");
                if (parts.length >= 7) {
                    if (count == tempArray.length) {
                        // Resize temp array if full
                        String[][] newArray = new String[tempArray.length * 2][];
                        System.arraycopy(tempArray, 0, newArray, 0, tempArray.length);
                        tempArray = newArray;
                    }
                    tempArray[count++] = parts;
                }
            }
        }

        reader.close();

        // Final compacted array
        String[][] result = new String[count][];
        System.arraycopy(tempArray, 0, result, 0, count);
        return result;
    }

    public static String getExpiryStatus(String expiryDateStr) {
        try {
            Date today = new Date();  // Current date/time
            Date expiryDate = dateFormat.parse(expiryDateStr);  // Parse expiry date
            long diff = expiryDate.getTime() - today.getTime(); // Difference in milliseconds
            long days = diff / (1000 * 60 * 60 * 24); // Convert to days

            if (expiryDate.before(today)) return "expired"; // Already expired
            else if (days <= 7) return "soon-expire";  // Expires within 7 days
            else return "normal"; // More than 7 days left

        } catch (ParseException e) {
            return "unknown"; // Return "unknown" if expiry date format is invalid
        }
    }
}
