package example11.ex1;

public class Test {
    public static void main(String[] args) {
        Thread t1 = new FirstThread();
        Thread t2 = new FirstThread();
        for(int i=0; i<5; i++){
            System.out.println(Thread.currentThread().getName()+" :  "+i);
            for(int j=0; j<500000000; j++);
            if(i==1) t1.start();
            if(i==2) t2.start();
        }
    }

}
