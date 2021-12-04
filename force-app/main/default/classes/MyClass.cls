public class MyClass {
    public string message{set;get;}
    public MyClass() {
    message='calling from constructor';
    }
    
    public void foobar(){
       System.debug('am here!!');
       message = 'button clicked!!';
    }
    
}