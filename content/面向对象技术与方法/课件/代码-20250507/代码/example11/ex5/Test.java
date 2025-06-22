package example11.ex5;

public class Test {
    public static void main(String[] args) {
        Runnable target = new MyRunnable3();

        Thread t1 = new Thread(target, "A");
        Thread t2 = new Thread(target, "B");
        t1.start();
        t2.start();
    }
}
