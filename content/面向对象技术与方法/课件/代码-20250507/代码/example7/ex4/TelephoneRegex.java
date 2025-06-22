package example7.ex4;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TelephoneRegex {
    public static void main(String[] args) {
        String[] telephones = { "1361052992", "13641052992" };
        String teleRegex = "((13[0-9])|(14[5,7])|(15([0-3,5-9]))|(18[0,5-9]))\\d{8}";
        // 1. 对正则表达式进行包装，创建模式对象
        Pattern pattern = Pattern.compile(teleRegex);
        for(String tele:telephones)	{
            // 2. 通过模式对象获取目标字符串的匹配器Matcher对象
            Matcher matcher = pattern.matcher(tele);
            // 3. 利用匹配器对象判断目标字符串与正则表达式是否匹配
            System.out.println(matcher.find()); // find()方法的返回值为boolean型
        }
    }
}
