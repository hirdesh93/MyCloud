global class Sample {     
    public List<Student> StudList {get;set;}   

    public Sample() {
        StudList = new List<Student>();
        Student s1 = new Student('Ganesh', 12);
        StudList.add(s1);
        
        Student s2 = new Student('Arun', 82);
        StudList.add(s2);
        
        Student s3 = new Student('Vignesh', 32);
        StudList.add(s3);
        
        Student s4 = new Student('Younis', 55);
        StudList.add(s4);     
        
        Student s5 = new Student('Azhar', 42);
        StudList.add(s3);   
        
        StudList.sort();
    }
    
    //wrapper class for Comparable Interface
    
    global class Student implements Comparable {
        global String StudentName {get;set;}    
        global Integer StudentAge {get; set;}
        
        global Student(String Name, Integer Age) {
            StudentName = Name;
            StudentAge = Age;
        }
        
        global Integer compareTo(Object ObjToCompare) {
            return StudentName.CompareTo(((Student)ObjToCompare).StudentName);
        }
    }
}