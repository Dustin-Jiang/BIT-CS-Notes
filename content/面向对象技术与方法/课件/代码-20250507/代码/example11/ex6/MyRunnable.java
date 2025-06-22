package example11.ex6;

public class MyRunnable  implements Runnable{
    private Account account;

    public MyRunnable(Account account) {
        this.account = account;
    }
    public void run() {
        for(int i=0; i<3; i++){
            account.draw(1000);  //每次取1000
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
