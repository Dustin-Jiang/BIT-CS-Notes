package example11.ex6;

public class Account {
    private double balance;

    public Account(double balance) {
        this.balance = balance;
    }

    //同步取钱方法
    public synchronized void draw(double drawAccount){
        if(balance>=drawAccount){
            System.out.print(Thread.currentThread().getName()+" 取钱"+drawAccount);
            balance -= drawAccount;
            System.out.println(" (余额为:"+balance+")");
        }else{
            System.out.println(Thread.currentThread().getName()+" 当前余额不足");
        }
    }
}
