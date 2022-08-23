// Thomas Moskal CSC221 Assignment 3 Xor cypher

import java.io.*;
import java.util.*;

public class Xor
{
   
   public static void main(String [] args)
   {//Begin main method

       Scanner scanner = new Scanner(System.in);
       
       String input;     
       String end_Result = "";
       int cypher = 0;          
       int count = 0;     
       int string_Size = 0;
       int orig_ascii = 0;
       char chacha = ' ';
       char operation_Pheonix_Char = ' ';
       int result = 0;
       
       System.out.print("Please enter a string! ");
       input = scanner.nextLine();
       string_Size = input.length();
       
       System.out.print("Enter a number from 1 - 255 to be the cypher key. ");
       cypher = scanner.nextInt();
       
       for (count = 0; count < string_Size; count ++)
       {
           chacha = input.charAt(count) ;    //Grab the next character
           orig_ascii = (int)chacha ;        //Cast it into an int for display
           result = cypher ^ chacha ;        //Use the bitwise Xor cyper
           operation_Pheonix_Char = (char)result;  //Cast the int into a char for display
               
           System.out.println( + chacha + " [" + orig_ascii + "] -> " + operation_Pheonix_Char  + " [" + result + "] ");
           
           end_Result = end_Result + operation_Pheonix_Char;
       }
       
       System.out.println("Result: " + end_Result);
    
    }
}

/*
Program Examples

  ----jGRASP exec: java Xor
 Please enter a string! Evil Morty
 Enter a number from 1 - 255 to be the cypher key. 14
 69 [69] -> K [75] 
 118 [118] -> x [120] 
 105 [105] -> g [103] 
 108 [108] -> b [98] 
 32 [32] -> . [46] 
 77 [77] -> C [67] 
 111 [111] -> a [97] 
 114 [114] -> | [124] 
 116 [116] -> z [122] 
 121 [121] -> w [119] 
 Result: Kxgb.Ca|zw
 
  ----jGRASP: operation complete.
 
  ----jGRASP exec: java Xor
 Please enter a string! Kxgb.Ca|zw
 Enter a number from 1 - 255 to be the cypher key. 14
 75 [75] -> E [69] 
 120 [120] -> v [118] 
 103 [103] -> i [105] 
 98 [98] -> l [108] 
 46 [46] ->   [32] 
 67 [67] -> M [77] 
 97 [97] -> o [111] 
 124 [124] -> r [114] 
 122 [122] -> t [116] 
 119 [119] -> y [121] 
 Result: Evil Morty
 
  ----jGRASP: operation complete.



*/