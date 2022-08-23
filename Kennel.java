/**********************************************************************

 *Program Name:       Kennel/Moskal_Prog_5

 *Author:             Thomas Moskal

 *Date:               3/7/21

 *Course/Section:     CSC 112-302

 *Program Description: 

 *    This program will act as an array for the object Dog.  It will also have methods to adjust that array of objects.

 *Refined Algorithm:
   
*
Import libraries
Begin Class Kennel

   Instantiate scanner class
   
   Declare constants
      Declare MAX_DOGS as final private integer set to 20
   Declare variables
      Declare numDogs as integer
      Declare count as integer set to 0
      Declare rollCall as String
   Instantiate an array of object Dog as kennel[]
   
 Create public contructor public Kennel()
 Create public void addDog(String dogName, String dogBreed, int dogAge)
 Create public String method toString()
 Create private void moreDogs()
 Create public void toFile()
 Create public void fromFile()

 

 *********************************************************************/
import java.util.Scanner;
import java.util.StringTokenizer;
import java.io.*; 

public class Kennel    
{
            
            
Scanner scan = new Scanner(System.in);   
            
            
private final int MAX_DOGS = 20;          //Initial size of kennel array
private Dog kennel[] = new Dog [MAX_DOGS];  //Kennel array
private int numDogs;                      //Dogs in kennel
private int count = 0;                    //Counter for FOR loops
String rollCall;
   


//*******************   Kennel constructor

/*Method Prologue
      Name:                Kennel
      Author:              Thomas Moskal
      Date Written:        3/7/21
     
      Method Description:  Constructor method that instantiates with 0 dogs.
     
      Refined algorithm:
     
*
Begin Kennel constructor method
           
   Declare Kennel as public
           
   Set numDogs = 0 
           
End Kennel constructor
   
*/
//****************************************************************         
  
  
   public Kennel ()
   {
   numDogs = 0;      //Empty kennel
   }
  
  

//**************************************************************** 


   
//*******************   addDog method

/*Method Prologue
      Name:                addDog
      Author:              Thomas Moskal
      Date Written:        3/7/21
     
      Method Description:  method that takes a dogs name, breed and age as parameters and creates a new dog 
                              for the array.
     
      Refined algorithm:
     
*
Begin addDog method
           
   Declare addDog as public void w/ (String dogName, String dogBreed, int dogAge) parameters
   
      If array is full then
         call moreDogs() method
   
   add new dog to current array index
   set array index ++   
               
           
End addDog method
   
*/
//****************************************************************   
   public void addDog(String dogName, String dogBreed, int dogAge)
       {
       
       //Checks that array is not full. 
       if(numDogs == kennel.length)
         {
         //If array is full, moreDogs will increase its size
         moreDogs();   
         }
       
       //Adds new item to array.    
       kennel[numDogs] = new Dog(dogName, dogBreed, dogAge);
       
       //moves index counter up to next empty array index for next item to be added
       numDogs++;
             
             
       }//End addDog method  
       
//**************************************************************** 



//*******************   toString method

/*Method Prologue
      Name:                toString
      Author:              Thomas Moskal
      Date Written:        3/7/21
     
      Method Description:  toString method that returns a roll call of dogs in the kennel display
     
      Refined algorithm:
     
*Begin toString method
           
   Declare toString as public String method
           
      Reset count to 0
      
      Set rollCall with header strings 
      
      Begin For loop
        For count = 0; count < numDogs; count++
         Set rollCall to add kennel[count].toString()
        End For loop
         
      Return rollCall value    
      
      
      
*End toString method
   
*/
//**************************************************************** 
    
   
   public String toString()
   {
      //count reset
      count = 0;
      
      //Inventory headers
      rollCall = "\t\t*Kennel Roll Call*\n\n";
      
      rollCall += "\tPups in the pound: " + numDogs + "\n\n";
      
      
      //For loop to add all objects onto the inventory
      for(count = 0; count < numDogs; count++)
      {
         //Adds current index of kennel to rollCall
         rollCall += kennel[count].toString() + "\n";
      }
      
      //returns data in rollCall
      return rollCall;   
       
            
          
    }//end toString method      
        
          
//****************************************************************       


//*******************   moreDogs method

/*Method Prologue
      Name:                moreDogs
      Author:              Thomas Moskal
      Date Written:        3/7/21
     
      Method Description:  Method to increase the size of the array if it fills up completely
     
      Refined algorithm:
     
*Begin moreDogs method
           
           
     Declare moreDogs method as private void
     
         Set count to 0
         
         Create new array, double the size of the old array
         
         Enter For loop
            for count = 0, count < dogs.length, count ++
               oldKennel[count] = kennel[count]
         End For loop
         
        Set dogs = oldKennel
                     
      
*End moreDogs method
   
*/
//**************************************************************** 
    
    
   private void moreDogs()
   {
      //reset count in case this method is used multiple times 
      count = 0;  
      
      //Create new array of same data type at twice the older array's size
      Dog[] oldKennel = new Dog[kennel.length * 2];
   
      //for loop to transfer objects from one array to the other   
      for (count = 0; count < kennel.length; count++)
         {
            oldKennel[count] = kennel[count];
         }
      
      //Copy information of new array into the old array
      kennel = oldKennel;           
          
    }//end moreDogs method      
        
          
//****************************************************************




//*******************   toFile method

/*Method Prologue
      Name:                toFile
      Author:              Thomas Moskal
      Date Written:        3/7/21
     
      Method Description:  Method to hard write data to an external file.
     
      Refined algorithm:
     
*Begin toFile method

           
     Set try
           
     Declare toFile method as private void
     
         Set outPutFile to file to be written to
         Buffer: outPutFile to FileWriter as fileWrite
                 fileWrite to BufferedWriter as buffWrite
                 buffWrite to printWriter as outFile
                 
         Set String outLine to ""
         Enter for loop (int numPup = 0; numPup < numDogs; numPup++)
            fill outLine with Strings that hold kennel array data
            write next line until For loop ends
         
         Flush and close writing buffers
         
         End try   
         
         Set catch
            Get exception message
         End catch
                 
                     
      
*End toFile method

   
*/
//**************************************************************** 


public void toFile()
{

   try
   {
      
      //Name of file to open
      String outPutFile = "Kennel_Roll_Call.txt";   //file name
      
      //Open File
      FileWriter fileWrite = new FileWriter(outPutFile);
      
      //Buffer the output
      BufferedWriter buffWrite = new BufferedWriter (fileWrite);
      
      //Use print and println when writing to file
      PrintWriter outFile = new PrintWriter (buffWrite);
      
      //Line to write to file
      
      String outLine = "";
      
      //Send all dogs to file
      
      for (int numPup = 0; numPup < numDogs; numPup++)
      {
      
      //Create one line of dog info
      
      outLine = kennel [numPup].getName( ) + "," + kennel [numPup].getBreed( ) + "," + kennel [numPup].getAge( );
      
                             
         outFile.print(outLine);  //write line to file
         outFile.println();      //Go to next line
         outLine = "";           //Initialize line back to empty
      
      }//end for
      
                 //flush and close the output file
                 buffWrite.flush ();
                 buffWrite.close ();
      
      }//end try
      
            catch(IOException exception)   
            {
            System.out.println(exception.getMessage());
            }//end catch

}//end toFile
 
 
//****************************************************************  
 
 
 

//*******************   fromFile method

/*Method Prologue
      Name:                fromFile
      Author:              Thomas Moskal
      Date Written:        3/7/21
     
      Method Description:  Method to read hard written data from an external file.
     
      Refined algorithm:
     
*Begin fromFile method

Declare fromFile as public void
           
     Set try
      
         Set String inPutFile to text to be read from
         Set String line = ""
         Instantiate StringTokenizer as inLine
         
         Buffer: inPutFile to FileReader as fRead
                 fRead to BufferedReader as bRead
                 
         Set name as String
         Set breed as String
         Set tempAge as String
         Set age as integer
         
         if first line from file != null then
         Enter while loop
            Set string tokenizer delimiter to ","
         Set name as inLine.nextToken()          
         Set breed as inLine.nextToken()
         Set tempAge as inLine.nextToken()
            Set age = Integer.parseInt(tempAge)
         Call addDog to create a new dog in array
         Finish reading
         
         Close reading buffer bRead
      End try
      Set catch
         Get exception message
      End catch   
                    
                     
      
*End fromFile method

   
*/
//****************************************************************



public void fromFile()
{

      try
      {
      
            String inPutFile = "Kennel_Roll_Call.txt";     //file name
            String line = "";                              //line of data read from file
            StringTokenizer inLine;                        //tokenized string

            //open the input stream
            FileReader fRead = new FileReader(inPutFile);

            //buffer input stream one line at a time
            BufferedReader bRead = new BufferedReader (fRead);

            //Fields of Object Dog

            String name;
            String breed;
            String tempAge;
            int age;
            //Get data from file
            //read in the first line of the file

            line = bRead.readLine();

            while(line != null)
            {

                  //parse the new line using the comma as the delimiter
                  inLine = new StringTokenizer(line, ",");

                  //extract the title
                  name = inLine.nextToken();            

                  //extract the author
                  breed = inLine.nextToken();

                  //extract the type
                  tempAge = inLine.nextToken();
                  age = Integer.parseInt(tempAge);

                  //create a new dog
                  addDog (name, breed, age);

                  //get the next line in the external file
                  line = bRead.readLine();

            }//end while line not null
            //close the input file

            bRead.close ();

         }//end try

            catch(IOException exception)
            
            {
            System.out.println(exception.getMessage());
            }//end catch

}//end fromFile    
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

  }//END Kennel Class