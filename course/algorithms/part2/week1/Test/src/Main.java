public class Main {
    public static void main(String str[]) {
        String sorted[] = {
                "aqua",
                "blue",
                "bole",
                "buff",
                "corn",
                "cyan",
                "drab",
                "dust",
                "fawn",
                "gold",
                "gray",
                "lava",
                "lime",
                "mint",
                "mist",
                "navy",
                "palm",
                "pear",
                "pine",
                "plum",
                "rust",
                "sand",
                "teal",
                "wine"
        };


        String[] notsorted = {
                "aqua",
                "bole",
                "buff",
                "corn",
                "cyan",
                "drab",
                "dust",
                "fawn",
                "gold",
                "lava",
                "lime",
                "palm",
                "pear",
                "rust",
                "sand",
                "wine",
                "gray",
                "pine",
                "blue",
                "teal",
                "plum",
                "mist",
                "mint",
                "navy",






        };

        System.out.println(sorted.length);
        System.out.println(notsorted.length);
        System.out.println();
        for (int i = 0; i < notsorted.length; i++){
            for (int j = 0; j < sorted.length; j ++){
                if (notsorted[i].equals(sorted[j])){
                    System.out.println(j);
                }
            }
        }
    }
}
