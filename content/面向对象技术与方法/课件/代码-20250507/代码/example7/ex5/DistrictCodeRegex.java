package example7.ex5;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DistrictCodeRegex {
    public static void main(String[] args) {

        String districts = "北京:101010100朝阳:101010300顺义:101010400怀柔:101010500通州:101010600昌平:101010700延庆:101010800丰台:101010900石景山:101011000大兴:101011100房山:101011200密云:101011300门头沟:101011400平谷:101011500八达岭:101011600乌兰浩特:101081101";
        String Regex = "([\u4e00-\u9fa5]+):(\\d{9})";

        Pattern pattern = Pattern.compile(Regex);
        Matcher matcher = pattern.matcher(districts);

        while (matcher.find()) {  // 利用匹配器对象判断目标字符串与正则表达式是否匹配
            // 利用group方法提取匹配的分组信息
            System.out.println(matcher.group(1)+":\t"+matcher.group(2));
        }
    }
}
