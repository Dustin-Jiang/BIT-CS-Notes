package example6.tables.impl;

import example6.tables.TableModel;

public class TableModelForStringArray implements TableModel{
    private String[][] data;

    public TableModelForStringArray(String[][] data){
        this.data=data;
    }

    public String getColName(int index){//每列的名字在二维数组的第一行中
        return data[0][index];
    }

    public int getColNumber(){//列数：二维数组每行的长度
        return data[0].length;
    }

    public int getRowNumber(){//行数：二维数组的总行数-1（去掉标题行）
        return data.length-1;
    }

    public Object getValue(int row, int col) {//数据：在row+1行(越过标题行),col列
        return data[row+1][col];
    }
}
