import java.util.HashMap;
import java.util.Map;

public class WordNet {

    private SAP sap;
    /* Id -> synset relationship */
    private Map<Integer, String> idSynset;
    /* Noun -> ids relationship */
    private Map<String, Bag<Integer>> nounIds;

    public WordNet(String synFile, String hypFile) {
        idSynset = new HashMap<Integer, String>();
        nounIds = new HashMap<String, Bag<Integer>>();

        int size = initSynsets(synFile);
        sap = new SAP(buildDigraph(hypFile, size));
    }

    private int initSynsets(String file) {
        In input = new In(file);
        int id = 0;
        while (input.hasNextLine()) {
            String next = input.readLine();
            String[] split = next.split(",");

            id = Integer.parseInt(split[0]);
            String synset = split[1];
            String[] nouns = synset.split(" ");

            idSynset.put(id, synset);
            for (String noun : nouns) {
                if (nounIds.get(noun) == null) {
                    nounIds.put(noun, new Bag<Integer>());
                }

                nounIds.get(noun).add(id);
            }
        }
        return id + 1;
    }

    private Digraph buildDigraph(String file, int size) {

        In input = new In(file);
        Digraph g = new Digraph(size);
        while (input.hasNextLine()) {
            String[] split = input.readLine().split(",");
            int id = Integer.parseInt(split[0]);
            for (int i = 1; i < split.length; i++) {
                g.addEdge(id, Integer.parseInt(split[i]));
            }
        }
        shouldBeDAG(g);
        shouldBeRooted(g);
        return g;
    }

    private void shouldBeNoun(String word) {
        if (!isNoun(word)) {
            throw new IllegalArgumentException(word + " is not a noun");
        }
    }

    private void shouldBeDAG(Digraph g) {
        DirectedCycle s = new DirectedCycle(g);
        if (s.hasCycle()) {
            throw new IllegalArgumentException("Graph has a directed cycle");
        }
    }

    private void shouldBeRooted(Digraph g) {
        int roots = 0;
        for (int i = 0; i < g.V(); i++) {
            if (!g.adj(i).iterator().hasNext()) {
                roots++;
            }
        }
        if (roots != 1) {
            throw new IllegalArgumentException("Graph is not rooted with one root");
        }
    }

    public Iterable<String> nouns() {
        return nounIds.keySet();
    }

    public boolean isNoun(String word) {
        return nounIds.containsKey(word);
    }

    public int distance(String nounA, String nounB) {
        shouldBeNoun(nounA);
        shouldBeNoun(nounB);
        return sap.length(nounIds.get(nounA), nounIds.get(nounB));
    }

    public String sap(String nounA, String nounB) {
        shouldBeNoun(nounA);
        shouldBeNoun(nounB);
        return idSynset.get(sap.ancestor(nounIds.get(nounA), nounIds.get(nounB)));
    }

    public static void main(String[] args) {
        check1();
        check2();
    }

    private static void check1() {
        WordNet w = new WordNet("input/synsets.txt", "input/hypernyms.txt");

        // isNoun
        assert w.isNoun("1750s");
        assert w.isNoun("Ab");
        assert w.isNoun("Aberdare");
        assert w.isNoun("Abkhaz");
        assert w.isNoun("party_line");

        assert !w.isNoun("Abkhaz Abkhazian Abkhas Abkhasian");
        assert !w.isNoun("asdfasdf;lkwqejrw");

        // nouns
        assert w.nouns() != null;
        int size = 0;
        for (@SuppressWarnings("unused")
        String noun : w.nouns()) {
            size++;
        }
        assert size > 82191;

        // distance
        assert w.distance("Black_Plague", "black_marlin") == 33;
        assert w.distance("American_water_spaniel", "histology") == 27;
        assert w.distance("Brown_Swiss", "barrel_roll") == 29;

        // sap
        assert w.sap("municipality", "region").equals("region");
        assert w.sap("individual", "edible_fruit").equals("physical_entity");
    }

    private static void check2() {
        try {
            new WordNet("input/synsets.txt", "input/hypernymsInvalidCycle.txt");
            assert false;
        } catch (IllegalArgumentException e) {
            System.err.println(e);
        }

        try {
            new WordNet("input/synsets.txt", "input/hypernymsInvalidTwoRoots.txt");
            assert false;
        } catch (IllegalArgumentException e) {
            System.err.println(e);
        }
    }
}
