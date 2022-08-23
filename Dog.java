/**********************************************************************

 *Program Name:       Dog/Moskal_Prog_5

 *Author:             Thomas Moskal

 *Date:               3/7/21

 *Course/Section:     CSC 112-302

 *Program Description: 

 *    This program is a java class that will contain the information about a dog.
   This information will include breed, name and age.

*Refined Algorithm

Begin Dog class
 
 Declare constants
   Declare DOG_MULTI as final private integer = 7
 
 Declare variables
   Declare dogBreed as private String
   Declare dogName as private String
   Declare dogAge as private integer
   Declare peopleAge as public integer
   Declare description as public String
   

   
 Create contructor method Dog
 Create void method setBreed
 Create public String method getBreed
 Create void method setName
 Create public String method getName
 Create void method setAge
 Create public Integer method getAge
 Create public Integer method personYears
 Create public String method toString


End Dog class
 *********************************************************************/




public class Dog   //BEGIN Class Definition 
{//Begin class Dog

  
  
   final private int DOG_MULTI = 7; //Multipier to get dogs age in human years
      
   private String dogBreed;      //Breed of dog
   private String dogName;       //Name of dog
   private int dogAge;           //Age of dog     
   public int peopleAge;         //Dog's age in people years
   public String description;    //Holds a string with a description of Dog          
      
      
      
      

   //-----------------------------------------------------------------
   //  Constructor method Dog. Sets initial breed, name, and age, 
   //    of dog.
   //-----------------------------------------------------------------      
      public Dog (String name, String breed, int age)
      {//Begin Dog constructor
      
      
            dogBreed = breed ;
            dogName = name ; 
            dogAge = age ; 
         
      
      }//end Dog constructor      
      
      
      
   //-----------------------------------------------------------------
   //  public void method setBreed.   
   //   Sets the new breed type of dog.
   //-----------------------------------------------------------------      
      public void setBreed (String newBreed)
      {//Begin setBreed method
      
            //Change dog breed to new input
            dogBreed = newBreed;
            
            
      }//End setBreed method
      
      
      
      
   //-----------------------------------------------------------------
   //  public String method getBreed.   
   //   Returns the breed type of dog.
   //-----------------------------------------------------------------       
      public String getBreed()
      {//Begin getBreed method
      
      
            return dogBreed;
      
            
      }//Begin getBreed method
      
      
      
      
   //-----------------------------------------------------------------
   //  public void method setName.   
   //   Sets the new name of dog.
   //-----------------------------------------------------------------       
      public void setName (String newName)
      {//Begin setName Method
      
            //Change dog name to new name input
            dogName = newName;
            
            
      }//End setName Method
      
      
      
      
   //-----------------------------------------------------------------
   //  public String method getName.   
   //   Returns the name of dog.
   //-----------------------------------------------------------------       
      public String getName()
      {//Begin getName method
      
      
            return dogName;
            
            
      }//End getName method
      
      
      
      
   //-----------------------------------------------------------------
   //  public void method setAge.   
   //   Sets the new age of dog.
   //-----------------------------------------------------------------       
      public void setAge (int Age)
      {//Begin setAge method
      
            //Change dog's age to new age
            dogAge = Age;
            
            
      }//End setAge method
      
      
      
      
   //-----------------------------------------------------------------
   //  public integer method getAge.   
   //   Returns age of dog.
   //-----------------------------------------------------------------       
      public int getAge()
      {//Begin getAge method
      
            
            return dogAge;
            
            
      }//End getAge method
      
      
      
      
   //-----------------------------------------------------------------
   //  public integer method personYears.   
   //   Calculates and returns age of dog in human years.
   //-----------------------------------------------------------------        
      public int personYears()
      {//Begin personYears method
      
            //Multiply dog's age by 7
            peopleAge = dogAge * DOG_MULTI;
            return peopleAge;
            
            
      }//End personYears method
      
      
      
      
   //-----------------------------------------------------------------
   //  public String method toString.   
   //   Returns a description of the dog using all current variables.
   //-----------------------------------------------------------------        
      public String toString()
      {//Begin toString method
      
            peopleAge = dogAge * DOG_MULTI;
            description = dogName + " is a " + dogAge + " year(s) old " + dogBreed + ".\nIn people years, " + dogName + " is " + peopleAge + " years old!\n";
            return description;
            
            
      }//End toString method
      
                                        
                    
                    
             
}//END Dog/Moskal_Prog_5