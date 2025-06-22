package chapter5.ex8;

public class Ellipse extends Shape{
    private double a; //短轴
    private double b;  //长轴

    public Ellipse() {
        super();
        System.out.println("Ellipse()...");
    }

    public Ellipse(String name) {
        super(name);
        System.out.println("Ellipse(String)...");
    }

    public Ellipse(String name, double a, double b) {
        this(name);
        this.a = a;
        this.b = b;
        System.out.println("Ellipse(String,double,double)...");
    }

    public double getA() {
        return a;
    }
    public double getB() {
        return b;
    }
    public double getArea(){
        return Math.PI*a*b/4;
    }

}
