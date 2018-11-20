public class StackImplementation {
    
    String top = '';
    List<String> stackList;
    
    public StackImplementation(){
      stackList = new List<String>();   
    }
    
    public void push(String keyElement){
        stackList.add(keyElement);
        top = keyElement;
    }
    
    public String pop(){
        String topToBeRemoved = '';
        if(!stackList.isEmpty() && stackList.size() > 0){
          topToBeRemoved = stackList.get(stackList.size()-1);
            stackList.remove(stackList.size()-1);
            if(stackList.isEmpty())
              return('Stack is empty');
            else
                top = stackList.get(stackList.size()-1);            
        }
        else{
            return ('Stack is empty');
        }
        //return ('Top of stack Removed: ' + topToBeRemoved + 'Top of stack now:' + top);
        return top;
    }
    
    public String peek(){
        if(stackList.size()>0)
          return stackList.get(stackList.size()-1);
         else
            return 'Stack is empty';
    }
    
    public Boolean isEmpty(){
        return stackList.isEmpty();
    }

}