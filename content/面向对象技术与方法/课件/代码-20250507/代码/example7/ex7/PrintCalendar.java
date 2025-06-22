package example7.ex7;
import java.util.Calendar;

public class PrintCalendar {

    public static void main(String[] args) {
        Calendar cal = Calendar.getInstance();

        cal.set(Calendar.YEAR, 2022);
        cal.set(Calendar.MONTH, 1);
        cal.set(Calendar.DAY_OF_MONTH,1);

        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH)+1;
        int maxDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);  //该月最大天数
        int day_of_week = cal.get(Calendar.DAY_OF_WEEK)-1;  //星期几，调整为1表示星期一⋯⋯
        if(day_of_week==0){  //7表示星期日
            day_of_week=7;
        }

        //输出标题行
        System.out.println("*******************"+year+"年"+month+"月日历*******************");
        System.out.println("一\t二\t三\t四\t五\t六\t日");

        //输出星期几之前的空白
        for(int s=1; s<day_of_week; s++){
            System.out.print("\t");
        }

        //输出该月所有天
        for(int day=1; day<=maxDay; day++){
            System.out.print(day+"\t");
            if((day+day_of_week-1)%7==0){
                System.out.println();
            }
        }
    }
}
