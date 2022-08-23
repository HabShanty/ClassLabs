/**********************************************************************

 *Program Name:       Kennel_Driver/Moskal_Prog_5

 *Author:             Thomas Moskal

 *Date:               3/7/21

 *Course/Section:     CSC 112-302

 *Program Description: This program acts as a driver for the dog object array of Kennel class.
                        It also uses methods which read and write external files in order to save the kennel Roll Call list.

 *    

 *Initial Algorithm:

 *
 Import Scanner class
 Begin Kennel_Driver class
 Begin main method
 Declare variables
 Instantiate new Kennel as rollCall
 Read data from external file
 Set while loop
 Display menu prompt
 If menuNum = 1 then
   Prompt for Dog's information
   call addDog method to add a dog to roll call list
 Else If menuNum = 2 then
   Display rollCall toString
 Else If menuNum = 3 then
   Write to external file
   Ask user if they are sure  
 End program
 *
 
 Data Requirements:
 *******************
 
 Input Variables:
 
 *
  menu_Num as integer
  newName as String
  newBreed as String
  tempAge as String
  age as integer
  exit as character set to 'n'
 *
 
 
 Output Variables:
 
 *
 rollCall as Kennel
 *
 
 
 Additional Variables:
 
 *
  None
 *
 
 
 *Refined Algorithm
 
 
 *
 Import Scanner class
 
 Begin Kennel_Driver class
   Set as public class
   
 Begin main method
 
 Declare variables
   Declare menu_Num as integer
   Declare newName as String
   Declare newBreed as String
   Declare newAge as integer
   Declare exit as character set to 'n'
   
 Instantiate new Kennel as rollCall
 Read data from external file
   Call fromFile() from rollCall object
   
 Set while loop
   While exit = 'n' or 'N' then
   
    Display menu prompt
    If menuNum = 1 then
      Prompt for Dog's information
         Prompt for Dog's name
            Set input to newName
         Prompt for Dog's breed
            set input to newBreed
         Prompt for Dog's age
            set input to tempAge
            Set age to Parsed int from tempage
      call addDog method to add a dog to roll call list
    
    Else If menuNum = 2 then
        Display rollCall toString
            print rollCall
            
    Else If menuNum = 3 then
      Write to external file
         Call rollCall.toFile()
      Ask user if they are sure
      set input to exit
         if exit = y
            Break while loop
         Else if exit = n
            Go back to menu
            
              
 End class Kennel_Driver/Moskal_Prog_5
 *
 

 *********************************************************************/


import java.util.Scanner;


public class Kennel_Driver    

{

        public static void main (String[] args)  

        {
         
         Scanner scan = new Scanner(System.in);
         
         int menu_Num;        //for Menu selection
         String newName;      //Holds Dog's name to be written
         String newBreed;     //Holds Dog's breed to be written
         int newAge;          //Holds Dog's age to be written
         char exit = 'n';     //Sentinel to exit While loop & end program
          
          //Instantiation of the Kennel array
          Kennel rollCall = new Kennel();
          //Reading of external file to file array when program begins
          rollCall.fromFile();
 
          //UI 
          System.out.println("Welcome to the Moskal Kennel Roll Call List.");
         
         
         
          while(exit == 'n' || exit == 'N')
          {//begin while loop
         
               //Menu prompt
               System.out.print("Please select:\n\n1: Add a dog.\n2: View the Kennel Roll Call.\n3: Exit.\n");
               menu_Num = scan.nextInt();
               scan.nextLine(); //Needed after scanning an integer           
               System.out.println();
               
                       
               //If/else loop for menu
               //#1 Add a dog
               if(menu_Num == 1)
               {  
               
                  //Menu selection 1, fills variable to be sent to addItem method in order to create a new pantry item
                  System.out.println("Enter the new dog's name");
                  newName = scan.nextLine();              
                  System.out.println("Enter your dog's breed");
                  newBreed = scan.nextLine();
                  System.out.println("Enter the dog's age");
                  newAge = scan.nextInt();
                  scan.nextLine();
                  
                  
                  //Calls addDog method from Kennel 
                  rollCall.addDog(newName, newBreed, newAge);
               
               //End menuSelect 1
               }   
               
               
               //#2 See the list of dogs
               else if (menu_Num == 2)
               {
                  //Calls the toString of each dog of the array
                  System.out.println(rollCall);
               //End menuSelect 2
               }               
               
               
               //Third selection, exit program
               else if (menu_Num == 3)
               {
                  //Write list to external file "Kennel_Roll_Call.txt"
                  rollCall.toFile();
                  
                  //Prompt to exit, reads only the first character entered
                  System.out.println("Are you sure you wish to exit? Y/N");
                  exit = scan.next().charAt(0);
                  scan.nextLine();
                     
                }
                    
         
         }//end while loop 
              

      }//END main method

 

  }//END Kennel_Driver/Moskal_Prog_5 Class