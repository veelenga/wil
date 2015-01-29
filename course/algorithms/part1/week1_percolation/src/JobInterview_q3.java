public class JobInterview_q3 {
    private int[] id;    // id[i] = parent of i
    private int[] le;
    private int size;

    public JobInterview_q3(int N) {
        this.size = N;
        id = new int[N + 1];
        le = new int[N + 1];
        for (int i = 0; i < N + 1; i++) {
            id[i] = i;
            if (i == N) {
                le[i] = N;
            } else {
                le[i] = i + 1;
            }
        }
    }

    public int successor(int p) {
        if (p != find(p)) return -1;
        return find(le[p]);
    }

    private int find(int p) {
        while (p != id[p])
            p = id[p];
        return p;
    }

    public void remove(int p) {
        if (p > size) throw new IllegalArgumentException();
        int rootQ = find(p);
        int rootP = 0;
        if (p == size){
            rootP = find(1);
        }else{
            rootP = find(p + 1);
        }

        id[rootQ] = rootP;
        le[rootQ] = le[rootP];
    }


    public static void main(String[] args) {
        JobInterview_q3 job = new JobInterview_q3(10);
        job.remove(1);
        job.remove(3);
        job.remove(6);
        job.remove(7);
        job.remove(8);
        job.remove(10);

        System.out.println(job.successor(1));
        System.out.println(job.successor(2));
        System.out.println(job.successor(3));
        System.out.println(job.successor(4));
        System.out.println(job.successor(5));
        System.out.println(job.successor(6));
        System.out.println(job.successor(7));
        System.out.println(job.successor(8));
        System.out.println(job.successor(9));
        System.out.println(job.successor(10));
    }

}
