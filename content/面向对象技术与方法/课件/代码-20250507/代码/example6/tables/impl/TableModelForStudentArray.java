package example6.tables.impl;

import example6.tables.Student;

import example6.tables.TableModel;

public class TableModelForStudentArray implements TableModel{
    private Student[] data;

    public TableModelForStudentArray(Student[] data){
        this.data=data;
    }

    public String getColName(int index) {
        switch(index){	//指定每列名称
            case 0: return "ID";
            case 1: return "NAME";
            case 2: return "GENDER";
            case 3: return "AGE";
        }
        return null;
    }

    public int getColNumber(){//指定列数
        return 4;
    }
    public int getRowNumber(){//行数：数组元素的个数
        return data.length;
    }
    public Object getValue(int row, int col){//row为数组下标
        switch(col){//由col定位获取对象的哪个数据成员
            case 0: return data[row].getId();
            case 1: return data[row].getName();
            case 2: return data[row].isGender()?"男":"女";
            case 3: return data[row].getAge();
        }
        return null;
    }
}
