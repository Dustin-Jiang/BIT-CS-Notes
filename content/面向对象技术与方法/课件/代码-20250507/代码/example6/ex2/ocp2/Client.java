package example6.ex2.ocp2;

public class Client {
    public static void main(String[] args){
        ChartDisplay chartDisplay = new ChartDisplay();

        PieChart pie = new PieChart();
        chartDisplay.setChart(pie);
        chartDisplay.show();

        BarChart bar = new BarChart();
        chartDisplay.setChart(bar);
        chartDisplay.show();
    }
}

interface Comparable{
    int compareTo(Object other);
}
