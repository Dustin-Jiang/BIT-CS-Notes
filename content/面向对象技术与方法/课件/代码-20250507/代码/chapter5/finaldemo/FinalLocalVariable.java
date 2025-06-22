package chapter5.finaldemo;

public class FinalLocalVariable {
    public void test(final String paraStr){
//		paraStr = "在方法内部禁止对final参数再次赋值...";

        final String innerStr = "定义时赋初值...";

        final String str;
        str="使用前赋初值...";

        System.out.println(paraStr);
        System.out.println(innerStr);
        System.out.println(str);
    }


    public static void main(String[] args) {
        new FinalLocalVariable().test("调用方法时对final参数赋初值");
        new FinalLocalVariable().test("再次调用方法时对final参数赋初值⋯");
    }
}
