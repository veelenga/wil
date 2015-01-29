public class Outcast {
    private WordNet wordnet;

    public Outcast(WordNet wordnet) {
        this.wordnet = wordnet;
    }

    public String outcast(String[] nouns) {
        String outcast = null;
        int maxDistance = 0;
        for (int i = 0; i < nouns.length; i++) {
            int distance = 0;
            for (int j = 0; j < nouns.length; j++) {
                if (!nouns[i].equals(nouns[j])) {
                    distance += wordnet.distance(nouns[i], nouns[j]);
                }
            }
            if (distance > maxDistance) {
                maxDistance = distance;
                outcast = nouns[i];
            }
        }
        return outcast;
    }

    public static void main(String[] argss) {
        String[] args = {"input/synsets.txt", "input/hypernyms.txt", "input/outcast5.txt", "input/outcast8.txt",
                "input/outcast11.txt"};
        WordNet wordnet = new WordNet(args[0], args[1]);
        Outcast outcast = new Outcast(wordnet);
        for (int t = 2; t < args.length; t++) {
            In in = new In(args[t]);
            String[] nouns = in.readAllStrings();
            StdOut.println(args[t] + ": " + outcast.outcast(nouns));
        }
    }
}
