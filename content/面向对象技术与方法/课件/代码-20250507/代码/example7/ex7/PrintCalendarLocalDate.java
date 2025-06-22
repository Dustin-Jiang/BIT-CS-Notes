package example7.ex7;
import java.time.LocalDate;

import java.time.temporal.TemporalAdjusters;

public class PrintCalendarLocalDate {

    public static void main(String[] args) {
        LocalDate date = LocalDate.of(2022, 2, 1);

        int year = date.getYear();
        int month = date.getMonthValue();
        int maxDay = date.with(TemporalAdjusters.lastDayOfMonth()).getDayOfMonth();
        int day_of_week = date.getDayOfWeek().getValue();

        //输出标题行
        System.out.println("*******************"+year+"年"+month+"月日历*******************");
        System.out.println("一\t二\t三\t四\t五\t六\t日");

        //计算星期，并输出之前的空白
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
