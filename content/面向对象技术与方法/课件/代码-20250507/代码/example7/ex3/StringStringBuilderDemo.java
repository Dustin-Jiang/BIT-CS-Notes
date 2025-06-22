package example7.ex3;

import java.util.Arrays;

public class StringStringBuilderDemo {

    public static void main(String[] args) {
        String s = "";
        StringBuilder builder5 = new StringBuilder(s);	//包装为StringBuilder类型
        builder5.append("This ").append("is ").append("a ").append("good ").append("idea!");  //利用append()提高拼接的效率
        s = builder5.toString();	//转换为String类型
        String[] words = s.split(" ");  //利用String类的解析方法将字符串用空格分解为 若干个单词
        System.out.println(Arrays.toString(words));  //解析结果,数组[This, is, a, good, idea!]

    }

}

